`timescale 1ns/100ps
module check_division_2(
	input [31:0] data,
	output answer
);
	assign answer = ~(data[0]);

endmodule

module top;
reg	[31:0]data_in;
wire data_out;
initial begin
	#50 data_in = 32'd12;
	#150 data_in = 32'd7;	
	#1000$stop;
end

check_division_2
	test01(
		.data(data_in), 
		.answer(data_out)
	);

always begin
	#10
	$display("out = %b", data_out);
end
 
endmodule