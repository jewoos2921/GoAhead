module full_adder(input a_in , b_in, c_in,
                  output sum_out, carry_out);

assign  {carry_out, sum_out} = a_in + b_in + c_in;

endmodule

