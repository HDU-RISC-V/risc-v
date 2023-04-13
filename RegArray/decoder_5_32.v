module Decoder_5_32(
    input [4:0] in,
    output [31:0] out
);
    assign out = 32h'00000001<<in;

endmodule