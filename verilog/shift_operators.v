module shift_operators(input [3:0] a_in, output reg [3:0] y1_out, y2_out);

parameter b_in = 2;

always @(a_in)
begin
// use of left shift operator
y1_out = a_in << b_in;
y2_out = a_in >> b_in;
end

endmodule
