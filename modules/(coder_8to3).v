`timescale 1ns/100ps
module coder(
	input [7:0]step,
	output [2:0]answer
);

	assign answer = {3{(step>>0) == 8'b1}} & 3'b000 |
					{3{(step>>1) == 8'b1}} & 3'b001 |
					{3{(step>>2) == 8'b1}} & 3'b010 |
					{3{(step>>3) == 8'b1}} & 3'b011 |
					{3{(step>>4) == 8'b1}} & 3'b100 |
					{3{(step>>5) == 8'b1}} & 3'b101 |
					{3{(step>>6) == 8'b1}} & 3'b110 |
					{3{(step>>7) == 8'b1}} & 3'b111;

endmodule

module top;

reg	[7:0]data_in = 8'b1;
wire [2:0]data_out;
reg [2:0]test[7:0];

always begin
	#2 
	data_in = data_in + 1'b1;
end

initial #1000$stop;

coder
	test01(
		.step(data_in), 
		.answer(data_out)
	);
 
endmodule