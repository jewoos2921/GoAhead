module nand_gate(input a_in, b_in, output reg y_out);
always@(a_in, b_in)
begin
if (a_in == 1 && b_in == 1)
y_out = 0;
else
y_out = 1;
end
endmodule

module nand_gate1(input[7:0] a_in, b_in, output [7:0] y_out);
assign y_out = ~(a_in & b_in);
endmodule