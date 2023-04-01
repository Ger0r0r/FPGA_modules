`timescale 1ns/100ps
module coder
#(
	parameter VECT_W = 8,
	parameter BIN_W = VECT_W>>1 - 1
)
(
	input	[VECT_W-1:0]	step,
	output	[BIN_W-1:0]		answer
);

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

module top;

reg	[7:0]data_in = 8'b0;
wire [2:0]data_out;
reg [2:0]test[7:0];

initial begin
	#10data_in = 1'b1;
	#10 data_in = data_in<<1;
	#10 data_in = data_in<<1;
	#10 data_in = data_in<<1;
	#10 data_in = data_in<<1;
	#10 data_in = data_in<<1;
end

initial #1000$stop;

coder
	test01(
		.step(data_in), 
		.answer(data_out)
	);
 
endmodule