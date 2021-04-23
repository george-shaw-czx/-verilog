module lattice(				//点阵控制
input sysclk,						//点阵时钟
input rst,						//复位
input [2:0]unable,			//琴键二进制表示
input [1:0]tone,				//高低音控制
output reg[7:0]led_row,			//控制点阵行，初始化为灭
output reg[7:0]Gled_col,			//控制点阵绿色亮灭，初始化为灭
output reg[7:0]Rled_col			//控制点阵红色亮灭，初始化为灭
);
reg[2:0] counter=3'b000;			//扫描计数器
reg[7:0] lightedLED=8'b0000_0000;				//点亮的灯位置

always@(posedge sysclk or posedge rst)   				//设置扫描计数器
if(rst)begin
	counter<=1'b0;
end
else if(counter==3'b110)				//最大计数值为6，从零至六分别对应点亮的七行数码管
	counter<=1'b0;
else
	counter<=counter+1'b1;


always@(posedge sysclk or posedge rst)begin
	if(rst)begin
		led_row<=8'b1111_1111;
		Gled_col<=8'b0000_0000;
		Rled_col<=8'b0000_0000;
	end
	else begin
		case(counter)        				//点阵扫描，确定点亮的灯的位置，使用行扫描
			3'b000:begin
			led_row<=8'b1111_1110;					//从第
			lightedLED<=8'b0111_1111;			//暂时存储被点亮的LED，后面需要对于被按下的进行灭灯操作，并赋给相应音符对应的颜色
			end
			3'b001:begin
			led_row<=8'b1111_1101;
			lightedLED<=8'b0111_1110;
			end
			3'b010:begin
			led_row<=8'b1111_1011;
			lightedLED<=8'b0111_1100;
			end
			3'b011:begin
			led_row<=8'b1111_0111;
			lightedLED<=8'b0111_1000;
			end
			3'b100:begin
			led_row<=8'b1110_1111;
			lightedLED<=8'b0111_0000;
			end
			3'b101:begin
			led_row<=8'b1101_1111;
			lightedLED<=8'b0110_0000;
			end
			3'b110:begin
			led_row<=8'b1011_1111;
			lightedLED<=8'b0100_0000;
			end
			default:begin
			led_row<=8'b1111_1111;
			lightedLED<=8'b0000_0000;
			end
		endcase

		lightedLED[unable]=0;				//保持按下琴键对应的LED不亮

		case(tone)							//颜色控制，确定点亮灯的颜色
			2'b10:begin						//红色
			Rled_col<=lightedLED;				
			Gled_col<=8'b0000_0000;
			end
			2'b01:begin						//绿色
			Rled_col<=8'b0000_0000;
			Gled_col<=lightedLED;
			end
			2'b11:begin						//橘色
			Gled_col<=lightedLED;
			Rled_col<=lightedLED;
			end
			default:begin					//不显示
			Gled_col<=8'b0000_0000;
			Rled_col<=8'b0000_0000;
			end
		endcase
	end
end

endmodule 
