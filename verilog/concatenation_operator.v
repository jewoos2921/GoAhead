module concatenation_operator(input [2:0] a_in, b_in, output reg [15:0] y_out);

parameter c_in = 3'b010;

always @(a_in, b_in)
begin
y_out = {a_in ,b_in , {3{c_in}}, 3'b111};
end
endmodule