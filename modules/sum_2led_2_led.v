`timescale 1ns/100ps
module sum_2led_2_led
(
	input	wire	clock,
	input	wire	reset,
	input	wire	button_sum,
	input	wire	[7:0]	switch_0,
	input	wire	[7:0]	switch_1,
	output	wire	[7:0]	led_0,
	output	wire	[7:0]	led_1,
	output	wire	[7:0]	led_2
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
reg [7:0] answer;

always @(posedge clock)
begin
	number_0 <= switch_0;
	number_1 <= switch_1;
	if (!reset)
		answer = 8'b0;
	else
		answer <= (flag_sum) ? number_0 + number_1 : answer;
end

	assign led_0 = switch_0;
	assign led_1 = switch_1;
	assign led_2 = answer;
endmodule