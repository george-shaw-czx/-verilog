`timescale 10ns/10ns
module elec_piano_tb;
reg sysclk;
reg rst;
reg switch;
reg[6:0] yinfu;
reg[1:0] tone;
wire[7:0]led_row;
wire[7:0]Gled_col;
wire[7:0]Rled_col;
wire[7:0]SMG;
wire[7:0] SMG_CS;
wire BEEP;

initial begin
tone=2'b01;
switch=1'b0;
sysclk=1'b0;
rst=1'b1;
yinfu=7'b010_0000;
forever #5 sysclk<=~sysclk;
end
elec_piano u1(
		sysclk,
		rst,
		tone,
		yinfu,
		switch,
		led_row,
		Gled_col,
		Rled_col,
		SMG,
		SMG_CS,
		BEEP
);

initial begin
   rst = 1;
	#5
	rst = 0;
	#10000000 tone=2'b11;
	#10000000 tone=2'b01;yinfu=7'b000_0000;
	#10000000 tone=2'b10;yinfu=7'b000_0010;
end
endmodule 