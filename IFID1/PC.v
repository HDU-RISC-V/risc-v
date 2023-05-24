module PC(
    input [31:0] PC_In,
    input PC_Write,
    input clk,
    input rst_n,
    output reg [31:0] PC_Out
);
initial begin
    PC_Out = 0;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        PC_Out <= 0;
    end
    else if(PC_Write) begin
        PC_Out <= PC_In;
    end
end

endmodule