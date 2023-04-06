`timescale 1ns/100ps
module decoder_3to8_full
(
	input	[2:0]	value,
	output	[7:0]	answer
);
	assign answer = 1'b1<<value;
	
genvar Gi;

generate for (Gi = 0; Gi < 1'b1<<value ; Gi = Gi + 1) 
begin: loop1
	assign answer[value-Gi-1] = answer[value];
end
endgenerate
endmodule