module atithmetic_operators(input [3:0] a_in, b_in,  output reg [4:0] y1_out,  output reg [7:0] y3_out,  output reg [4:0] y2_out, y4_out, y5_out);

always @ (a_in, b_in)

begin
y1_out = a_in + b_in;
y2_out = a_in - b_in;
y3_out = a_in * b_in;
y4_out = a_in / b_in;
y5_out = a_in % b_in;
end

endmodule