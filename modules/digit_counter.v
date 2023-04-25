`timescale 1ns/100ps
module digit_counter
(
	input	[0:0]	reset,
	input	[0:0]	clock,
	input	[0:0]	button_increase,
	input	[0:0]	button_decrease,
	output	[3:0]	digit
);

reg [3:0] number;

wire [0:0] f_add;
wire [0:0] f_minus;
wire [0:0] f_reset;

always @(posedge clock)
begin
	if (f_reset)
		number <= 4'b0000;
	else 
		number <= number + f_add - f_minus;
end

button_handler_down button_reset
(
	.clock(clock),
	.button_signal(reset),
	.button_flag(f_reset)
);
button_handler_down button_add
(
	.clock(clock),
	.button_signal(button_increase),
	.button_flag(f_add)
);
button_handler_down button_minus
(
	.clock(clock),
	.button_signal(button_decrease),
	.button_flag(f_minus)
);

hex2digit_hex convert_number_to_digit
(
	.hex(number),
	.digit(digit)
);

endmodule