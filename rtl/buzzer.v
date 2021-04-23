module buzzer(			//蜂鸣器控制
    input sysclk,			//时钟输入
	 input rst,			//复位信号
	 input [1:0]tone,		//高低音控制
	 input [2:0]unable,		//音符控制
	 output reg BEEP=1'b0		//输出到蜂鸣器
    );
  reg [5:0]count1;//产生基准信号的计数器
  reg [31:0] count2;//按键更新计数器
  reg sysclk_1mhz;//产生1微秒基础单位时钟
  reg [12:0] per_s;//根据音符得到的持续时间
  reg [12:0] per_s_c;//加入高低音后的持续时间
  reg carry;			//频率信号，经历了持续时间后会反转，从而实现蜂鸣器的蜂鸣
  reg [12:0]divider;		//持续时间的计数信号
  reg [2:0] unable_s;		//可以输入的音符信号
  reg [2:0] unable_old;		//过去的音符信号，用来判断音符是否发生变化
  
	always@(posedge sysclk or posedge rst)begin//分频器，产生音阶频率的基准频率1mHZ
		  if(rst)begin
		  		count1<=0;
				sysclk_1mhz<=0;
		  end
		  else if(count1<25)begin				//50MHZ分频50份得1MHZ
				  count1<=count1+1'b1;
			  end
		  else begin
				  count1<=0;
				  sysclk_1mhz<=~sysclk_1mhz;				//每半个周期进行一次时钟翻转
			  end
	  end
  
	always@(posedge sysclk)begin
		    if(unable_old==unable) begin				//按键状态未发生变化，开始计数
				    if(count2<=25000000) begin		//计时完成，获取按键状态
							 count2<=count2+1;
							 unable_s<=unable;
						 end
                else begin						//计时0.5s后声音消失
                      unable_s<=3'b111;
							 count2<=count2+1;
						 end
             end	
          else begin									//按键状态发生变化，计数归零
                unable_old<=unable;
                count2<=0;
             end
      end			
		 
   always@(posedge sysclk_1mhz or posedge rst)begin//首先进行高低音修正，然后进行计数，获得对应微秒数的时钟carry
		if(rst)begin			//复位
			per_s_c<=3000;
			divider<=0;
			carry<=0;
		end
		else begin
			case(tone)								//高低音修正
				2'b01:per_s_c<=(per_s<<2);
				2'b10:per_s_c<=(per_s<<1);
				2'b11:per_s_c<=per_s;
				default:per_s_c<=3000;
			endcase
			if(divider>0&&divider<2000)begin //去除不合法信号后减计数   //获取对应微秒数的时钟carry
               divider<=divider-1'b1;
               carry<=0;
         end
         else if(divider==0)begin	//carry产生一个上升沿并开始新一轮计数
               carry<=1;
               divider<=per_s_c;
         end
			else	begin 				//归零 
					carry<=1;
					divider<=0;
			end  
      end
	end
   
   always@(posedge carry)begin 				//产生音阶信号的输出 
		if(rst)begin
			BEEP<=0;
		end
		else if(per_s_c>2000)
			BEEP<=0;
		else
         BEEP<=~BEEP;
    end
		
   always@(*)begin
		if(rst)begin
			per_s<=3000;
		end
		else begin
         case(unable_s)
			  3'b000:per_s=478;  			//高音do，数值为持续微秒数
			  3'b001:per_s=426;  			//高音rai
			  3'b010:per_s=379;  			//高音mi
			  3'b011:per_s=360;  			//高音fa 
			  3'b100:per_s=319;  			//高音so
			  3'b101:per_s=284;  			//高音la
			  3'b110:per_s=254;  			//高音xi
			  default:per_s=3000;			//设置为错误值，避免发音
			endcase
      end
	end
	 
endmodule 