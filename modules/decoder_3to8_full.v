`timescale 1ns/100ps
module decoder_3to8_full
(
	input	[2:0]	value,
	output	[7:0]	answer
);
	assign answer = ({8{value == 3'b000}} & 8'b00000001) |
					({8{value == 3'b001}} & 8'b00000011) |
					({8{value == 3'b010}} & 8'b00000111) |
					({8{value == 3'b011}} & 8'b00001111) |
					({8{value == 3'b100}} & 8'b00011111) |
					({8{value == 3'b101}} & 8'b00111111) |
					({8{value == 3'b110}} & 8'b01111111) |
					({8{value == 3'b111}} & 8'b11111111);
endmodule