module mux_4to1(input [3:0] d_in, input [1:0] sel_in,  output reg y_out);
always @*
begin
if (sel_in == 2'b00)
y_out = d_in[0];
else if (sel_in == 2'b01)
y_out = d_in[1];
else if (sel_in == 2'b10)
y_out = d_in[2];
else
y_out = d_in[3];
end
endmodule

module mux_4to1_1(input [3:0] d_in, input [1:0] sel_in,  output reg y_out);
always @*
begin
case (sel_in)
2'b00 : y_out = d_in[0];
2'b01 : y_out = d_in[1];
2'b10 : y_out = d_in[2];
2'b11 : y_out = d_in[3];
endcase
end
endmodule

module mux_4to1_2(input [3:0] d_in, input [1:0] sel_in,  output reg y_out);
reg tmp_1, tmp_2;
always @*
begin
case (sel_in[0])
1'b0: begin
        tmp_1 = d_in[0];
        tmp_2 = d_in[2];
end
1'b1: begin
        tmp_1 = d_in[1];
        tmp_2 = d_in[3];
      end
endcase
end
assign y_out = (sel_in[1]) ? tmp_2 : tmp_1;
endmodule

