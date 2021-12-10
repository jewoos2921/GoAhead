module reduction_operators(input [3:0] a_in , output reg [5:0] y_out);

always @(a_in)
// reduction AND
begin
y_out[0] = &a_in;
y_out[1] = ~&a_in;
y_out[2] = |a_in;
y_out[3] = ~|a_in;
y_out[4] = ^a_in;
y_out[5] = ~^a_in;
end
endmodule

