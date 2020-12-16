module add_unit(
input add_num,
input cur_num,
input carry,
output carry_next,
output stmt
);
	wire t1,t2,t3;
   wire s1;
  
   xor (s1,add_num,cur_num);
   xor (stmt,s1,carry);
   and (t3,add_num,cur_num);
   and (t2,cur_num,carry);
   and (t1,add_num,carry);
   or  (carry_next,t1,t2,t3);
endmodule