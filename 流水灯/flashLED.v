module flashLED (clk,rst,led,clk1h);
 
   input clk;												//定义系统的时钟
	input rst;												//定义复位按键				
	output [7:0] led;										//定义led输出
	reg   [2:0] cnt ;                               //定义了一个3位的寄存器
	output clk1h;                                     //定义分频得到的时钟        
 
        //例化三八译码器
        code3_8 u1(                                   
			.a(cnt),                       
			.y(led)
			);
 
 
        //例化分频器模块，产生一个1Hz时钟信号		
        divide #(.WIDTH(32),.N(12000000)) u2 (         //传递参数
			.clk(clk),
			.rst_n(rst),                   
			
			.clkout(clk1h)
			);                             
 
        //1Hz时钟上升沿触发计数器，循环计数		
    always @(posedge clk1h or negedge rst)
	     if (!rst)
		cnt <= 0;
	     else
		cnt <= cnt +1;
endmodule 