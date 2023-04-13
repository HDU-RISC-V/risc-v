module ALU (
    input rst_n ,
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] out,
    output reg ZF,CF,OF,SF
);

    always @(*) begin

        if (!rst_n) begin
            out <= 32'h00000000;
            ZF <= 1'b0;
            CF <=1'b0;
            OF <= 1'b0;
            SF <= 1'b0;
        end else
        
            if (op ==4'b0000) begin
                {CF,out} <= a + b;
            end

            else if (op ==4'b0001) begin
                out <= a << b;
            end

            else if (op ==4'b0010) begin
                // 有符号数比较
                if (a[31] == b[31]) begin
                    out <= a < b;
                end
                else begin
                    out <= a[31];
                end
            end

            else if (op ==4'b0011) begin
                out <= a < b;
            end

            else if (op ==4'b0100) begin
                out <= a ^ b;
            end

            else if (op ==4'b0101) begin
                out <= a >> b;
            end

            else if (op ==4'b0110) begin
                out <= a | b;
            end

            else if (op ==4'b0111) begin
                out <= a & b;
            end

            else if (op ==4'b1000) begin
                {CF,out} <= a - b;
            end

            else if (op ==4'b1101) begin
                // 有符号数右移
                if (a[31] == 1) begin
                    out <= a >> b;
                    out <= out | (32'hFFFFFFFF << (32 - b));
                end
                else
                    out <= a >> b;
            end

        ZF<=(out==0)?1:0;
        OF<=CF^out[31]^a[31]^b[31];
        SF<=out[31];
    end

endmodule