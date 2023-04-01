`timescale 1ns/100ps
module decoder_3to8(
	input [2:0]step,
	output [7:0]answer
);
	assign answer = 1'b1<<step;

endmodule

module top;
reg	[3:0]data_in;
wire [7:0]data_out;
initial begin
	#50 data_in = 3'd2;
	#150 data_in = 3'd5;	
	#200$stop;
end

decoder_3to8
	test01(
		.step(data_in), 
		.answer(data_out)
	);

always begin
	#50
	$display("out = %b", data_out);
end
 
endmodule