module Equality_operaotr(input [7:0] a_in, b_in,
                         output reg y1_out, y2_out,
                         output reg [7:0] y3_out);

always @ (a_in, b_in)
begin
/* use of equailty operator */
y1_out = (a_in == b_in);
/* use of inequailty operator */
y2_out = (a_in != b_in);
/* use of operator in if condition */
if (a_in == b_in)
y3_out = a_in;
else
y3_out = b_in;
end

endmodule