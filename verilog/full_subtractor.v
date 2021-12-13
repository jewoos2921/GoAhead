module full_subtractor(input a_in , b_in, c_in, output diff_out, borrow_out);

assign  {diff_out, borrow_out} = a_in - b_in - c_in;

endmodule