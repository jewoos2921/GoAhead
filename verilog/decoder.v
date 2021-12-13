module decoder_1to2(input sel_in, input enable_in, output reg [1:0] y_out);
always @*
begin
if(enable_in)
case (sel_in)
1'b0 : y_out = 2'b01;
1'b1 : y_out = 2'b10;
endcase
else
y_out = 2'b00;
end
endmodule

// Verilog RTL for 1 line to 2 line decoder with active high enable input
module one_two_decoder_with_enable(Sel, En, Out_Y1, Out_Y0);
input Sel;
input En;
output Out_Y1;
output Out_Y0;
reg Out_Y0;
reg Out_Y1;

always @(Sel or En)
begin
if (En)
case (Sel)
1'b0 : {Out_Y1, Out_Y0} = 2'b01;
1'b1 : {Out_Y1, Out_Y0} = 2'b10;
endcase
else
{Out_Y1, Out_Y0} = 2'b00;
end
endmodule


module decoder_2to4(input[1:0] sel_in, input enable_in, output reg [3:0] y_out);
always @*
begin
if (enable_in)
case (sel_in)
2'b00: y_out = 4'b0001;
2'b01: y_out = 4'b0010;
2'b10: y_out = 4'b0100;
2'b11: y_out = 4'b1000;
endcase
else
y_out  = 4'b0000;
end
endmodule

// Verilog RTL for 2 Line to 4 Line decoder with active low enable input and active low output lines
module Two_to_Four_decoder(Sel, En_bar, Out_Y);
input[1:0] Sel;
input En_bar;
output reg [3:0] Out_Y;

always @(Sel or En_bar)
begin
if (~En_bar)
case (Sel)
2'b00: Out_Y = 4'b1110;
2'b01: Out_Y = 4'b1101;
2'b10: Out_Y = 4'b1011;
2'b11: Out_Y = 4'b0111;
endcase
else
Out_Y  = 4'b1111;
end
endmodule

// Verilog RTL for 2 Line to 4 Line decoder with active low enable input and active low output lines
module Two_to_Four_decoder_2(Sel, En_bar, Out_Y);
input[1:0] Sel;
input En_bar;
output  [3:0] Out_Y;

assign Out_Y[3] = (~En_bar) && (~Sel[1]) && (~Sel[0]);
assign Out_Y[2] = (~En_bar) && (~Sel[1]) && (Sel[0]);
assign Out_Y[1] = (~En_bar) && (Sel[1]) && (~Sel[0]);
assign Out_Y[0] = (~En_bar) && (Sel[1]) && (Sel[0]);
endmodule


module decoder_2_to_4(input [1:0] sel_in, input enable_in, output [3:0] y_out);

assign y_out[0] = enable_in & (~sel_in[1]) & (~sel_in[0]);
assign y_out[1] = enable_in & (~sel_in[1]) & (sel_in[0]);
assign y_out[2] = enable_in & (sel_in[1]) & (~sel_in[0]);
assign y_out[3] = enable_in & (sel_in[1]) & (sel_in[0]);
endmodule

module decoder_2_to_4_v1(input [1:0] sel_in, input enable_in, output [3:0] y_out);
always @*
begin
if (~enable_in)
y_out = 4'b0000;
else
y_out = (4'b0001<<sel_in);
end
endmodule

module test_decoder;

// input
reg [1:0] sel_in;
reg enable_in;
// output
wire [3:0] y_out;
// Instantiate the Unit Under Test (UUT)
decoder_2_to_4_v1 uut(.sel_in(sel_in), .enable_in(enable_in), .y_out(y_out));

always #10 sel_in[0] = ~sel_in[0];
always #20 sel_in[1] = ~sel_in[1];

initial
begin
// Initialize Inputs
sel_in = 0;
enable_in = 0;

// Wait 100ns and then force enable_in =1
#100
enable_in = 1;
// Wait 250 ns and then force enable_in =0
#250
enable_in = 0;
end
endmodule


module decoder_4to16(input [3:0] sel_in,  input enable_in, output [15:0] y_out);

reg [3:0] tmp_enable;

always@*
if (~enable_in)
tmp_enable = 4'b0000;
else
tmp_enable = (4'b0001 << sel_in[3:2]);
always@*
if (~tmp_enable[0])
y_out[3:0] = 4'b000;
else
y_out [3:0] = (4'b0001 << sel_in[1:0]);

always@*
if (~tmp_enable[1])
y_out[7:4] = 4'b000;
else
y_out[7:4] = (4'b0001 << sel_in[1:0]);

always@*
if (~tmp_enable[2])
y_out[11:8] = 4'b000;
else
y_out[11:8] = (4'b0001 << sel_in[1:0]);

always@*
if (~tmp_enable[3])
y_out[15:12] = 4'b000;
else
y_out[15:12] = (4'b0001 << sel_in[1:0]);
endmodule


module test_decoder_4to16;

// input
reg [3:0] sel_in;
reg enable_in;
// output
wire [15:0] y_out;
// Instantiate the Unit Under Test (UUT)
decoder_4to16 uut(.sel_in(sel_in), .enable_in(enable_in), .y_out(y_out));

always #5 sel_in[0] = ~sel_in[0];
always #10 sel_in[1] = ~sel_in[1];
always #20 sel_in[2] = ~sel_in[2];
always #40 sel_in[3] = ~sel_in[3];

initial
begin
// Initialize Inputs
sel_in = 0;
enable_in = 0;

// Wait 100ns and then force enable_in =1
#100
enable_in = 1;
// Wait 250 ns and then force enable_in =0
#250
enable_in = 0;
end
endmodule
