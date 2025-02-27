`timescale 1ns/1ps 
`include "gpio.v"

module gpio_tb;

  parameter length = 4; 

  
  reg clk;
  reg rst;
  reg [length-1:0] gpio_dir;
  reg [length-1:0] gpio_write;
  wire [length-1:0] gpio_read;
  wire [length-1:0] gpio_pins;


  gpio #(length) 
  uut (
    .clk(clk),
    .rst(rst),
    .gpio_dir(gpio_dir),
    .gpio_write(gpio_write),
    .gpio_read(gpio_read),
    .gpio_pins(gpio_pins)
  );


  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end


  initial begin
    // Initialize
    rst = 1;
    gpio_dir = 4'b0000;
    gpio_write = 4'b0000;


    #10;
    rst = 0;
    #10;
    rst = 1;

    // Case 1: Set all GPIO pins as outputs and write data
    #10;
    gpio_dir = 4'b1111;
    gpio_write = 4'b1010;
    #10;
    $display("GPIO pins after setting as output and writing data: %b", gpio_pins);
    $display("GPIO read after writing data: %b", gpio_read);

    // Case 2: Set all GPIO pins as inputs and read data
    #10;
    gpio_dir = 4'b0000;
    #10;
    $display("GPIO pins after setting as input: %b", gpio_pins);
    $display("GPIO read after setting as input: %b", gpio_read);

    // Case 3: Mixed direction control
    #10;
    gpio_dir = 4'b0101;
    gpio_write = 4'b1100;
    #10;
    $display("GPIO pins after mixed direction control: %b", gpio_pins);
    $display("GPIO read after mixed direction control: %b", gpio_read);

    // Case 4: Set all GPIO pins as outputs and write data
    #10;
    gpio_dir = 4'b1111;
    gpio_write = 4'b0101;
    #10;
    $display("GPIO pins after writing different data: %b", gpio_pins);
    $display("GPIO read after writing different data: %b", gpio_read);

    // Case 5: Reset 
    #10;
    rst = 0;
    #10;
    $display("GPIO pins after reset: %b", gpio_pins);
    $display("GPIO read after reset: %b", gpio_read);
    rst = 1;

    // Case 6: Mixed direction control
    #10;
    gpio_dir = 4'b1010;
    gpio_write = 4'b0011;
    #10;
    $display("GPIO pins with alternating directions and data: %b", gpio_pins);
    $display("GPIO read with alternating directions and data: %b", gpio_read);

    #10;
    $stop;
  end

  initial begin
    $dumpfile("gpio_tb.vcd");
    $dumpvars(0, gpio_tb);
  end   

endmodule
