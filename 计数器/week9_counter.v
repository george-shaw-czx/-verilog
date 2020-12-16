module week9_counter(
input rst,
input button,
input clk,
output[8:0] seg_led_1,
output[8:0] seg_led_2
);

reg carry=1'b0;//进位信号
//integer num=0;
//wire [3:0]seg_data_1=num/10;
//wire [3:0]seg_data_2=num%10;
reg [3:0]seg_data_1=4'b0000;
reg [3:0]seg_data_2=4'b0000;
wire button_pulse;//消抖后信号

debounce u1(clk,rst,button,button_pulse);//按键消抖
LED_num u2(seg_data_1,seg_data_2,seg_led_1,seg_led_2);//数码管输出

always@(posedge button_pulse or posedge rst)begin 
	if(rst==1'b1)
	begin//复位
		seg_data_1<=4'b0000;
		seg_data_2<=4'b0000;
//		num=0;
	end
	else 
	begin//进位处理
		carry=seg_data_2[3]&&(seg_data_2[2]||seg_data_2[1]||seg_data_2[0]);
		if(carry==1'b1)
		seg_data_2<=seg_data_2+4'b0111;
		else
		seg_data_2<=seg_data_2+4'b0001;
		seg_data_1<=seg_data_1+carry;
	end
end
endmodule 