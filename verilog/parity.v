module even_parity_detector(input [7:0] data_in, output parity_out);

assign parity_out =^ data_in;

endmodule