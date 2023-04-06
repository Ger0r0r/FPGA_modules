`timescale 1ns/100ps
module log2_4_8bit
(
	input	[7:0]	step,
	output	[2:0]	answer
);
	assign answer = {3{(step[0])}} & 3'b000 |
					{3{(step[1])}} & 3'b001 |
					{3{(step[2])}} & 3'b010 |
					{3{(step[3])}} & 3'b011 |
					{3{(step[4])}} & 3'b100 |
					{3{(step[5])}} & 3'b101 |
					{3{(step[6])}} & 3'b110 |
					{3{(step[7])}} & 3'b111;
endmodule