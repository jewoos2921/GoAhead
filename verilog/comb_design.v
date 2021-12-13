module comb_design(input a_in, b_in, output reg y_out);

always @*
begin
if (a_in == b_in)
y_out = a_in ~^ b_in;
else
y_out = a_in ^ b_in;
end
endmodule