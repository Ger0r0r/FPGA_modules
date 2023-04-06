`timescale 1ns/100ps
module led_counter
(
	input	wire	reset,
	input	wire	clock,
	input	wire	button_increase,
	input	wire	button_decrease,
	output	[7:0]	led
);

reg [6:0] number;

always @(posedge reset)
begin
	number = 8'b00000000;
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

decoder_3to8_full convert_number_to_led
(
	.value(number),
	.answer(led)
)

endmodule