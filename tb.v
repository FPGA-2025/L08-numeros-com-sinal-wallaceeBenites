module tb();

reg [7:0] entrada_signed_1;
reg [3:0] entrada_signed_2;
reg [7:0] entrada_unsigned_1;
reg [3:0] entrada_unsigned_2;
reg [1:0] codigo;
wire signed [7:0] saida;

reg [25:0] dados_arquivo [0:3];

numeros_com_sinal n(
    .entrada_signed_1(entrada_signed_1),
    .entrada_signed_2(entrada_signed_2),
    .entrada_unsigned_1(entrada_unsigned_1),
    .entrada_unsigned_2(entrada_unsigned_2),
    .codigo(codigo),
    .saida(saida)
);

integer i;

initial begin
  
  $readmemb("teste.txt", dados_arquivo); // le o arquivo de entrada e guarda em dados_arquivo

  $dumpfile("saida.vcd");
  $dumpvars(0, tb);

  $monitor("entrada_signed_1=%b, entrada_signed_2=%b, entrada_unsigned_1=%b, entrada_unsigned_2=%b, codigo=%b, saida=%d", entrada_signed_1, entrada_signed_2, entrada_unsigned_1, entrada_unsigned_2, codigo, saida);
  
  for (i = 0; i < 4; i = i + 1) begin
    entrada_signed_1 = dados_arquivo[i][25:18];
    entrada_signed_2 = dados_arquivo[i][17:14];
    entrada_unsigned_1 = dados_arquivo[i][13:6];
    entrada_unsigned_2 = dados_arquivo[i][5:2];
    codigo = dados_arquivo[i][1:0];
    #1;
  end

end

endmodule