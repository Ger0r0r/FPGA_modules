module hex2digit
(
	input	[3:0]	hex,
	input reset,
	output	[6:0]	digit
);

assign digit = 	{7{hex == 7'h0}} & 7'b1000000 |
				{7{hex == 7'h1}} & 7'b1111001 |
				{7{hex == 7'h2}} & 7'b1011011 |
				{7{hex == 7'h3}} & 7'b1001111 |
				{7{hex == 7'h4}} & 7'b0011001 |
				{7{hex == 7'h5}} & 7'b0010010 |
				{7{hex == 7'h6}} & 7'b0000010 |
				{7{hex == 7'h7}} & 7'b1111000 |
				{7{hex == 7'h8}} & 7'b0000000 |
				{7{hex == 7'h9}} & 7'b0010000 |
				{7{hex == 7'hA}} & 7'b0001000 |
				{7{hex == 7'hB}} & 7'b0000011 | 
				{7{hex == 7'hC}} & 7'b1000110 |
				{7{hex == 7'hD}} & 7'b0100001 | 
				{7{hex == 7'hE}} & 7'b0001110 |
				{7{hex == 7'hF}} & 7'b0000110;

endmodule

module fpga_test(
	input 	wire 	button,
	input  	clk,
	output 	wire	[6:0]digit
);

reg button_p, button_u;
reg push;
reg [3:0] counter;
wire [7:0] bus;

always @(posedge clk) begin
	button_p = ~button;
	button_u <= button_p;
	push <= button_u & ~button_p;
end

always @(posedge clk) begin
	if (push) begin
		counter <= counter + 1;
	end
end

hex2digit first_digit(
	.hex(counter),
	.digit(bus)
);

endmodule 