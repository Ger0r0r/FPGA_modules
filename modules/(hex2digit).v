`timescale 1ns/100ps
module hex2digit
(
	input	[3:0]	hex,
	output	[6:0]	digit
);

assign digit = 	{7(hex == 7'h0)} & 7'b1000000 |
				{7(hex == 7'h1)} & 7'b1111001 |
				{7(hex == 7'h2)} & 7'b1011011 |
				{7(hex == 7'h3)} & 7'b1001111 |
				{7(hex == 7'h4)} & 7'b0011001 |
				{7(hex == 7'h5)} & 7'b0010010 |
				{7(hex == 7'h6)} & 7'b0000010 |
				{7(hex == 7'h7)} & 7'b1111000 |
				{7(hex == 7'h8)} & 7'b0000000 |
				{7(hex == 7'h9)} & 7'b0010000 |
				{7(hex == 7'hA)} & 7'b0001000 |
				{7(hex == 7'hB)} & 7'b0000011 | 
				{7(hex == 7'hC)} & 7'b1000110 |
				{7(hex == 7'hD)} & 7'b0100001 | 
				{7(hex == 7'hE)} & 7'b0001110 |
				{7(hex == 7'hF)} & 7'b0000110 |

endmodule