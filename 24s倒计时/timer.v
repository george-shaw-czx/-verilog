module timer(
input clk,
input pulse,
input start,
input clr,
output[8:0] seg_led_1,
output[8:0] seg_led_2,
output[7:0] led,
output color_red
);
wire clkout;
reg rst=1'b1;
reg pulsed=1'b0;
reg[3:0] shiwei;
reg[3:0]	gewei;
reg[2:0] cnt8;
reg[1:0] cnt3;
divider u1(			//产生1HZ信号
		clk,
		rst,
		clkout
);
LED_num u2(			//数码管输出
		shiwei,
		gewei,
		seg_led_1,
		seg_led_2
);
code3_8 u3(			
	cnt8,
	led
);

assign color_red=(cnt3[0]|cnt3[1]);

always@(posedge clkout or negedge clr)begin
	if(!clr)begin
			shiwei <= 4'b0010;
			gewei <= 4'b0011;
	end
	else if(!pulse) begin
		pulsed<=~pulsed;
	end
	else if(pulsed==1'b1) begin
		gewei<=gewei;
		shiwei<=shiwei;
	end
	else if(gewei==1'b0) begin
		if(shiwei==1'b0)begin
			shiwei <= 4'b0010;
			gewei <= 4'b0011;
		end
		else begin
			gewei<=4'b1001;
			shiwei<=shiwei-1'b1;
		end
	end
	else begin
		gewei<=gewei-1'b1;
	end
	
	if(!clr)begin
			cnt3<=2'b10;
			cnt8<=3'b111;
	end
	else if(cnt3==1'b0)begin
		if(cnt8==1'b0)begin
			cnt3<=2'b10;
			cnt8<=3'b111;
		end
		else begin 
			cnt8 <= cnt8 -1'b1;
		end
	end
	else
		if(cnt8==1'b0)begin
			cnt3<=cnt3-1'b1;
			cnt8<=3'b111;
		end
		else begin
			cnt8 <= cnt8 -1'b1;
		end
end
endmodule 