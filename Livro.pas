Unit Livro;
interface
uses Crt, sysutils, Repository, Visual1;

procedure Livro;

implementation

	procedure Livro;
	var
	livros, auxLivro: livro;
	arqU, arqAtualizado: file of livro;
	cod: char;
	i, j, k: integer;
	controladora, encontrado: boolean;
	Begin
		controladora:= false;
		encontrado:= false;
		repeat
			montarTela(('Livros'), 'Carregando');
			
			
			gotoxy(10, 10);
			write('1 - Cadastrar Livro');
			
			gotoxy(10, 12);
			write('2 - Excluir Livro');
			
			gotoxy(10, 14);
			write('3 - Alterar Livro');
			
			gotoxy(10, 16);
			write('4 - Consultar Livro');
			
			gotoxy(10, 18);
			write('5 - Voltar');
			
			repeat
				cod:= readkey;
			until((cod = #49)or(cod = #50)or(cod = #51)or(cod = #52)or(cod = #53));
			
			case cod of
				'1':begin
					i:= 5;
					
					montarTela('Cadastro', 'Carregando');
					
					gotoxy(10, i);
					write('Digite o nome do livro: ');
					readln(livros.nome);
					
					i:= i + 2;
					gotoxy(10, i);
					write('Digite o autor: ');
					readln(livros.autor);
					
					i:= i + 2;
					gotoxy(10,i);
					write('Digite a editora: ');
					readln(livros.editora);
					
					i:= i + 2;
					gotoxy(10,i);
					write('Digite a obra: ');
					readln(livros.obra);
					
					i:= i + 2;
					gotoxy(10,i);
					write('Digite o isbn: ');
					readln(livros.isbn);
					
					i:= i + 2;
					gotoxy(10, i);
					write('Digite o ano de publica',#135,'ao: ');
					readln(livros.anoPubl);
					
					i:= i + 1;
					gotoxy(10, i);
					
					assign(arqU, 'aqv/livros.dat');
					{$I-}reset(arqU);{$I+};
					
					if IOresult <> 0 then
						rewrite(arqU);
						
					if filesize(arqU) > 0 then
					begin
						livros.identificador:= filesize(arqU);
						seek(arqU, filesize(arqU));
					end;
					
					write(arqU, livros);
					close(arqU);
					
					i:= i + 2;
					
					gotoxy(10, i);
					write('Cadastro realizado com sucesso');
					sleep(1000);
					
				end;
				'2':begin
				
					montarTela('Excluir', 'Carregando');
					
					assign(arqU,'aqv/livros.dat');
					{$I-} RESET(arqU);{$I+}
					if(IORESULT = 0)then
					begin
						i:= 5;
						while(not EOF(arqU))do
						begin
							read(arqU, livros);
							gotoxy(5, i);
							write(livros.identificador,' - Nome: ',livros.nome,' - Autor: ',livros.autor,' - Editora: ',livros.editora);
							
							i:= i + 1;
							gotoxy(5, i);
							write('Obra: ',livros.obra,' - ISBN: ',livros.isbn,' - Ano de Publica',#135,'ao: ',livros.anoPubl);
							
							i:= i + 1;
							gotoxy(5, i);
							write('----------------------------');
							
							i:= i + 1;
							j:= livros.identificador;
						end;
					end
					else writeln('Erro ao manipular arquivo');
					close(arqU);
					
					i:= i + 2;
					
					gotoxy(10, i);
					write('Quem voc',#136,' deseja excluir',#40,'Digite o n',#163,'mero dele',#41,':');
					repeat
						cod:= readkey;
					until(((ord(cod) - 48) >= 0)and((ord(cod) - 48) <= j));
					
					j:= ord(cod) - 48;
					
					assign(arqU, 'aqv/livros.dat');
					{$I-}reset(arqU);{$I+};
					
					if(ioresult = 0)then
					begin
						assign(arqAtualizado, 'aqv/tlivros.dat');
						{$I-}rewrite(arqAtualizado);{$I+};
						
						if(ioresult <> 0)then
						begin
							i:= i + 2;
							gotoxy(10, i);
							write('Falha em excluir o livro!');
							close(arqU);
							sleep(1000);
						end
						else
						begin
							seek(arqU, 0);
							while(not(eof(arqU)))do
							begin
								read(arqU, auxLivro);
								
								if(j <> auxLivro.identificador)then
								begin
									write(arqAtualizado, auxLivro);
								end
								else
								begin
									encontrado:= true;
								end;
							end;
							close(arqU);
							close(arqAtualizado);
							
							erase(arqU);
							rename(arqAtualizado, 'aqv/livros.dat');
							
							i:= i + 2;
							gotoxy(10, i);
							
							if(encontrado)then
								write('Livro exclu',#161,'do com sucesso')
							else
								write('N',#198,'o foi possivel');
							
							sleep(2000);
							
						end;
					end;
					
				end;
				'3':begin
					
					montarTela('Alterar', 'Carregando');
					
					assign(arqU,'aqv/livros.dat');
					{$I-} RESET(arqU);{$I+};
					if(IORESULT = 0)then
					begin
						i:= 5;
						while(not EOF(arqU))do
						begin
							read(arqU, livros);
							gotoxy(5, i);
							write(livros.identificador,' - Nome: ',livros.nome,' - Autor: ',livros.autor,' - Editora: ',livros.editora);
							
							i:= i + 1;
							gotoxy(5, i);
							write('Obra: ',livros.obra,' - ISBN: ',livros.isbn,' - Ano de Publica',#135,'ao: ',livros.anoPubl);
							
							i:= i + 1;
							gotoxy(5, i);
							write('----------------------------');
							
							i:= i + 1;
							j:= livros.identificador;
						end;
					end
					else writeln('Erro ao manipular arquivo');
					close(arqU);
					
					i:= i + 2;
					
					gotoxy(10, i);
					write('Quem voc',#136,' deseja alterar',#40,'Digite o n',#163,'mero dele',#41,':');
					repeat
						cod:= readkey;
					until(((ord(cod) - 48) >= 0)and((ord(cod) - 48) <= j));
					
					k:= ord(cod) - 48;
					
					montarTela('Alterar', 'Carregando');
					
					i:= 5;
					
					gotoxy(10, i);
					write('Digite o nome do livro: ');
					readln(livros.nome);
					
					i:= i + 2;
					gotoxy(10, i);
					write('Digite o autor: ');
					readln(livros.autor);
					
					i:= i + 2;
					gotoxy(10,i);
					write('Digite a editora:');
					readln(livros.editora);
					
					i:= i + 2;
					gotoxy(10,i);
					write('Digite a obra:');
					readln(livros.obra);
					
					i:= i + 2;
					gotoxy(10,i);
					write('Digite o isbn:');
					readln(livros.isbn);
					
					i:= i + 2;
					gotoxy(10, i);
					write('Digite o ano de publica',#135,'ao:');
					readln(livros.anoPubl);
					
					{$I-} reset(arqU);{$I+};
					seek(arqU, k);
					write(arqU, livros);
					close(arqU);
				end;
				'4':begin
					montarTela('Livros', 'Carregando');
					
					assign(arqU,'aqv/livros.dat');
					{$I-} RESET(arqU);{$I+}
					if(IORESULT = 0)then
					begin
						i:= 5;
						while(not EOF(arqU))do
						begin
							read(arqU, livros);
							gotoxy(5, i);
							write(livros.identificador,' - Nome: ',livros.nome,' - Autor: ',livros.autor,' - Editora: ',livros.editora);
							
							i:= i + 1;
							gotoxy(5, i);
							write('Obra: ',livros.obra,' - ISBN: ',livros.isbn,' - Ano de Publica',#135,'ao: ',livros.anoPubl);
							
							i:= i + 1;
							gotoxy(5, i);
							write('----------------------------');
							
							i:= i + 1;
							j:= livros.identificador;
						end;
					end
					else writeln('Erro ao manipular arquivo');
					close(arqU);
					
					i:= i + 2;
					gotoxy(10, i);
					write('Aperte qualquer tecla para voltar');
					readkey;
					
				end;
				'5':begin
					controladora:= true;								
				end;
			end;
		until(controladora);
	End;
End.