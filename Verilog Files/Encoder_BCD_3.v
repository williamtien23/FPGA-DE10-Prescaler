/**
	@file : Encoder_BCD_3.v
	@author: William Tien
	@brief : Tutorial to show how optimized IP cores for division is more space 
				efficient than primitive operations like division, modulus
				div cores used 59 ALUTs
				manual method used 146 ALUTs
*/
	
module Encoder_BCD_3(output reg [11:0] BCD, input [7:0] BinaryInput);


	wire [7:0] quotient100;
	wire [7:0] remainder100;
	wire [7:0] quotient10;
	wire [7:0] remainder10;

//uncomment one of the following blocks to test	
	// Div Cores
	
	div_core test (8'd100, BinaryInput, quotient100, remainder100);
	div_core test2 (8'd10, remainder100, quotient10, remainder10);
	
	
	/*// Manual
	
	assign quotient100 = BinaryInput/'d100;
	assign remainder100 = BinaryInput%'d100;
	assign quotient10 = remainder100/'d10;
	assign remainder10 = BinaryInput%'d10;
	*/
	
	
	always @ (BinaryInput)
		begin
		
			BCD[11:8] = quotient100;
			BCD [7:4] = quotient10;
			BCD [3:0] = remainder10;
			
		end
		
endmodule