module half_adder(input wire A, B, output wire S, C);

/* Design functionality */

xor_gate U1 (A .A,  B .B, S .S) ;

and_gate U2 (A .A, B .B,C .C);

endmodule

module xor_gate(input wire A, B, output wire S);
/* Design functionality */
assign S = A ^ B;
endmodule

module and_gate(input wire A, B, output wire C);

/* Design functionality */
assign C = A & B;
endmodule