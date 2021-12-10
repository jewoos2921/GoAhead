module bit_wise_operators(input [6:0] a_in, input [5:0] b_in, output reg [6:0] y_out);

always @ (a_in, b_in)
begin
// bit wise AND
y_out[0] = a_in[0] & b_in[0];
// bit wise NAND
y_out[1] = !(a_in[0] & b_in[0]);
// bit wise OR
y_out[2] = a_in[0] | b_in[0];
// bit wise NOR
y_out[3] = !(a_in[0] | b_in[0]);
// bit wise XOR
y_out[4] = a_in[0] ^ b_in[0];
// bit wise XNOR
y_out[5] = (a_in[0] ~^ b_in[0]);
// bit wise NOT
y_out[6] = !a_in[6];
end
endmodule