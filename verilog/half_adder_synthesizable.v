module half_adder(input wire A, B, output reg S, C);
always @*
begin
S = A ^ B;
C = A & B;
end
endmodule
