module IR(
    input [31:0] IR_In,
    input IR_Write,
    input clk,
    output reg [31:0] IR_Out
);
initial
begin
    IR_Out = 0;
end

always @(posedge clk) begin
    if (IR_Write)
    begin
        IR_Out <= IR_In;
    end
end
endmodule