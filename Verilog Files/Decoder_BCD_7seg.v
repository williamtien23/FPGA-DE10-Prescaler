module Decoder_7seg (output reg [6:0] out, input [3:0] in );

wire A,B,C,D;
assign A = in[3];
assign B = in[2];
assign C = in[1];
assign D = in[0];

always @ (A,B,C,D)
	begin
		out[6] = ~ (A | C | B&D | ~B&~D);
		out[5] = ~ (~B | ~C&~D | C&D);
		out[4] = ~ (B | ~C | D);
		out[3] = ~ (~B&~D | C&~D | B&~C&D | ~B&C | A);
		out[2] = ~ (~B&~D | C&~D);
		out[1] = ~ (A | ~C&~D | B&~C | B&~D);
		out[0] = ~ (A | B&~C | ~B&C | C&~D);
	end

endmodule