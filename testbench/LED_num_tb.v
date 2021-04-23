`timescale 10ns/10ns
module LED_num_tb;
reg[2:0]unable;
wire[7:0] seg_led;
wire[7:0] seg_loc;
			LED_num u2(					//数码管控制
				unable,
				seg_led,
				seg_loc
			);
initial begin
	unable=3'b000;#100;
	unable=3'b001;#100;
	unable=3'b010;#100;
	unable=3'b011;#100;
	unable=3'b100;#100;
	unable=3'b101;#100;
	unable=3'b110;#100;
	unable=3'b111;#100;
end

endmodule 