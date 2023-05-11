module ADD(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] out,
);
    assign out = a + b;
endmodule