module sign_operator(input [1:0] a_in, b_in, output reg [3:0] y1_out, y2_out);
always @(a_in, b_in)
begin
/* use of sign operator */
y1_out = (-a_in) + b_in;
/* use of sign operator*/
y2_out = a_in * (-b_in);
end
endmodule

