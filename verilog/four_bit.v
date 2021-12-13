module four_bit_adder(input [3:0] a_in ,b_in ,
                       input c_in, output [3:0] sum_out, output carry_out);
assign {carry_out, sum_out} = a_in + b_in + c_in;
endmodule

module four_bit_subtractor(input [3:0] a_in ,b_in ,
                       input c_in, output [3:0] diff_out, output borrow_out);
assign {borrow_out, diff_out} = a_in - b_in - c_in;
endmodule

module four_bit_adder_subtractor(input [3:0] a_in ,b_in ,
                       input c_in, control_in, output reg [3:0] result_out, output reg carry_out);
always @*
if (control_in)
{carry_out, result_out} = a_in + b_in + c_in;
else
{carry_out, result_out} = a_in - b_in - c_in;
endmodule

module four_bit_adder_subtractor1(input [3:0] a_in ,b_in ,
                       input control_in, output reg [3:0] result_out, output reg carry_out);
always @*
if (~control_in)
{carry_out, result_out} = a_in + b_in + control_in;
else
{carry_out, result_out} = a_in + (~b_in) + control_in;
endmodule

module four_bit_adder_subtractor2(input [3:0] a_in ,b_in ,
                       input control_in, output [3:0] result_out, output carry_out);
reg [4:0] temp_result;
assign {carry_out , result_out} = a_in + temp_result;

always @*
if (~control_in)
temp_result= b_in + control_in;
else
temp_result = (~b_in) + control_in;
endmodule


module test_add_sub;

reg [3:0] a_in, b_in;
reg control_in;
wire [3:0] result_out;
wire carry_out;

four_bit_adder_subtractor2 UUT(a_in(a_in), b_in(b_in), control_in(control_in), result_out(result_out), carry_out(carry_out));

initial
begin
a_in = 4'b0000;
b_in = 4'b0000;
control_in = 0;
#10
a_in = 4'b1000;
b_in = 4'b0010;
control_in = 0;
#10
a_in = 4'b1000;
b_in = 4'b0110;
#10
a_in = 4'b1000;
b_in = 4'b0111;
control_in = 1;
#50
a_in = 4'b1000;
b_in = 4'b1111;
control_in = 1;
#10
a_in = 4'b0111;
b_in = 4'b0111;
control_in = 0;
#10
a_in = 4'b0111;
b_in = 4'b0111;
control_in = 1;
end
endmodule
