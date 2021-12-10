module logical_operators(input [2:0] a_in, b_in, c_in, d_in, e_in, f_in,
                            output reg y_out);

always @ (a_in, b_in, c_in, d_in, e_in, f_in)
begin
    if ((a_in < b_in) && ((c_in == d_in) || (e_in > f_in)))
        y_out = 1;
    else
        y_out =0;
end

endmodule