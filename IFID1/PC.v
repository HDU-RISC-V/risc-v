module PC(
    input [31:0] pc_in,
    input PC_Write,
    input clk,
    output reg [31:0] pc_out
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