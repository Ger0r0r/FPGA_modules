`timescale 1ns/100ps
module humanlike_timer_h
(
	input	wire	clock,
	input	wire	reset,

	// output hhhhh mmmmmm ssssss xxxxxxxxxx : h[5]-hours, m[6]-minutes, s[6]-seconds, x[10]-miliseconds
	output	wire	[26:0]	time;
);

reg [15:0] counter;
reg [26:0] temp;

assign time = temp;

always @(posedge clock)
begin
	if (reset) 
	begin
		counter <= 16'b0;
		temp <= 27'b0;
	end
	else
	begin
		if (counter == 16'd49999) // clock reach 1 ms
		begin
			if (temp[9:0] == 10'd999) // ms reach 999
			begin
				if(temp[15:10] == 6'd59) // s reach 59
				begin
					if (temp[21:16] == 6'd59) // m reach 59
					begin
						if (temp[26:22] == 5'd23) // h reach 23
							temp[26:22] <= 5'b0;
						else
							temp[26:22] <= temp[26:22] + 1'b1;
						temp[21:16] <= 6'b0;
					end
					else
						temp[21:16] <= temp[21:16] + 1;
					temp[15:10] <= 6'b0;
				end
				else
					temp[15:10] <= temp[15:10] + 1'b1;
				temp[9:0] <= 10'b0;
			end
			else
				temp[9:0] <= temp[9:0] + 1'b1;
			counter <= 16'b0;
		end
		else
		begin
			counter <= counter + 1'b1;
		end
	end
end

endmodule

module humanlike_timer_m
(
	input	wire	clock,
	input	wire	reset,

	// output mmmmmm ssssss xxxxxxxxxx : m[6]-minutes, s[6]-seconds, x[10]-miliseconds
	output	wire	[21:0]	time;
);

reg [15:0] counter;
reg [21:0] temp;

assign time = temp;

always @(posedge clock)
begin
	if (reset) 
	begin
		counter <= 16'b0;
		temp <= 22'b0;
	end
	else
	begin
		if (counter == 16'd49999) // clock reach 1 ms
		begin
			if (temp[9:0] == 10'd999) // ms reach 999
			begin
				if(temp[15:10] == 6'd59) // s reach 59
				begin
					if (temp[21:16] == 6'd59) // m reach 59
						temp[21:16] <= 6'b0;
					else
						temp[21:16] <= temp[21:16] + 1;
					temp[15:10] <= 6'b0;
				end
				else
					temp[15:10] <= temp[15:10] + 1'b1;
				temp[9:0] <= 10'b0;
			end
			else
				temp[9:0] <= temp[9:0] + 1'b1;
			counter <= 16'b0;
		end
		else
		begin
			counter <= counter + 1'b1;
		end
	end
end

endmodule

module humanlike_timer_s
(
	input	wire	clock,
	input	wire	reset,

	// output ssssss xxxxxxxxxx : s[6]-seconds, x[10]-miliseconds
	output	wire	[15:0]	time;
);

reg [15:0] counter;
reg [15:0] temp;

assign time = temp;

always @(posedge clock)
begin
	if (reset) 
	begin
		counter <= 16'b0;
		temp <= 16'b0;
	end
	else
	begin
		if (counter == 16'd49999) // clock reach 1 ms
		begin
			if (temp[9:0] == 10'd999) // ms reach 999
			begin
				if (temp[15:10] == 6'd59) // s reach 59
					temp[15:10] <= 6'b0;
				else
					temp[15:10] <= temp[15:10] + 1'b1;
				temp[9:0] <= 10'b0;
			end
			else
				temp[9:0] <= temp[9:0] + 1'b1;
			counter <= 16'b0;
		end
		else
		begin
			counter <= counter + 1'b1;
		end
	end
end

endmodule