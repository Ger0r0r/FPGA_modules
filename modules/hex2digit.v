`timescale 1ns/100ps
module hex2digit_hex
#(
	parameter INVERT = 1
)
(
	input	wire	[3:0]	hex,
	output	wire	[6:0]	digit
);

	wire [6:0] temp;
	assign temp =  ({7{hex == 4'h0}} & 7'b1000000 |
					{7{hex == 4'h1}} & 7'b1111001 |
					{7{hex == 4'h2}} & 7'b0100100 |
					{7{hex == 4'h3}} & 7'b0110000 |
					{7{hex == 4'h4}} & 7'b0011001 |
					{7{hex == 4'h5}} & 7'b0010010 |
					{7{hex == 4'h6}} & 7'b0000010 |
					{7{hex == 4'h7}} & 7'b1111000 |
					{7{hex == 4'h8}} & 7'b0000000 |
					{7{hex == 4'h9}} & 7'b0010000 |
					{7{hex == 4'hA}} & 7'b0001000 |
					{7{hex == 4'hB}} & 7'b0000011 | 
					{7{hex == 4'hC}} & 7'b1000110 |
					{7{hex == 4'hD}} & 7'b0100001 | 
					{7{hex == 4'hE}} & 7'b0000110 |
					{7{hex == 4'hF}} & 7'b0001110);

	assign digit = (INVERT) ? temp : ~temp;
endmodule

module hex22digit_hex
#(
	parameter INVERT = 1
)
(
	input	wire	[7:0]	hex,
	output	wire	[6:0]	digit_0,
	output	wire	[6:0]	digit_1
);

hex2digit_hex 
#(
	.INVERT(INVERT)
) h_digit_0
(
	.hex(hex[3:0]),
	.digit(digit_0)
);

hex2digit_hex 
#(
	.INVERT(INVERT)
) h_digit_1
(
	.hex(hex[7:4]),
	.digit(digit_1)
);
endmodule

module hex2digit_dec
#(
	parameter INVERT = 1
)
(
	input	wire	[3:0]	hex,
	output	wire	[6:0]	digit
);
	wire [6:0] temp;
	assign temp =  ({7{hex == 4'd0}} & 7'b1000000 |
					{7{hex == 4'd1}} & 7'b1111001 |
					{7{hex == 4'd2}} & 7'b0100100 |
					{7{hex == 4'd3}} & 7'b0110000 |
					{7{hex == 4'd4}} & 7'b0011001 |
					{7{hex == 4'd5}} & 7'b0010010 |
					{7{hex == 4'd6}} & 7'b0000010 |
					{7{hex == 4'd7}} & 7'b1111000 |
					{7{hex == 4'd8}} & 7'b0000000 |
					{7{hex == 4'd9}} & 7'b0010000);

	assign digit = (INVERT) ? temp : ~temp;
endmodule

module hex22digit_dec
#(
	parameter INVERT = 1
)
(
	input	wire	[7:0]	hex,
	output	wire	[6:0]	digit_0,
	output	wire	[6:0]	digit_1
);

hex2digit_dec
#(
	.INVERT(INVERT)
) d_digit_0
(
	.hex(hex[3:0]),
	.digit(digit_0)
);

hex2digit_dec
#(
	.INVERT(INVERT)
) d_digit_1
(
	.hex(hex[7:4]),
	.digit(digit_1)
);
endmodule