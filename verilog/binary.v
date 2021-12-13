module binary_comparator(input [3:0] a_in, b_in, output reg a_greater_b, a_equall_b, a_less_b);
always @*
begin
if (a_in == b_in)
begin
a_greater_b = 0;
a_equall_b =1;
a_less_b = 0;
end
else if (a_in > b_in)
begin
a_greater_b = 1;
a_equall_b =0;
a_less_b = 0;
end
else
begin
a_greater_b = 0;
a_equall_b =0;
a_less_b = 1;
end
end
endmodule

module binary_to_gray(input [3:0] binary_in, output [3:0] gray_out);
assign gray_out[3] = binary_in[3];
assign gray_out[2] = binary_in[3] ^ binary_in[2];
assign gray_out[1] = binary_in[2] ^ binary_in[1];
assign gray_out[0] = binary_in[1] ^ binary_in[0];
endmodule

module binary_to_gray(input [3:0] gray_in, output [3:0] binary_out);
assign binary_out[3] = gray_in[3];
assign binary_out[2] = gray_in[3] ^ gray_in[2];
assign binary_out[1] = (gray_in[3] ^ gray_in[2]) ^ gray_in[1];
assign binary_out[0] = (gray_in[3] ^ gray_in[2] ^gray_in[1]) ^ gray_in[0];
endmodule
