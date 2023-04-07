`timescale 1ns/100ps
module check_division_2
(
	input [31:0] data,
	output answer
);
	assign answer = ~(data[0]);
endmodule