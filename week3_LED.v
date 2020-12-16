module week3_LED(key,switch,led);

input [3:0]key;//4位按键
input [3:0]switch;//4位开关
output [7:0]led;//七位led灯光

assign led={key,switch};//连续赋值，先按键，后开关

endmodule 