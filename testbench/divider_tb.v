`timescale 10ns/10ns
module divider_tb;
reg clk;
reg rst;
wire clk_out;
parameter highest = 25316; 
divider u2(
			clk,
			rst,
			highest,
			clk_out
);
initial begin
clk=1'b0;
rst=1'b1;
#10
rst=1'b0;
forever #5 clk<=~clk;
end
endmodule 