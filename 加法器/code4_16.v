module coder(
	input isbigger,
	input wire[3:0] a,
	output reg[3:0] y1,
	output reg[3:0] y2
);
	integer i;
	always @(*) begin //******
		if(isbigger==1'b0)
			begin
				y1=4'b0000;
				y2=a;
			end
		else
		begin
			y1=4'b0001;
			y2={~a[3],~a[2],~a[1],a[0]};
		end
	end
endmodule