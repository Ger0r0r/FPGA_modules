`timescale 1ns/100ps
module shift_register
(
	input	wire	clock,
	input	wire	reset,
	input	wire	button_left,
	input	wire	button_right,
	input	wire	switch_left,
	input	wire	switch_right,
	output	wire	[7:0]	led
);

reg [7:0] temp;

wire flag_right;
wire flag_left;

always @(posedge clock)
begin
	if (!reset)
		temp = 8'b00000000;
	else
	begin
		if (flag_left)
		begin
			temp[7:1] <= temp[6:0];
			temp[0] <= (switch_left) ? 1'b1 : 1'b0;
		end
		if (flag_right)
		begin
			temp[6:0] <= temp[7:1];
			temp[7] <= (switch_right) ? 1'b1 : 1'b0;
		end
	end
end

button_handler_down handler_left
(
	.clock(clock),
	.button_signal(button_left),
	.button_flag(flag_left)
);

button_handler_down handler_right
(
	.clock(clock),
	.button_signal(button_right),
	.button_flag(flag_right)
);

	assign led = temp;
endmodule