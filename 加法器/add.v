module add(
input [3:0] num,
input button,
output [8:0] seg_led_1,
output [8:0] seg_led_2
);
wire [3:0]carry;
wire [3:0]stmt;
wire carry_out;
reg [3:0]cur_num=4'b0000;
reg [3:0]add_num=4'b0000;
wire [3:0] seg_data_1;
wire [3:0] seg_data_2;
reg instmt=1'b0;
reg isbigger;

add_unit u1(cur_num[0],add_num[0],carry[0],carry[1],stmt[0]);
add_unit u2(cur_num[1],add_num[1],carry[1],carry[2],stmt[1]);
add_unit u3(cur_num[2],add_num[2],carry[2],carry[3],stmt[2]);
add_unit u4(cur_num[3],add_num[3],carry[3],carry_out,stmt[3]);

initial isbigger = stmt[3]&&(stmt[2]||stmt[1]);

coder u5(isbigger,stmt,seg_data_1,seg_data_2);
LED_num led1(seg_data_1,seg_data_2,seg_led_1,seg_led_2);

always@(negedge button)
	begin
		if(instmt==1'b0)
			begin
				instmt=~instmt;
				cur_num=num;
			end
		else
			begin
				instmt=~instmt;
				add_num=num;
			end
	end


endmodule 