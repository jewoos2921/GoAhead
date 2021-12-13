module encoder_4to2(input [3:0] data_in, output reg invalid_data,
                    output reg [1:0] y_out);
always @*
begin
case (data_in)
4'b0001: {invalid_data , y_out } = 3'b000;
4'b0010: {invalid_data , y_out } = 3'b001;
4'b0100: {invalid_data , y_out } = 3'b010;
4'b1000: {invalid_data , y_out } = 3'b011;
default: {invalid_data , y_out } = 3'b100;
endcase
end
endmodule

module encoder_4to2_priority(input [3:0] data_in, output reg invalid_data,
                    output reg [1:0] y_out);
always @*
begin
if (data_in[3])
{invalid_data, y_out} = 3'b000;
else if (data_in[2])
{invalid_data, y_out} = 3'b001;
else if (data_in[1])
{invalid_data, y_out} = 3'b010;
else if (data_in[0])
{invalid_data, y_out} = 3'b011;
else
{invalid_data, y_out} = 3'b100;
end
endmodule



module test_encoder_4to2;

// input
reg [3:0] data_in;
// output
wire invalid_data;
wire [1:0] y_out;
// Instantiate the Unit Under Test (UUT)
encoder_4to2_priority uut(.data_in(data_in), .invalid_data(invalid_data), .y_out(y_out));

always #5 data_in[0] = ~data_in[0];
always #10 data_in[1] = ~data_in[1];
always #20 data_in[2] = ~data_in[2];
always #40 data_in[3] = ~data_in[3];

initial
begin
// Initialize Inputs
data_in = 0;

// Wait 100ns and then force enable_in =1
#100
end
endmodule

