module passwordBox(
    input wire [3:0] password,          //四位开关作为密码输入
//    input wire en,				  //一位按键作为开锁使能信号
	 input wire ex,					//一位按键作为修改密码信号
    output wire led1,    	      //保险箱打开信号对应的led输出
    output wire led2,	  //报警信号对应的led输出
	 input wire clk,		//时钟信号
	 input rst
  );

reg			  open;			  //保险箱开箱信号
reg			  alarm;          //报警信号
reg [3:0] code;	//密码信号
reg     		stmt;
wire              key_pulse;   	//
initial
begin
	code=4'b1010;
	stmt=1'b0;
end

 assign  led1 = ~open;		//led亮表示密码锁没开
 assign	led2 = ~alarm;		//led亮代表发出报警信号
 
 debounce  u1 (                               
                       .clk (clk),
                       .rst (rst),
                       .key (ex),
                       .key_pulse (key_pulse)
                       );
							  
always@( posedge clk)
begin
	if(password == code)   
		begin
			open = 1'b1;  //开锁
			alarm = 1'b0; //没报警
		end
	else
		begin
			open = 1'b0;  
			alarm = 1'b1;
		end
end

always@(posedge key_pulse)
begin
	if(stmt==1'b1)
		begin
			code=password;
			stmt=1'b0;
		end
	else
		if(open==1'b1)
			begin
				stmt=1'b1;
			end
		else
			begin
			stmt=1'b0;
			end
end
endmodule 