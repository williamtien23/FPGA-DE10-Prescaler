/**
	@file Prescale_Method_Test
	@author William Tien
	@brief Tutorial to show the difference when splitting a modules functionality
			 into inferred modules from code guides. Method 1 is code pulled from 
			 prescaler example online. Method 2 splits out the counter block used in
			 method 1 to be more explicit.

			 Method 1 uses 41 ALUTs, 26 Dedicated Logic Registers
			 Method 2 uses 34 ALUTs, 26 Dedicated Logic Registers
*/
/*
//Method 1
module Prescale_Method_Test (input in_clk, output led);


	wire out_clk;
	reg led_state = 0;
	assign led = led_state;
	
	Clock_divider U1 (in_clk, out_clk);
	 
	always @ (posedge out_clk)
	begin
		led_state = ~led_state;
	end

endmodule

module Clock_divider(clock_in, clock_out);//Prescale by 50M
	input clock_in; 
	output clock_out; 
	reg[25:0] counter=26'd0;
	parameter DIVISOR = 26'd50000000;

	always @(posedge clock_in)
	begin
		counter <= counter + 26'd1;
		if(counter>=(DIVISOR-1))
		  counter <= 26'd0;
	end
	assign clock_out = (counter<DIVISOR/2)?1'b0:1'b1;
endmodule
*/


//Method 2
module Prescale_Method_Test(input in_clk, output led);

	reg led_toggle;
	wire out_clk;
	assign led = led_toggle;
	
	Prescaler #(25, 25000000) U1 (in_clk, out_clk);
	
	
	always @ (posedge out_clk)
	begin
		led_toggle = ~led_toggle;
	end
	
endmodule


module Prescaler #(parameter WIDTH = 25, parameter CONDITION = 25000000)(input clk, output reg clock);
	
	wire [WIDTH-1:0] out_counter;
	wire reset;
	assign reset = (out_counter==CONDITION);
	
	binary_counter #(WIDTH) U2 (clk,1'b1,reset,out_counter);
	
	always @ (posedge reset)
		clock <= ~clock;
	
endmodule

//Code Guide Inference of Counter
module binary_counter
#(parameter WIDTH=25)
(
	input clk, enable, reset,
	output reg [WIDTH-1:0] count
);

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			count <= 0;
		else if (enable == 1'b1)
			count <= count + 1;
	end

endmodule
