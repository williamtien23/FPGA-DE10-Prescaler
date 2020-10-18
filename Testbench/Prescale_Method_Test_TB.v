`timescale 1ns/1ps
module Prescale_Method_Test_TB();

	reg clk;
	wire temp2;
	Prescale_Method_Test DUT (clk,temp2);
	
	always
	begin
		clk = 0;
		#10;
		clk = 1;
		#10;
	end

endmodule