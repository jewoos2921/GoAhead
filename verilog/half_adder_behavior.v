module half_adder(input wire A, B, output reg S, C);

/* Design functionality to generate sum (S) output */

always @*
begin

if (A == B)
S = 0;
else
S=1;
end
/* Design functionality to generate carry (C) output */
always @*
begin
if (A== 1 && B ==1)
C = 1;
else
C = 0;
end

endmodule
