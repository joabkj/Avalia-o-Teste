unit u_dicionarioDados;

interface

uses
    System.SysUtils;

const
    //Valores Default
    cs_string_branco = '''''';

    cs_valor_id_defalt = 0;

    cs_produtos_sql = ' select * from produtos ';

    cs_criaProdutos = ' CREATE TABLE IF NOT EXISTS produtos                          '+
                      '(                                                             '+
                      ' id_produto serial NOT NULL,                                  '+
                      ' id_categoria integer NOT NULL,                               '+
                      ' nome varchar(100),                                           '+
                      ' preco_unitario numeric(10,2) default(0),                     '+
                      ' CONSTRAINT produto_pkey PRIMARY KEY (id_produto),            '+
                      '  CONSTRAINT produtos_to_categoria FOREIGN KEY (id_categoria) '+
                      '        REFERENCES categoria (id_categoria) MATCH SIMPLE      '+
                      '        ON UPDATE NO ACTION                                   '+
                      '        ON DELETE NO ACTION                                   '+
                      ')                                                             '+
                      'WITH (                                                        '+
                      '    OIDS = FALSE                                              '+
                      ')                                                             '+
                      'TABLESPACE pg_default;                                        '+
                      'ALTER TABLE IF EXISTS produtos                                '+
                      '    OWNER to postgres;                                        ';

    cs_criaCategoria = ' CREATE TABLE IF NOT EXISTS categoria                '+
                      '(                                                     '+
                      ' id_categoria serial NOT NULL,                        '+
                      ' nome varchar(100),                                   '+
                      ' CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria) '+
                      ')                                                     '+
                      'WITH (                                                '+
                      '    OIDS = FALSE                                      '+
                      ')                                                     '+
                      'TABLESPACE pg_default;                                '+
                      'ALTER TABLE IF EXISTS categoria                       '+
                      '    OWNER to "postgres";                              ';

     cs_criaUsuario =  ' CREATE TABLE IF NOT EXISTS usuario                '+
                       '(                                                  '+
                       ' id_usuario serial NOT NULL,                       '+
                       ' nome varchar(100),                                '+
                       ' usuario character varying(50),                    '+
                       ' senha character varying(50),                      '+
                       ' CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario)  '+
                       ')                                                  '+
                       'WITH (                                             '+
                       '    OIDS = FALSE                                   '+
                       ')                                                  '+
                       'TABLESPACE pg_default;                             '+
                       'ALTER TABLE IF EXISTS usuario                      '+
                       '    OWNER to "postgres";                           ';


       cs_criaProdutoEntrada = ' CREATE TABLE IF NOT EXISTS entradas                      '+
                      '(                                                            '+
                      ' id_entrada serial NOT NULL,                                 '+
                      ' id_produto integer NOT NULL,                                '+
                      ' data date,                                                  '+
                      ' quantidade integer NOT NULL,                                '+
                      ' CONSTRAINT entrada_pkey PRIMARY KEY (id_entrada),           '+
                      '  CONSTRAINT entradas_to_produtos FOREIGN KEY (id_produto)   '+
                      '        REFERENCES produtos (id_produto) MATCH SIMPLE        '+
                      '        ON UPDATE NO ACTION                                  '+
                      '        ON DELETE NO ACTION                                  '+
                      ')                                                            '+
                      'WITH (                                                       '+
                      '    OIDS = FALSE                                             '+
                      ')                                                            '+
                      'TABLESPACE pg_default;                                       '+
                      'ALTER TABLE IF EXISTS entradas                               '+
                      '    OWNER to postgres;                                       ';


     cs_criaProdutoSaidas = ' CREATE TABLE IF NOT EXISTS saidas                   '+
                      '(                                                          '+
                      ' id_saida serial NOT NULL,                                 '+
                      ' id_produto integer NOT NULL,                              '+
                      ' data date,                                                '+
                      ' quantidade integer NOT NULL,                              '+
                      ' CONSTRAINT saida_pkey PRIMARY KEY (id_saida),             '+
                      '  CONSTRAINT entradas_to_produtos FOREIGN KEY (id_produto) '+
                      '        REFERENCES produtos (id_produto) MATCH SIMPLE      '+
                      '        ON UPDATE NO ACTION                                '+
                      '        ON DELETE NO ACTION                                '+
                      ')                                                          '+
                      'WITH (                                                     '+
                      '    OIDS = FALSE                                           '+
                      ')                                                          '+
                      'TABLESPACE pg_default;                                     '+
                      'ALTER TABLE IF EXISTS saidas                               '+
                      '    OWNER to postgres;                                     ';



type
  TResultArray = array [1..5] of string;
  function DadosFormulario(p_tag: integer): TResultArray;

implementation

function DadosFormulario(p_tag: integer): TResultArray;
var
  Vet : TResultArray;
begin
  case p_tag of
    1 :
      begin
        Vet[1]:= 'produtos';
        Vet[2]:= 'NOME';
        Vet[3]:= 'ID_PRODUTO';
        Vet[4]:= 'true';
        vet[5]:= 'CADASTRO DE PRODUTOS';
      end;

    2 :
      begin
        Vet[1]:= 'categoria';
        Vet[2]:= 'NOME';
        Vet[3]:= 'ID_CATEGORIA';
        Vet[4]:= 'true';
        vet[5]:= 'CADASTRO DE CATEGORIAS';
      end;
  end;
  result:= Vet;
end;

end.
