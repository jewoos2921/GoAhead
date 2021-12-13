module mux_2to1(input a_in, b_in, sel_in, output y_out);
assign y_out = (sel_in) ? b_in : a_in;
endmodule

module mux_2to1_1(input a_in, b_in, sel_in, output reg y_out);
always @*
begin
if (sel_in)
y_out = b_in;
else
y_out = a_in;
end
endmodule

module mux_2to1_2(input a_in, b_in, sel_in, output reg y_out);
always @*
begin
case (sel_in)
1'b0: y_out = a_in;
1'b1: y_out = b_in;
endcase
end
endmodule

