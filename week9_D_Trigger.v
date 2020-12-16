module week9_D_Trigger(
input clk,
input D,
input rst,
output reg Q
);
always@(posedge clk)begin
	if(rst)
		begin
			Q=1'b0;
		end
	Q=D;
end
endmodule