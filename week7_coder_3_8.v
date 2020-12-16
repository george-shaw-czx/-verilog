module week7_coder_3_8(
input[2:0] location,
input[2:0] enable,
output reg [7:0] data
);
integer i;
	always @(*) begin 
	if(enable==3'b100)
		for (i=0;i<8;i=i+1) begin
			if (location==i)
				data[i]<=0;
			else data[i]<=1;
		end
	end

endmodule 