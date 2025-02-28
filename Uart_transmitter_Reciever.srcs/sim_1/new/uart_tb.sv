`timescale 1ns / 1ps

module uart_tb();
    // Parameters
    parameter CLK_PERIOD = 10;  // 10ns (100MHz clock)
    parameter BAUD_RATE = 115200;
    parameter BIT_PERIOD = 1000000000 / BAUD_RATE;  // In ns
    
    // Testbench signals
    reg clk;
    reg reset_n;
    reg rx;
    wire tx;
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_done;
    
    // Instantiate UART module
    uart_top #(
        .CLOCK_FREQ(100000000),
        .BAUD_RATE(BAUD_RATE)
    ) uart_dut (
        .clk(clk),
        .reset_n(reset_n),
        .rx(rx),
        .tx(tx),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Test sequence
    initial begin
        // Initialize
        reset_n = 0;
        rx = 1;
        tx_data = 0;
        tx_start = 0;
        
        // Release reset
        #100;
        reset_n = 1;
        #100;
        
        // Test transmitter
        tx_data = 8'hA5;  // Test pattern
        #100;
        tx_start = 1;
        #20;
        tx_start = 0;
        
        // Wait for transmission to complete
        wait(!tx_busy);
        #(BIT_PERIOD*2);
        
        // Test receiver - loop TX to RX in testbench for a loopback test
        @(posedge tx_busy);
        
        // Monitor TX and connect to RX with a delay
        fork
            begin
                // Wait for start bit
                wait(tx == 0);
                rx = 0;  // Start bit
                #BIT_PERIOD;
                
                // Capture 8 data bits
                for (int i = 0; i < 8; i++) begin
                    rx = tx;  // Sample TX and feed to RX
                    #BIT_PERIOD;
                end
                
                rx = 1;  // Stop bit
                #BIT_PERIOD;
            end
        join
        
        // Wait for receive complete
        wait(rx_done);
        
        // Check received data
        if (rx_data == 8'hA5)
            $display("TEST PASSED: Received data 0x%h matches sent data", rx_data);
        else
            $display("TEST FAILED: Received data 0x%h does not match sent data 0x%h", rx_data, tx_data);
        
        // Additional test with different data
        #(BIT_PERIOD*5);
        tx_data = 8'h3C;
        #100;
        tx_start = 1;
        #20;
        tx_start = 0;
        
        // Wait for transmission to complete
        wait(!tx_busy);
        #1000;
        
        $finish;
    end
    
    // Monitor TX activity
    initial begin
        $monitor("Time: %t, TX: %b, RX: %b, TX_Busy: %b, RX_Done: %b, RX_Data: 0x%h", 
                 $time, tx, rx, tx_busy, rx_done, rx_data);
    end

endmodule