module combo_design(input a_in, b_in, output reg diff_out, output borrow_out);

/* Functionality of half substractor diff_out is XOR of a_in, b_in */

always @ (a_in, b_in)
   diff_out = a_in ^ b_in;

/* Functional description of the logic for borrow_out that is~a_in & b_in */
    assign borrow_out = (~a_in) & b_in;
endmodule
