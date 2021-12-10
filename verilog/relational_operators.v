module relational_operator(input [7:0] a_in, b_in, output reg y1_out, y2_out, y3_out, y4_out);

always @(a_in, b_in)
begin
// less than < operator
y1_out = a_in < b_in;
// less than equal to <= operator
y2_out = a_in <= b_in;

y3_out = a_in > b_in;

if (a_in >= b_in)
y4_out =1;
else
y4_out = 0;
end


endmodule