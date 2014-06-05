program CriaUser;
uses Crt, sysutils, Regs, Visual1;
var
usuario, auxUser: user;
arqU, arqAtualizado: file of user;
cod: char;
i, j, k: integer;
controladora, encontrado: boolean;
Begin
	controladora:= false;
	encontrado:= false;
	repeat
		montarTela(('Usu'+#160+'rio'), 'Carregando');
		
		
		gotoxy(10, 10);
		write('1 - Cadastrar Usu'+#160+'rio');
		
		gotoxy(10, 12);
		write('2 - Excluir Usu'+#160+'rio');
		
		gotoxy(10, 14);
		write('3 - Alterar Usu'+#160+'rio');
		
		gotoxy(10, 16);
		write('4 - Mostrar Usu'+#160+'rio');
		
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
				write('Digite o seu login: ');
				readln(usuario.nome);
				
				i:= i + 2;
				gotoxy(10, i);
				write('Digite a sua senha: ');
				readln(usuario.senha);
				
				i:= i + 2;
				gotoxy(10, i);
				write('Digite o tipo de usu',chr(160),'rio que voc',chr(136),' ',chr(130),'?');
				
				i:= i + 1;
				gotoxy(10, i);
				write('0 - Administrador  |  1 - Atendente');
				
				i:= i + 1;
				gotoxy(10, i);
				
				repeat
					cod:= readkey;
					j:= ord(cod) - 48;
				until((j = 0)or(j = 1));
				
				usuario.tipoDeUser:= j;
				
				j:= 0;
				
				assign(arqU, 'aqv/users.dat');
				{$I-}reset(arqU);{$I+};
				
				if IOresult <> 0 then
					rewrite(arqU);
					
				if filesize(arqU) > 0 then
				begin
					usuario.identificador:= filesize(arqU);
					seek(arqU, filesize(arqU));
				end;
				
				write(arqU, usuario);
				close(arqU);
				
				i:= i + 2;
				
				gotoxy(10, i);
				write('Cadastro realizado com sucesso');
				sleep(1000);
								
			end;
			'2':begin
			
				montarTela('Excluir', 'Carregando');
				
				assign(arqU,'aqv/users.dat');
				{$I-} RESET(arqU);{$I+}
				if(IORESULT = 0)then
				begin
					i:= 5;
					while(not EOF(arqU))do
					begin
						read(arqU, usuario);
						gotoxy(10, i);
						write(usuario.identificador,' - Login: ',usuario.nome,' - Senha: ',usuario.senha,' - Tipo: ',usuario.tipoDeUser);
						i:= i + 1;
						j:= usuario.identificador;
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
				
				assign(arqU, 'aqv/users.dat');
				{$I-}reset(arqU);{$I+};
				
				if(ioresult = 0)then
				begin
					assign(arqAtualizado, 'aqv/tUser.dat');
					{$I-}rewrite(arqAtualizado);{$I+};
					
					if(ioresult <> 0)then
					begin
						i:= i + 2;
						gotoxy(10, i);
						write('Falha em excluir o usu',#160,'rio!');
						close(arqU);
						sleep(1000);
					end
					else
					begin
						seek(arqU, 0);
						while(not(eof(arqU)))do
						begin
							read(arqU, auxUser);
							
							if(j <> auxUser.identificador)then
							begin
								write(arqAtualizado, auxUser);
							end
							else
							begin
								encontrado:= true;
							end;
						end;
						close(arqU);
						close(arqAtualizado);
						
						erase(arqU);
						rename(arqAtualizado, 'aqv/users.dat');
						
						i:= i + 2;
						gotoxy(10, i);
						
						if(encontrado)then
							write('Usu',#160,'rio exclu',#161,'do com sucesso')
						else
							write('N',#198,'o foi possivel');
						
						sleep(2000);
						
					end;
				end;
				
			end;
			'3':begin
				
				montarTela('Alterar', 'Carregando');
				
				assign(arqU,'aqv/users.dat');
				{$I-} RESET(arqU);{$I+}
				if(IORESULT = 0)then
				begin
					i:= 5;
					while(not EOF(arqU))do
					begin
						read(arqU, usuario);
						gotoxy(10, i);
						write(usuario.identificador,' - Login: ',usuario.nome,' - Senha: ',usuario.senha,' - Tipo: ',usuario.tipoDeUser);
						i:= i + 1;
						j:= usuario.identificador;
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
				
				i:= i + 2;
				
				gotoxy(10, i);
				write('Digite o seu login: ');
				readln(usuario.nome);
				
				i:= i + 2;
				gotoxy(10, i);
				write('Digite a sua senha: ');
				readln(usuario.senha);
				
				i:= i + 2;
				gotoxy(10, i);
				write('Digite o tipo de usu',chr(160),'rio que voc',chr(136),' ',chr(130),'?');
				
				i:= i + 1;
				gotoxy(10, i);
				write('0 - Administrador  |  1 - Atendente');
				
				i:= i + 1;
				gotoxy(10, i);
				
				repeat
					cod:= readkey;
					j:= ord(cod) - 48;
				until((j = 0)or(j = 1));
				
				usuario.tipoDeUser:= j;
				
				j:= 0;
				
				assign(arqU, 'arq/users.dat');
				{$I-}reset(arqU);{$I+};
				
				i:= i + 2;
				
				if(ioresult = 0)then
				begin
					assign(arqAtualizado, 'aqv/tUsers.dat');
					{$I-}rewrite(arqAtualizado);{$I+};
					if(ioresult <> 0)then
					begin
						gotoxy(10, i);
						write('Falha na A',#135,'ao');
						close(arqU);
					end
				end
				else
				begin
					seek(arqU, 0);
					while not eof(arqU)do
					begin
						read(arqU, auxUser);
						if(k = auxUser.identificador)then
						begin
							auxUser:= usuario;
							encontrado:= true;
						end;
						write(arqAtualizado, auxUser);
					end;
					close(arqU);
					close(arqAtualizado);
					erase(arqU);
					rename(arqAtualizado, 'aqv/users.dat');
					
					i:= i + 2;
					gotoxy(10, i);
					
					if(encontrado)then
						write('Alterado com sucesso')
					else
						write('Imposs',#161,'vel encontrar o usu',#160,'rio...');
					
				end;
				sleep(1500);
				
			end;
			'4':begin
				montarTela(('Usu'+#160+'rios'), 'Carregando');
				
				assign(arqU,'aqv/users.dat');
				{$I-} RESET(arqU);{$I+}
				if(IORESULT = 0)then
				begin
					i:= 5;
					while(not EOF(arqU))do
					begin
						read(arqU, usuario);
						gotoxy(10, i);
						write(usuario.identificador,' - Login: ',usuario.nome,' - Senha: ',usuario.senha,' - Tipo: ',usuario.tipoDeUser);
						i:= i + 1;
						j:= usuario.identificador;
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
End.