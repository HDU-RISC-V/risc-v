module PC(
    input [31:0] PC_In,
    input PC_Write,
    input clk,
    output reg [31:0] PC_Out
);
initial begin
    pc_out = 0;
end

always @(posedge clk) begin
    if (PC_Write) begin
        pc_out = pc_in;
    end
end

endmodule