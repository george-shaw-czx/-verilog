 module LED_num (seg_data,SMG,SMG_CS);//数码管显示控制
 
	input [2:0] seg_data;						//3位输入做地址编码
	output reg [7:0]SMG_CS;					//输出地址
	output [7:0] SMG;						//控制一位数码管需要的信号
	reg [7:0] seg [7:0];                                            //字符形状存储

   assign SMG = seg[seg_data];//根据地址编码提取对应的数码管字符
	
   initial begin											//将字符形状存入
		seg[0] = 8'b00000110;
		seg[1] = 8'b01011011;
		seg[2] = 8'b01001111;
		seg[3] = 8'b01100110;
		seg[4] = 8'b01101101;
		seg[5] = 8'b01111101;
		seg[6] = 8'b00000111;
		seg[7] = 8'b00000000;
		SMG_CS=8'b0111_1111;
   end
		  
endmodule 