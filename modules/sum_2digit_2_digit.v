`timescale 1ns/100ps
module sum_2digit_2_digit
(
	input	wire	clock,
	input	wire	reset,
	input	wire	button_sum,
	input	wire	[7:0]	switch_0,
	input	wire	[7:0]	switch_1,
	output	wire	[13:0]	digits_0,
	output	wire	[13:0]	digits_1,
	output	wire	[13:0]	digits_2,
	output	wire	overload
);

wire flag_sum;

button_handler_down handler_sum
(
	.clock(clock),
	.button_signal(button_sum),
	.button_flag(flag_sum)
);

reg [7:0] number_0;
reg [7:0] number_1;
reg [8:0] answer;

reg flag_overload;

always @(posedge clock)
begin
	number_0 <= switch_0;
	number_1 <= switch_1;
	if (!reset)
		answer = 9'b0;
	else
		answer <= (flag_sum) ? number_0 + number_1 : answer;
end

	assign overload = answer[8];

hex22digit handler_digits_0
(
	.hex(number_0),
	.digit_0(digits_0[6:0]),
	.digit_1(digits_0[13:7])
);
hex22digit handler_digits_1
(
	.hex(number_1),
	.digit_0(digits_1[6:0]),
	.digit_1(digits_1[13:7])
);
hex22digit handler_answer
(
	.hex(answer[7:0]),
	.digit_0(digits_2[6:0]),
	.digit_1(digits_2[13:7])
);

endmodule