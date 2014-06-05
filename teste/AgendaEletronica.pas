program
  agendaEletronica;
 
uses
  crt, sysutils;
 
type
  contato = record
    nome: string[30];
    diaAniversario: integer;
    mesAniversario: integer;
    telefone: string[15];
  end;
 
function exibirMenu: integer;
var
  opcao: integer;
begin
  clrscr;
 
  writeln('     AGENDA ELETRONICA - striker07.wordpress.com');
  writeln;
  writeln(' 1. Inserir Contato');
  writeln(' 2. Buscar Contato');
  writeln(' 3. Atualizar Telefone');
  writeln(' 4. Excluir Contato');
  writeln(' 5. Encerrar');
  writeln;
  write(' Digite a opcao desejada: ');
  readln(opcao);
 
  exibirMenu := opcao;
end;
 
procedure gravarContato;
var
  meuContato: contato;
  arquivo: file of contato;
begin
  clrscr;
 
  writeln('     AGENDA ELETRONICA - INSERIR CONTATO');
  writeln;
  write(' Nome: ');
  readln(meuContato.nome);
  write(' Dia do Aniversario: ');
  readln(meuContato.diaAniversario);
  write(' Mes do Aniversario: ');
  readln(meuContato.mesAniversario);
  write(' Telefone: ');
  readln(meuContato.telefone);
 
  assign(arquivo, 'contatos.dat');
  {$I-} reset(arquivo); {$I+};
  if ioresult <> 0 then
    rewrite(arquivo);
 
  if filesize(arquivo) > 0 then
    seek(arquivo, filesize(arquivo));
 
  write(arquivo, meuContato);
  close(arquivo);
end;
 
procedure buscarContato;
var
  encontrado: boolean;
  busca: string[30];
  meuContato: contato;
  arquivo: file of contato;
begin
  encontrado := false;
  clrscr;
 
  writeln('     AGENDA ELETRONICA - BUSCAR CONTATO');
  writeln;
  write(' Nome do Contato: ');
  readln(busca);
 
  assign(arquivo, 'contatos.dat');
  {$I-} reset(arquivo); {$I+};
  if ioresult <> 0 then
  begin
    writeln;
    write(' Nada encontrado no arquivo!');
    sleep(1000);
  end
  else
  begin
    seek(arquivo, 0);
    while not eof(arquivo) do
    begin
      read(arquivo, meuContato);
      if meuContato.nome = busca then
      begin
        encontrado := true;
        writeln;
        writeln(' Nome: ', meuContato.nome);
        writeln(' Aniversario: ', meuContato.diaAniversario, '/', meuContato.mesAniversario);
        write(' Telefone: ', meuContato.telefone);
        sleep(2000);
      end;
    end;
 
    if encontrado = false then
    begin
      writeln;
      write(' Contato nao encontrado!');
      sleep(1000);
    end;
 
    close(arquivo);
  end;
end;
 
procedure atualizarTelefone;
var
  encontrado: boolean;
  nome: string[30];
  telefone: string[15];
  contatoTemporario: contato;
  arquivoAntigo, arquivoAtualizado: file of contato;
begin
  encontrado := false;
 
  clrscr;
 
  writeln('     AGENDA TELEFONICA - ATUALIZAR TELEFONE');
  writeln;
  write(' Nome do Contato: ');
  readln(nome);
  write(' Novo Telefone: ');
  readln(telefone);
 
  assign(arquivoAntigo, 'contatos.dat');
  {$I-} reset(arquivoAntigo); {$I+};
  if ioresult = 0 then
  begin
    assign(arquivoAtualizado, 'temp.dat');
    {$I-} rewrite(arquivoAtualizado); {$I+};
    if ioresult <> 0 then
    begin
      writeln;
      write(' Falha na atualizacao do contato!');
      close(arquivoAntigo);
      sleep(1000);
    end
    else
    begin
      seek(arquivoAntigo, 0);
      while not eof(arquivoAntigo) do
      begin
        read(arquivoAntigo, contatoTemporario);
        if nome = contatoTemporario.nome then
        begin
          contatoTemporario.telefone := telefone;
          encontrado := true;
        end;
        write(arquivoAtualizado, contatoTemporario);
      end;
      close(arquivoAntigo);
      close(arquivoAtualizado);
      erase(arquivoAntigo);
      rename(arquivoAtualizado, 'contatos.dat');
 
      writeln;
      if encontrado then
        write(' Atualizacao realizada com sucesso!')
      else
        write(' Nao foi possivel encontrar o contato...');
      sleep(1000);
    end;
  end
  else
  begin
    writeln;
    write(' Nenhum contato encontrado!');
    sleep(1000);
  end;
end;
 
procedure excluirContato;
var
  encontrado: boolean;
  nome: string[30];
  contatoTemporario: contato;
  arquivoAntigo, arquivoAtualizado: file of contato;
begin
  encontrado := false;
 
  clrscr;
 
  writeln('     AGENDA TELEFONICA - EXCLUIR TELEFONE');
  writeln;
  write(' Nome do Contato: ');
  readln(nome);
 
  assign(arquivoAntigo, 'contatos.dat');
  {$I-} reset(arquivoAntigo); {$I+};
  if ioresult = 0 then
  begin
    assign(arquivoAtualizado, 'temp.dat');
    {$I-} rewrite(arquivoAtualizado); {$I+};
    if ioresult <> 0 then
    begin
      writeln;
      write(' Falha na exclusao do contato!');
      close(arquivoAntigo);
      sleep(1000);
    end
    else
    begin
      seek(arquivoAntigo, 0);
      while not eof(arquivoAntigo) do
      begin
        read(arquivoAntigo, contatoTemporario);
        if nome <> contatoTemporario.nome then
        begin
          write(arquivoAtualizado, contatoTemporario);
        end
        else
          encontrado := true;
      end;
      close(arquivoAntigo);
      close(arquivoAtualizado);
 
      erase(arquivoAntigo);
      rename(arquivoAtualizado, 'contatos.dat');
 
      writeln;
      if encontrado then
        write(' Exclusao realizada com sucesso!')
      else
        write(' Nao foi possivel encontrar o contato...');
      sleep(1000);
    end;
  end
  else
  begin
    writeln;
    write(' Nenhum contato encontrado!');
    sleep(1000);
  end;
end;
 
var
  opcao: integer;
 
begin
  repeat
    opcao := exibirMenu;
 
    case opcao of
      1: gravarContato;
      2: buscarContato;
      3: atualizarTelefone;
      4: excluirContato;
      5:
        begin
          writeln;
          write(' Encerrando...');
        end
      else
        begin
          writeln;
          write(' Opcao invalida!');
        end
    end;
    sleep(1000);
  until opcao = 5;
end.