`timescale 1ns/100ps
module double_dabble
#(
	parameter NBITS = 8,
	parameter NDECS = 3,
	parameter DEC_BITS = NDECS * 4
)
(
	input	wire	clock,
	input	wire	reset,
	intput	wire	[NBITS - 1:0]	binary, // bin[NBITS]

	output	wire	[DEC_BITS - 1:0]	decimal // dec[4][NDECS]
);

reg [NBITS + DEC_BITS - 1:0] temp; // copy dec[4][NDECS] + bin[NBITS]
reg [NDECS - 1:0] flag;

assign decimal = temp[NBITS + DEC_BITS - 1:NBITS];

always @(posedge clock)
	if (reset)
	begin
		temp[NBITS - 1:0] <= {NBITS{1'b0}}; // reset bin[NBITS]
	end

genvar g;
generate
	for (g = NDECS - 1; g >= 0; g = g - 1) 
	begin
		always @(posedge clock)
		begin
			if (reset)
			begin
				temp[NBITS + (g + 1) * 4 - 1: NBITS + g * 4] <= 4'b0; // reset dec[4][g]
				flag[g] <= 1'b0; // exact dec[4] must be shifted at the beginning
			end
			else // usual work
			begin
				// stop usual work if initial bin[NBITS] == 0 and by the algorithm next step is shift
				if ((flag == {DEC_BITS{1'b0}}) && (temp[NBITS - 1:0] == {NBITS{1'b0}}))
				begin
					if (flag > {DEC_BITS{1'b0}}) // some dec[4] must be increased
					begin
						if (flag[g] > 1'b0) // chech exact dec[4] that must be increased
						begin
							// add 3 to exact dec[4]
							temp[NBITS + (g + 1) * 4 - 1: NBITS + g * 4] <= temp[NBITS + (g + 1) * 4 - 1: NBITS + g * 4] + 2'b11; 

							// after need shift this dec[4]
							flag[g] <= 1'b0; 
						end
					end
					else // nobody need to increase, will be shift
					begin
						if (g == NDECS - 1) // if it's the highest dec[4]
						begin
							// shift dec[4,3,2] <= dec[3,2,1]
							temp[NBITS + (g + 1) * 4 - 1: NBITS + g * 4 + 1] <= {temp[NBITS + (g + 1) * 4 - 2: NBITS + g * 4]}; 
						end
						else // it's not the highest dec[4]
						begin
							// shift dec[4,3,2] <= dec[3,2,1]
							temp[NBITS + (g + 1) * 4 - 1: NBITS + g * 4 + 1] <= {temp[NBITS + (g + 1) * 4 - 2: NBITS + g * 4]}; 

							// shift dec[4][g] to dec[1][g+1]
							temp[NBITS + (g + 1) * 4] <= temp[NBITS + (g + 1) * 4 - 1]; 
						end
					end
					// check if current value dec[4] >= 5
					flag[g] <= (temp[NBITS + (g + 1) * 4 - 1: NBITS + g * 4] >= 4'd5) ? 1'b1 : 0'b0; 
				end
			end
		end
	end
endgenerate

endmodule