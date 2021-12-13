module tri_state_logic(input [3:0] data_in, input enable, output reg [3:0] data_out);

always @(data_in, enable)
begin
if (enable)
data_out = data_in;
else
data_out = 4'bZZZZ;
end
endmodule

