module Decoder_5_32(
    input [4:0] in,
    output [31:0] out
);
    reg [31:0] base = 32'h00000001;
    assign out = base<<in;

endmodule