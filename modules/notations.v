`timescale 1ns/100ps
module notations
(
	input	wire	clock,
	input	wire	reset,
	input	wire	calculate,
	input	wire	[7:0]	switchers,

	output	wire	overload,
	output	wire	[13:0]	dec_digits,
	output	wire	[13:0]	hex_digits,
	output	wire	[7:0]	led
);

assign led = switchers;

wire flag;
reg [7:0] temp;
reg [7:0] display;

always @(posedge clock)
begin
	if (!reset)
		temp = 8'b00000000;
	else
	begin
		if (flag)
		begin
			temp <= switchers;
		end
	end
end

always @(posedge clock)
begin
	if (temp[3:0] >= 4'b1010) 
	begin
		if (temp[7:4] + 1'b1 >= 4'b1010) 
		begin
			assign overload = 1'b1;
			display <= temp[7:0] - 8'b10011010;
		end
		else
		begin
			assign overload = 1'b0;
			display <= temp[7:0] - 8'b00000110;
		end
	end
	else
	begin
		if (temp[7:4] >= 4'b1010) 
		begin
			assign overload = 1'b1;
			display <= temp[7:0] - 8'b10100000;
		end
		else
		begin
			assign overload = 1'b0;
		end
	end
end

hex22digit_hex show_hex
(
	.hex(temp),
	.digit_0(hex_digits[13:7]),
	.digit_1(hex_digits[6:0])
);

hex22digit_dec show_dec
(
	.hex(display),
	.digit_0(hex_digits[13:7]),
	.digit_1(hex_digits[6:0])
);

button_handler_down calculation
(
	.clock(clock),
	.button_signal(calculate),
	.button_flag(flag)
);
endmodule