`timescale 1ns/100ps
module button_handler
(
	input	[0:0]	clock,
	input	[0:0]	button_signal,
	output	[0:0]	button_flag
);

reg [0:0] temp_1;
reg [0:0] temp_2;

always @(posedge clock)
begin
	temp_1 = button_signal;
	temp_2 <= temp_1; 
	assign button_flag <= temp_2 & (~temp_1);
end
endmodule