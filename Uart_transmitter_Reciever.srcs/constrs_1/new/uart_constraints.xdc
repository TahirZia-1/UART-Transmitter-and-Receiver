# XDC constraints for UART implementation
# Modify pin assignments according to your specific FPGA board

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Reset signal (connect to a push button)
set_property PACKAGE_PIN U18 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

# UART RX and TX pins
# Connect to USB-to-UART bridge or similar
set_property PACKAGE_PIN B18 [get_ports rx]  # Change for your board
set_property IOSTANDARD LVCMOS33 [get_ports rx]

set_property PACKAGE_PIN A18 [get_ports tx]  # Change for your board
set_property IOSTANDARD LVCMOS33 [get_ports tx]

# User interface pins (for testing)
# Use on-board switches for tx_data
set_property PACKAGE_PIN V17 [get_ports {tx_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[0]}]
set_property PACKAGE_PIN V16 [get_ports {tx_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[1]}]
set_property PACKAGE_PIN W16 [get_ports {tx_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[2]}]
set_property PACKAGE_PIN W17 [get_ports {tx_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[3]}]
set_property PACKAGE_PIN W15 [get_ports {tx_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[4]}]
set_property PACKAGE_PIN V15 [get_ports {tx_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[5]}]
set_property PACKAGE_PIN W14 [get_ports {tx_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[6]}]
set_property PACKAGE_PIN W13 [get_ports {tx_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_data[7]}]

# Use a button for tx_start
set_property PACKAGE_PIN T18 [get_ports tx_start]
set_property IOSTANDARD LVCMOS33 [get_ports tx_start]

# Use an LED for tx_busy indication
set_property PACKAGE_PIN U16 [get_ports tx_busy]
set_property IOSTANDARD LVCMOS33 [get_ports tx_busy]

# Use LEDs for rx_data visualization
set_property PACKAGE_PIN U19 [get_ports {rx_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[0]}]
set_property PACKAGE_PIN E19 [get_ports {rx_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[1]}]
set_property PACKAGE_PIN U16 [get_ports {rx_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[2]}]
set_property PACKAGE_PIN U15 [get_ports {rx_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[3]}]
set_property PACKAGE_PIN W18 [get_ports {rx_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[4]}]
set_property PACKAGE_PIN V19 [get_ports {rx_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[5]}]
set_property PACKAGE_PIN U19 [get_ports {rx_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[6]}]
set_property PACKAGE_PIN L16 [get_ports {rx_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_data[7]}]

# Use an LED for rx_done indication
set_property PACKAGE_PIN E16 [get_ports rx_done]
set_property IOSTANDARD LVCMOS33 [get_ports rx_done]
