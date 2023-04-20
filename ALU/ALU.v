module ALU (
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] out,
    output reg ZF,CF,OF,SF
);

    always @(*) begin
        
        if (op ==4'b0000) begin
            {CF,out} <= a + b;
        end

        else if (op ==4'b0001) begin
            {CF,out} <= a << b;
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

        // INC
        else if (op ==4'b1010) begin
            {CF,out} <= a+1;
        end

        // DEC
        else if (op ==4'b1011) begin
            {CF,out} <= a-1;
        end

        ZF<=(out==0)?1:0;
        // OF<=CF^out[31]^a[31]^b[31];
        OF<=CF^out[31];
        SF<=out[31];
    end

endmodule