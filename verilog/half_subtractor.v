module half_subtractor(input a_in , b_in, output diff_out, borrow_out);

assign diff_out = a_in ^ b_in;
assign borrow_out = (~a_in) & b_in;

endmodule