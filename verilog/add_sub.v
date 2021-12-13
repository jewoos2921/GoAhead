module add_sub(input a_in , b_in, control_in, output reg result_out, carry_out);
always @*
if (control_in)
{carry_out, result_out} = a_in + b_in;
else
{carry_out , result_out} = a_in + (~b_in) +1;
endmodule

module add_sub_1(input a_in , b_in, control_in, output reg result_out, carry_out);
reg tmp_1;
always @*
{carry_out, result_out} = a_in + tmp_1 + control_in;
always @*
if (control_in)
tmp_1 = ~b_in;
else
tmp_1 = b_in;
endmodule
