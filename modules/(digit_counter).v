`timescale 1ns/100ps
module hex2digit
(
	input	[0:0]	reset,
	input	[0:0]	clock,
	input	[0:0]	button_increase,
	input	[0:0]	button_decrease,
	output	[6:0]	digit
);

always @(posedge reset)
begin
	number = 7'b0000000;
end

reg [0:0] f_add;
reg [0:0] f_minus;

always @(posedge clock)
begin
	number <= (f_add) ? number + 1 : number;
	number <= (f_minus) ? number - 1 : number;
end

button_handler button_add
(
	.clock(clock),
	.button_signal(button_increase),
	.button_flag(f_add)
);
button_handler button_minus
(
	.clock(clock),
	.button_signal(button_decrease),
	.button_flag(f_minus)
);

reg [6:0] number;

hex2digit convert_number_to_digit
(
	.hex(number),
	.digit(digit)
)

endmodule