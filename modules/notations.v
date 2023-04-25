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

wire flag;
reg [20:0] temp;
reg [7:0] display;

assign led = switchers;
assign overload = temp[20];

always @(posedge clock)
begin
	if (!reset)
	begin
		temp[20:0] <= 21'b0;
		display[7:0] <= 8'b0;
	end
	else
	begin
		if (flag)
		begin
			temp[7:0] <= switchers;
			display[7:0] <= switchers;
		end
		else
		begin
			if (temp[19:16] > 4'b0) temp[20] <= 1'b1;
			else 					temp[20] <= 1'b0;

			if (temp[7:0] != 8'b0) 
			begin
				if (temp[11:8] >= 4'b0101) temp[11:8] <= temp[11:8] + 4'b0011;
				if (temp[15:12] >= 4'b0101) temp[15:12] <= temp[15:12] + 4'b0011;
				if (temp[19:16] >= 4'b0101) temp[19:16] <= temp[19:16] + 4'b0011;
				temp[19:0] <= {temp[18:0], 1'b0};
			end
		end
	end
end

hex22digit_hex show_hex
(
	.hex(display),
	.digit_0(hex_digits[13:7]),
	.digit_1(hex_digits[6:0])
);

hex22digit_dec show_dec
(
	.hex(temp[15:8]),
	.digit_0(dec_digits[13:7]),
	.digit_1(dec_digits[6:0])
);

button_handler_down calculation
(
	.clock(clock),
	.button_signal(calculate),
	.button_flag(flag)
);
endmodule