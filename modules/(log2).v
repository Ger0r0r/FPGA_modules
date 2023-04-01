`timescale 1ns/100ps
module log_2(
	input [7:0]step,
	output [2:0]answer
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

module top;
reg	[7:0]data_in;
wire [2:0]data_out;
initial begin
	#50 data_in = 8'd2;
	#150 data_in = 8'd64;	
	#200$stop;
end

log_2
	test01(
		.step(data_in), 
		.answer(data_out)
	);

always begin
	#50
	$display("out = %b", data_out);
end
 
endmodule