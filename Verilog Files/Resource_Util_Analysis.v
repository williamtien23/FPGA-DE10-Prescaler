module Resource_Util_Analysis (output [6:0] sseg_1, output [6:0] sseg_2, output [6:0] sseg_3, input i_clk);

	wire out_clk;
	wire [7:0] out_counter;
	wire [11:0] stream;
	
	Prescaler #(25, 25000000) 	U1 (i_clk, out_clk);	
	binary_counter #(8) 			U2 (out_clk,1'b1,1'b0,out_counter);
	
	Encoder_BCD_3 	U3 (stream, out_counter);
	Decoder_7seg 	U4 (sseg_1, stream[3:0]);
	Decoder_7seg 	U5 (sseg_2, stream[7:4]);
	Decoder_7seg 	U6 (sseg_3, stream[11:8]);

endmodule