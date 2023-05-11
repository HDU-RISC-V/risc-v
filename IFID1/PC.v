module PC(
    input [31:0] PC_In,
    input PC_Write,
    input clk,
    output reg [31:0] PC_Out
);
initial begin
    PC_Out = 0;
end

always @(posedge clk) begin
    if (PC_Write) begin
        PC_Out = PC_In;
    end
end

endmodule