`timescale 1ns/100ps
module decoder_3to8
(
	input	[2:0]	step,
	output	[7:0]	answer
);
	assign answer = 1'b1<<step;

endmodule