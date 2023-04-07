`timescale 1ns/100ps
module button_handler_down
#(
	parameter INVERT = 1
)
(
	input	[0:0]	clock,
	input	[0:0]	button_signal,
	output	[0:0]	button_flag
);

reg [0:0] temp_1;
reg [0:0] temp_2;

always @(posedge clock)
begin
	temp_1 <= button_signal ^ INVERT;
	temp_2 <= temp_1; 
end

	assign button_flag = temp_2 & (~temp_1);
endmodule