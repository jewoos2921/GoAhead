module combo_design(input a_in, b_in, output reg diff_out, borrow_out);

/* Functionality of half substractor diff_out is XOR of a_in, b_in */

always @ (a_in, b_in)
    if (a_in == b_in)
        diff_out = 0;
    else
        diff_out = 1;

/* Functional description of the logic for borrow_out that is~a_in & b_in */
always @ (a_in, b_in)
    if (a_in == 0 && b_in == 1)
        borrow_out =1;
    else
        borrow_out = 0;
endmodule
