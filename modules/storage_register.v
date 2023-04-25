`timescale 1ns/100ps
module storage_register
(
	input	wire	clock,
	input	wire	reset,
	input	wire	button_write,
	input	wire	button_save,
	input	wire	button_shift,
	input	wire	switch_value,
	input	wire	[7:0]	switch,
	output	wire	[7:0]	led_R,
	output	wire	[7:0]	led_G,
	output	wire	[6:0]	digit_0,
	output	wire	[6:0]	digit_1
);

wire flag_write;
wire flag_shift;
wire flag_save;

button_handler_down handler_shift
(
	.clock(clock),
	.button_signal(button_shift),
	.button_flag(flag_shift)
);

button_handler_down handler_write
(
	.clock(clock),
	.button_signal(button_write),
	.button_flag(flag_write)
);

button_handler_down handler_save
(
	.clock(clock),
	.button_signal(button_save),
	.button_flag(flag_save)
);

reg [15:0]temp_bus;
reg [0:0]flag_change;

always @(posedge clock)
begin
	if (!reset)
		temp_bus[15:0] <= 16'b0;
	else
	begin
		temp_bus[15:8] <= (flag_write) ? switch[7:0] : temp_bus[15:8]; 
		if (flag_shift)
		begin
			temp_bus[7:0] <= temp_bus[15:8];
		end
	end
end

	assign led_R[7:0] = temp_bus[15:8];
	assign led_G[7:0] = temp_bus[7:0];

reg [7:0]hex;

always @(posedge clock)
begin
	if (!reset)
		hex = 8'b00000000; 
	else
	begin
		hex <= (flag_save) ? switch : hex;
	end
end

hex2digit_hex handler_digit_0
(
	.hex(hex[7:4]),
	.digit(digit_0)
);
hex2digit_hex handler_digit_1
(
	.hex(hex[3:0]),
	.digit(digit_1)
);
endmodule