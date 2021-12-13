module not_gate(input a_in, output reg y_out);
always @(a_in)
begin
y_out = ~a_in;
end
endmodule

module not_gate1(input a_in, output  y_out);
assign y_out = ~a_in;
endmodule
