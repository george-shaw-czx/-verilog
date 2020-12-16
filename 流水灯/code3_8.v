module code3_8(
	input wire[2:0] a,		//输入的三位信号
	output reg[7:0] y			//输出的八位信号
);
	integer i;
	always @(*) begin //总是检测
		for (i=0;i<8;i=i+1) begin
			if (a==i)
				y[i]<=0;
			else y[i]<=1;
		end
	end
endmodule