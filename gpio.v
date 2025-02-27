module gpio #(parameter length = 4) 
(
    input wire clk,               
    input wire rst,               

    
    input wire [length-1:0] gpio_dir,   // Direction for each pin (1: output, 0: input)
    input wire [length-1:0] gpio_write, // Data to be written to output pins
    output reg [length-1:0] gpio_read,  // Data read from input pins
    inout wire [length-1:0] gpio_pins   // Bidirectional GPIO pins for both input and output based on the direction set
);

    
    reg [length-1:0] gpio_data_out;    // Register to store the data that is sent to pin when pin is set as output
    reg [length-1:0] gpio_data_in;     // Register to store the data from the pin when pin is set as input

    // Separate internal signals to manage direction
    wire [length-1:0] gpio_pins_out; 
    wire [length-1:0] gpio_pins_in;

    // For setting the tri-state buffers
    genvar i; 
    generate  
        for (i = 0; i < length; i = i + 1) begin : gpio_pin_control
            assign gpio_pins[i] = gpio_dir[i] ? gpio_data_out[i] : 1'bz; 
            assign gpio_pins_in[i] = gpio_pins[i]; 
        end
    endgenerate

    // Sequential logic for data output and read
    integer j; 
    always @(posedge clk or negedge rst) begin
        if (!rst) begin 
            gpio_data_out <= {length{1'b0}}; 
            gpio_read <= {length{1'b0}}; 
        end 
        else begin
            for (j = 0; j < length; j = j + 1) begin
                gpio_data_out[j] <= gpio_write[j]; 
                gpio_read[j] <= gpio_pins_in[j];   
            end
        end
    end

endmodule
