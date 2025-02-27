# GPIO

#Description:
This project implements a General Purpose Input Output (GPIO) Controller in Verilog, designed to handle bidirectional data flow across configurable pins. Each pin can be dynamically set as either input or output, allowing flexible use in embedded systems, microcontrollers, and FPGA projects.

#Features:
1. Supports configurable pin direction for each individual GPIO pin.
2. Tri-state buffer implementation for handling bidirectional data flow.
3. Synchronous design using clock and reset signals.
4. Data read-back capability to capture input pin states.
5. Parameterized design allowing customization of GPIO length.

# Module Ports:
1. clk -> Input - System clock
2. rst ->	Input	- Active-low reset
3. gpio_dir	-> Input	- Pin direction: 1 for output, 0 for input
4. gpio_write	-> Input - Data to write to output pins
5. gpio_read	-> Output	- Data read from input pins
6. gpio_pins	-> Inout	- Actual bidirectional GPIO pins

#Operation:
1. On reset, all outputs are initialized to 0.
2. Each pin's direction is controlled by gpio_dir — output when 1, input when 0.
3. For output pins, data comes from gpio_write.
4. For input pins, data is captured into gpio_read.
