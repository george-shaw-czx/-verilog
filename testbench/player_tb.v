`timescale 10ns/10ns
module player_tb;
reg clk_player;
reg rst;
wire[2:0]unable_auto;
wire[1:0]color_auto;
			player u6(				//自动播放模块
				clk_player,
				rst,
				unable_auto,
				color_auto
			);
initial begin
	clk_player<=1'b1;
	rst<=1'b1;
	#10
	rst<=1'b0;
	forever#100 clk_player<=~clk_player;
end
endmodule 