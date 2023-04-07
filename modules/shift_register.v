`timescale 1ns/100ps
module shift_register
(
	input	wire	clock,
	input	wire	reset,
	input	wire	button_left,
	input	wire	button_right,
	input	wire	switch_left,
	input	wire	switch_right,
	output	wire [7:0]	led
);

reg [7:0] temp;
reg [7:0] temp_wire;
reg [2:0] shift;

always @(posedge clock) 
begin
	temp_wire <=	{8{shift == 3'b111}} & {temp[1],temp[2],temp[3],temp[4],temp[5],temp[6],temp[7],temp[0]} |
						{8{shift == 3'b110}} & {temp[2],temp[3],temp[4],temp[5],temp[6],temp[7],temp[0],temp[1]} |
						{8{shift == 3'b101}} & {temp[3],temp[4],temp[5],temp[6],temp[7],temp[0],temp[1],temp[2]} |
						{8{shift == 3'b100}} & {temp[4],temp[5],temp[6],temp[7],temp[0],temp[1],temp[2],temp[3]} |
						{8{shift == 3'b011}} & {temp[5],temp[6],temp[7],temp[0],temp[1],temp[2],temp[3],temp[4]} |
						{8{shift == 3'b010}} & {temp[6],temp[7],temp[0],temp[1],temp[2],temp[3],temp[4],temp[5]} |
						{8{shift == 3'b001}} & {temp[7],temp[0],temp[1],temp[2],temp[3],temp[4],temp[5],temp[6]} |
						{8{shift == 3'b000}} & temp;
end

always @(posedge clock)
begin
	if (!reset)
		temp = 8'b00000000;
	else
	begin
		temp[shift] <= (flag_right) ? switch_right : temp[shift];
		temp[shift] <= (flag_left) ? switch_left : temp[shift];
	end
end

wire flag_right;
wire flag_left;

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

always @(posedge clock)
begin
	shift = shift + flag_right - flag_left;
end

	assign led = temp_wire;
endmodule