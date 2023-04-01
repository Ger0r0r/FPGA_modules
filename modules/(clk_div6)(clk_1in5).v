`timescale 1ns/100ps

module clk_div(
input wire clk,
input wire reset,
output reg clk_div2,
output reg clk_div4,
output reg clk_div8
);

always @(posedge clk)
	if (reset)
		{clk_div2, clk_div4, clk_div8} <= 3'b000;
	else begin
		clk_div2 <= ~clk_div2;
		clk_div4 <= ~(clk_div2 ^ clk_div4);
		clk_div8 <= ~((clk_div4 | clk_div2) ^ clk_div8);	
end
endmodule

module clk_div_by_6(
	input wire clk,
	input wire reset,
	output reg clk_div6
);

reg [1:0]counter;

always @(posedge clk)
	if (reset)
		{clk_div6, counter} <= 3'b010;
	else begin
		counter <= (counter == 2'b10) ? 2'b0 : counter + 1'b1;
		clk_div6 <= (counter == 2'b10) ? ~clk_div6 : clk_div6;
	end
endmodule

module clk_1_in_5 (
	input wire clk,
	input wire reset,
	output wire clk_1of5
);

reg [2:0]counter;

always @(posedge clk)
	if (reset)
		{clk_1of5, counter} <= 4'b0100;
	else begin
		counter <= (counter == 3'b100) ? 3'b0 : counter + 1'b1;
	end

assign clk_1of5 <= (counter == 3'b100 || clk_1of5) ? ~clk_1of5 : clk_1of5;
endmodule

module top;
reg clk = 0;
always #1 clk = ~clk;
reg reset = 0;
initial begin
	@(posedge clk)
	reset <= 1;
	repeat(3) @(negedge clk);
	reset <= 0;
end

wire clk_div2;
wire clk_div4;
wire clk_div8;
wire clk_div6;
wire clk_1of5;
clk_div
	main_clk(
		.clk(clk),
		.reset(reset),
		.clk_div2(clk_div2),
		.clk_div4(clk_div4),
		.clk_div8(clk_div8)
	);
clk_div_by_6
	tesl_clk_1(
		.clk(clk),
		.reset(reset),
		.clk_div6(clk_div6)
	);
clk_1_in_5
	tesl_clk_2(
		.clk(clk),
		.reset(reset),
		.clk_1of5(clk_1of5)
	);
	

endmodule