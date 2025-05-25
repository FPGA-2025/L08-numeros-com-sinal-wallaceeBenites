module numeros_com_sinal(
    input signed [7:0] entrada_signed_1,
    input signed [3:0] entrada_signed_2,
    input [7:0] entrada_unsigned_1,
    input [3:0] entrada_unsigned_2,
    input [1:0] codigo,
    output reg [7:0] saida
);

//insira seu codigo aqui
always @(*) begin
    case (codigo)
        2'b00: begin
            saida = entrada_signed_1 + entrada_signed_2;
        end
        2'b01: begin
            saida = entrada_unsigned_1 + entrada_unsigned_2;
        end
        2'b10: begin
            saida = entrada_unsigned_1 + entrada_signed_1;
        end
        2'b11: begin
            saida = entrada_unsigned_1 + entrada_signed_2;
        end
        default: begin
            saida = 8'b0; 
        end
    endcase
end

endmodule