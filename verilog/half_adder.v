module half_adder(input a_in , b_in, output sum_out, carry_out);

assign sum_out = a_in ^ b_in;
assign carry_out = a_in & b_in;

endmodule