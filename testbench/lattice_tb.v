`timescale 10ns/10ns
module lattice_tb;
reg clk;						
reg rst;						
reg[2:0] unable;		
reg[1:0] color;				
wire [7:0]row;			
wire [7:0]green;			
wire [7:0]red;

			lattice u1(					//点阵控制
				clk,
				rst,
				unable,
				color,
				row,
				green,
				red
			);

initial begin
color<=2'b01;
clk<=1'b0;
rst<=1'b1;
unable<=3'b010;
forever #5 clk<=~clk;
end
initial begin
   rst = 1;
	#5
	rst = 0;
	#10000000 color<=2'b10;
	#10000000 color<=2'b01;unable<=3'b110;
	#10000000 color<=2'b11;unable<=3'b111;
	#10000000 color<=2'b01;unable<=3'b011;
end
 
endmodule 