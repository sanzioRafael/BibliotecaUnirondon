Program CadCli;

uses Crt, Repository;

var
	cliente: cadCliente;
	resposta: String[1];
	totalReg, opcao: integer;	
	CPF: String;   
	cadastroLocalizado: BOOLEAN;       

	Arquivo: file of cadCliente;       

  	Procedure cadastrar;
		begin
		// Abre Arquivo para inserir o cadastro do cliente 
		Assign (Arquivo,'aqv/clientes.dat');  
		{$I-}  
	  
		Reset (Arquivo);  
		// Avancar ate o ultimo registro  
		Seek (Arquivo, FileSize(Arquivo));  
		{$I+}  
	  
		if IORESULT()<>0 then ReWrite(Arquivo);			
	  
		resposta:='S';
		while(resposta = 's') or (resposta='S') do
		begin	
			textbackground(red);
			ClrScr; 	
			
			//Nome da Tela
			TextColor(black);
			gotoxy(30,1);
			writeln('Cadastro de Cliente');		
		
			Seek (Arquivo,0);  
			// Leia o arquivo ate o final para obter a quantidade de registro e montar o ID do cliente
			totalReg:=1;		
			
			While Not(Eof(Arquivo)) Do  
			Begin  
				Read (Arquivo,cliente); 
				totalReg:=totalReg+1;
			End; 				
			
			
			TextColor(white);		
			gotoxy(15,3);
			writeln('Codigo.: ');
			
			gotoxy(25,3);
			writeln(totalReg);
					
			gotoxy(15,4);
			writeln('Nome...: ');
			
			gotoxy(15,5);
			writeln('CPF....: ');
			
			Gotoxy(25,4);		
			Readln(cliente.nomeCliente);
			Gotoxy(25,5);
			Readln(cliente.cpfCliente);				
			cliente.idCliente:= totalReg;
			
			Write(Arquivo,cliente);
			  
			//Caso o gerente queira cadastrar novo cliente a tela sera recarregada.		
			gotoxy(15,8);
			Write('Deseja cadastrar outro cliente? [S/N] ');		
			Readln(resposta);		
		end;
		Close(Arquivo);		
			
	end;	
	
	Procedure editar;
	var		
	clienteCpfNovo, clienteNomeNovo: String;
	posicao: integer;
	resposta: String;
	begin				
	clrscr;
	//Consultando cliente				
	// Abre Arquivo para inserir o cadastro do cliente 
	Assign (Arquivo,'aqv/clientes.dat');  			
	Reset (Arquivo); 
	cadastroLocalizado := FALSE;		
	clrscr;
	
	//Nome da Tela
	TextColor(black);		
	gotoxy(30,1);
	writeln('Pesquisar Cliente');		
	
	TextColor(white);
	gotoxy(15,4);
	write('Digite o CPF: ');		
	readln(CPF);	
	clrscr;
	
	posicao := 0;
	cadastroLocalizado := FALSE;
	while Not(Eof(Arquivo)) AND (cadastroLocalizado=FALSE) do	
	begin			
		Read(Arquivo,cliente);
		posicao := posicao + 1;	
		if cliente.cpfCliente = CPF then			
			begin				
			//Nome da Tela
			TextColor(black);
			gotoxy(30,1);
			writeln('Cadastro de Cliente - Editar');		
							
			TextColor(white);		
			gotoxy(15,3);
			writeln('Codigo.: ',cliente.idCliente);				
					
			gotoxy(15,4);
			writeln('Nome...: ',cliente.nomeCliente);			
			
			gotoxy(15,5);
			writeln('CPF....: ', cliente.cpfCliente);										
			
			gotoxy(24,4);
			readln(clienteNomeNovo);
			
			gotoxy(24,5);
			readln(clienteCpfNovo);
							
			cadastroLocalizado := TRUE;							
		
			if(clienteNomeNovo <>'') then
				begin
				cliente.nomeCliente:= clienteNomeNovo;
				end
			else
				begin
				cliente.nomeCliente:= cliente.nomeCliente;
				end;
				
			if(clienteCpfNovo <> '') then
				begin
				cliente.cpfCliente:= clienteCpfNovo;
				end
			else
				begin
				cliente.cpfCliente:= cliente.cpfCliente;
				end;			
		
			if(clienteNomeNovo <> '') OR (clienteCpfNovo <> '') then
				begin
				//gravando os dados alterados
				posicao:= posicao-1;
				SEEK(Arquivo,posicao);
				WRITE(Arquivo,cliente);
				gotoxy(24,7);
				WRITELN('ALTERACAO EFETUADA');					
				end;
		end;			
	end;			
			
	if (cadastroLocalizado = FALSE) then 
		begin
			//Nome da Tela
			TextColor(black);		
			gotoxy(30,1);
			writeln('Pesquisar Cliente');					
			TextColor(white);		
			gotoxy(24,5);
			writeln('Cadastro nao localizado');							
		end;	
	
	Close(Arquivo);		
	
	gotoxy(24,8);
	write('Deseja pesquisar outro cliente? S/N ');
	readln(resposta);
	if(resposta = 'S') OR (resposta='s') then
		begin
			editar;
		end;	
	end;
	
	procedure principal;
	begin 
	
	//Mostra as opcoes da tela de cliente		
	textbackground(red);
	ClrScr; 
		
	//Nome da Tela
	TextColor(black);
	gotoxy(30,1);
	writeln('Cadastro de Cliente');		

	TextColor(white);
	gotoxy(15,3);
	writeln(' ******** OP',#128#229,'ES ********');
	gotoxy(15,4);
	writeln(' 1 - Cadastrar ');
	gotoxy(15,5);
	writeln(' 2 - Alterar ');
		
	gotoxy(15,7);
	write(' Digite a op',#135#198,'o: ');
	readln(opcao);
		
	Case opcao of  
		1 : cadastrar;
		2 : editar;		      
		end;
	end; 

begin
	principal;	
end.
