module elec_piano(//总体控制
input sysclk,						//板载晶振时钟
input rst,						//复位信号
input [1:0]tone,					//拨码开关高低音控制
input [6:0]yinfu,					//按键开关琴键输入
input switch,							//自动播放控制
output [7:0]led_row,					//控制点阵的行
output [7:0]Gled_col,				//控制点阵绿色亮灭
output [7:0]Rled_col,					//控制点阵红色亮灭
output [7:0]SMG,			//数码管输出
output [7:0]SMG_CS,				//输出数码管位置，确定是哪个数码管输出
output BEEP				//蜂鸣器输出
);
reg [1:0]tone_in;			//实际输入的高低音信号
reg [2:0]unable;				//琴键的二进制形式
wire sysclk_lattice;				//点阵时钟
wire sysclk_player;				//自动播放时钟
wire [2:0]unable_switch;		//自动按键
wire [1:0]tone_switch;		//自动拨码开关
parameter XIANSHI=100000;//显示分频数
parameter PLAY=15000000;//音乐播放分频数

always@(posedge sysclk or posedge rst)begin
	if(rst)begin						//复位
		unable<=3'b111;
	end
	else if(switch==1'b1)begin			//对是否进行自动播放进行控制
		unable=unable_switch;				//进行自动播放
		tone_in=tone_switch;
	end
	else begin								//不进行自动播放时
		tone_in<=tone;
		if(yinfu[6]|yinfu[5]|yinfu[4]|yinfu[3]|yinfu[2]|yinfu[1]|yinfu[0])begin//编码器，将琴键输入数据转换为3位2进制
		unable[2]<=yinfu[6]|yinfu[5]|yinfu[4];
		unable[1]<=yinfu[6]|yinfu[3]|yinfu[2];
		unable[0]<=yinfu[5]|yinfu[3]|yinfu[1];
		end
		else begin						//当无琴键按下时，赋予不使用的3‘b111
			unable<=3'b111;
		end
	end
end
			lattice u0(					//点阵控制模块
				sysclk_lattice,
				rst,
				unable,
				tone_in,
				led_row,
				Gled_col,
				Rled_col
			);
			
			divider u1 (         //点阵扫描时钟
				sysclk,
				rst,
				XIANSHI,			
				sysclk_lattice
			); 
			
			LED_num u2(					//数码管控制模块
				unable,
				SMG,
				SMG_CS
			);

			buzzer u4(			//蜂鸣器控制模块
				sysclk,
				rst,
				tone_in,
				unable,
				BEEP
			);	
			divider u5(				//自动播放时钟
				sysclk,
				rst,
				PLAY,
				sysclk_player
			);
			player u6(				//自动播放模块
				sysclk_player,
				rst,
				unable_switch,
				tone_switch
			);
endmodule 
