module divider(//分频器
			input	sysclk, 			//输入信号
			input	rst,			//复位信号
			input[31:0] N,		//分频数
			output sysclk_out		//分频输出
);
reg sysclk_out1;			//上升沿分频结果
reg sysclk_out2;			//下降沿分频结果
reg [31:0] cnt1;			//上升沿分频计数器
reg [31:0] cnt2;			//下降沿分频计数器
 
assign  sysclk_out=(N==1)?sysclk:(N[0])?(sysclk_out1&sysclk_out2):sysclk_out1; //根据N确定使用何种分频结果
 
always @(posedge sysclk or posedge rst) begin   //进行上升沿分频
 if(rst) begin				//上升沿复位
		cnt1 <= 0;
		sysclk_out1 <= 0;
	end
	else begin
		if(cnt1 == N-1) begin		//计数完全再次反转分频结果
			cnt1 <= 0;
			sysclk_out1 <= ~sysclk_out1;
		end
		else if(cnt1 == (N-1)/2) begin		//计数达到一半反转分频结果
			cnt1 <= cnt1 + 1;
			sysclk_out1 <= ~sysclk_out1;
		end
		else											//循环计数
			cnt1 <= cnt1 + 1;
	end
end
 
always @(negedge sysclk or posedge rst) begin			//进行下降沿分频
	if(rst) begin			//下降沿复位
		cnt2 <= 0;
		sysclk_out2 <= 0;
	end
	else begin
		if(cnt2 == N-1) begin			//计数完全再次反转分频结果
			cnt2 <= 0;
			sysclk_out2 <= ~sysclk_out2;
		end
		else if(cnt2 == (N-1)/2) begin		//计数达到一半反转分频结果
			cnt2 <= cnt2 +1;
			sysclk_out2 <= ~sysclk_out2;
		end
		else											//循环计数
			cnt2 <= cnt2 +1;
	end
end
 
 
endmodule