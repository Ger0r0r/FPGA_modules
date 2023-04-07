`timescale 1ns/100ps
module check_between
(
	input	[15:0]	number,
	output	[15:0]	answer
);

	assign answer = number[0]  + 
					number[2]  + 
					number[4]  + 
					number[6]  + 
					number[8]  +  
					number[10] + 
					number[12] + 
					number[14] +
					((number[1]  + 
					  number[3]  + 
					  number[5]  + 
					  number[7]  + 
					  number[9]  + 
					  number[11] + 
					  number[13] + 
					  number[15])<<1);
endmodule

module check_division_by_3
(
	input [15:0] number,
	output answer
);

wire [15:0] w_between1;
wire [15:0] w_between2;
wire [15:0] w_between3;

check_between check_1
(
	.number(number),
	.answer(w_between1)
);

check_between check_2
(
	.number(w_between1),
	.answer(w_between2)
);

check_between check_3
(
	.number(w_between2),
	.answer(w_between3)
);

	assign answer = ((w_between3 == 16'd0)  | 
					 (w_between3 == 16'd3));
endmodule