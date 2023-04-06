`timescale 1ns/100ps
module coder
#(
	parameter VECT_W = 8,
)
(
	input	[VECT_W-1:0]	step,
	output	[size-1:0]		answer
);

localparam size = $clog2(VECT_W);

wire [VECT_W-1:0]volume;
wire [BIN_W-1:0]tmp[VECT_W-1:0];

genvar Gi;

generate for (Gi = 0; Gi < VECT_W; Gi = Gi + 1) 
begin: loop1
	if(Gi == 0) assign volume[VECT_W-Gi-1] = step[VECT_W-Gi-1];
	else assign volume[VECT_W-Gi-1] = step[VECT_W-Gi-1] | volume[VECT_W - Gi];
end
endgenerate

generate for (Gi = 0; Gi < VECT_W; Gi = Gi + 1) 
begin: loop2
	if(Gi == 0) assign tmp[Gi] = volume[Gi];
	else assign tmp[Gi] = tmp[Gi-1] + volume[Gi];
end
endgenerate

	assign answer = tmp[VECT_W-1];

endmodule