module DM (
    input clk_dm,
    input Mem_Write,
    input [31:0] DM_Addr,
    input [31:0]  M_W_Data,
    output [31:0] M_R_Data
);
    reg [31:0] _data[0:255];
    wire [7:0] _addr;
    
    assign _addr=DM_Addr%256;
    assign M_R_Data=_data[_addr];

    always @(posedge clk_dm) begin
        if (Mem_Write) begin
            _data[_addr]<=M_W_Data;
        end
    end
    
endmodule