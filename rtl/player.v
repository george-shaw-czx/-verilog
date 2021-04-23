module player(//自动演奏模块
					input sysclk,		//时钟信号
					input rst,		//复位信号
					output reg[2:0] unable,	//自动演奏音符
					output reg[1:0] yinfu		//自动演奏高低音
					);
reg[8:0]cnt;//计数器，循环获取歌曲信息
parameter N=42;//歌曲音符数
always@(posedge sysclk or posedge rst)begin	//循环计数，用来获取不同的音符和高低音				
	if(rst)begin//复位信号
		cnt<=1'b0;
	end
	else if(cnt<N) begin
		cnt<=cnt+1'b1;
	end
	else begin//计数值归零
		cnt<=1'b0;
	end
end
always@(*)begin
	case(cnt)//根据计数值获取不同音符和高低音
		8'b0000_0000:begin unable=3'b000;yinfu=2'b01; end
		8'b0000_0001:begin unable=3'b000;yinfu=2'b11; end
		8'b0000_0010:begin unable=3'b100;yinfu=2'b01; end
		8'b0000_0011:begin unable=3'b100;yinfu=2'b11; end
		8'b0000_0100:begin unable=3'b101;yinfu=2'b01; end
		8'b0000_0101:begin unable=3'b101;yinfu=2'b01; end
		8'b0000_0110:begin unable=3'b110;yinfu=2'b10; end
		
		8'b0000_0111:begin unable=3'b011;yinfu=2'b01; end
		8'b0000_1000:begin unable=3'b011;yinfu=2'b01; end
		8'b0000_1001:begin unable=3'b010;yinfu=2'b10; end
		8'b0000_1010:begin unable=3'b010;yinfu=2'b10; end
		8'b0000_1011:begin unable=3'b001;yinfu=2'b11; end
		8'b0000_1100:begin unable=3'b001;yinfu=2'b11; end
		8'b0000_1101:begin unable=3'b000;yinfu=2'b11; end
		
		8'b0000_1110:begin unable=3'b100;yinfu=2'b01; end
		8'b0000_1111:begin unable=3'b100;yinfu=2'b10; end
		8'b0001_0000:begin unable=3'b011;yinfu=2'b01; end
		8'b0001_0001:begin unable=3'b011;yinfu=2'b01; end
		8'b0001_0010:begin unable=3'b010;yinfu=2'b10; end
		8'b0001_0011:begin unable=3'b010;yinfu=2'b01; end
		8'b0001_0100:begin unable=3'b001;yinfu=2'b11; end
		
		8'b0001_0101:begin unable=3'b100;yinfu=2'b01; end
		8'b0001_0110:begin unable=3'b100;yinfu=2'b10; end
		8'b0001_0111:begin unable=3'b011;yinfu=2'b01; end
		8'b0001_1000:begin unable=3'b011;yinfu=2'b01; end
		8'b0001_1001:begin unable=3'b010;yinfu=2'b10; end
		8'b0001_1010:begin unable=3'b010;yinfu=2'b01; end
		8'b0001_1011:begin unable=3'b001;yinfu=2'b11; end
		
		8'b0001_1100:begin unable=3'b000;yinfu=2'b01; end
		8'b0001_1101:begin unable=3'b000;yinfu=2'b01; end
		8'b0001_1110:begin unable=3'b100;yinfu=2'b10; end
		8'b0001_1111:begin unable=3'b100;yinfu=2'b10; end
		8'b0010_0000:begin unable=3'b101;yinfu=2'b11; end
		8'b0010_0001:begin unable=3'b101;yinfu=2'b11; end
		8'b0010_0010:begin unable=3'b100;yinfu=2'b11; end
		
		8'b0010_0011:begin unable=3'b011;yinfu=2'b01; end
		8'b0010_0100:begin unable=3'b011;yinfu=2'b11; end
		8'b0010_0101:begin unable=3'b010;yinfu=2'b01; end
		8'b0010_0110:begin unable=3'b010;yinfu=2'b11; end
		8'b0010_0111:begin unable=3'b001;yinfu=2'b01; end
		8'b0010_1000:begin unable=3'b001;yinfu=2'b01; end
		8'b0010_1001:begin unable=3'b000;yinfu=2'b10; end
		default:begin unable=3'b111;yinfu=2'b00;end//设置一个循环之间的空隙
	endcase
end
					
endmodule 