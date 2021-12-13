module nor_gate(input a_in, b_in, output reg y_out);

always@(a_in, b_in)

begin
if (a_in == 0 && b_in == 0)
y_out = 1;
else
y_out =0;
end
endmodule


module nor_gate1(input[7:0] a_in, b_in, output [7:0] y_out);

assign y_out = ~ (a_in | b_in);

endmodule