Unit Regs;

interface

uses Crt, Visual1, sysutils, Usuario, Livro, CadCli, Repository;

(*
*	Registro do sistema, o registro user é o registro dos usuários do sistema.
*	O registro livro é o registro dos livros que seram manipulados no sistema e na biblioteca.
*	O registro cliente é o registro dos clientes que iram ser manipulados e controlados pelos usuários do sistemas
*)

function verificaTeclado(c:char):boolean;
function protegerSenha:string;
function verificarUsuario(var us: user):boolean;
procedure logarConta(var us1: user);
procedure controlaAction(var c: char; usuar: user; var cont: boolean);
procedure TelaPrincipal(usuario: user; var cont: boolean);

implementation

	//Verifica se o botão digitado no teclado é valido para ser analizado na senha
	function verificaTeclado(c:char):boolean;
	var 
	aux: boolean;
	Begin
		aux:= false;
		if(c = #13)and(c = #49)and(c = #50)and(c = #51)and(c = #52)and(c = #53)and(c = #54)and(c = #55)and(c = #56)
		and(c = #57)and(c = #65)and(c = #66)and(c = #67)and(c = #68)and(c = #69)and(c = #70)and(c = #71)and(c = #72)and
		(c = #73)and(c = #74)and(c = #75)and(c = #76)and(c = #77)and(c = #78)and(c = #79)and(c = #80)and(c = #81)and
		(c = #82)and(c = #83)and(c = #84)and(c = #85)and(c = #86)and(c = #87)and(c = #88)and(c = #89)and(c = #90)and
		(c = #97)and(c = #98)and(c = #99)and(c = #100)and(c = #101)and(c = #102)and(c = #103)and(c = #104)and(c = #105)and
		(c = #106)and(c = #107)and(c = #108)and(c = #109)and(c = #110)and(c = #111)and(c = #112)and(c = #113)and(c = #114)and
		(c = #115)and(c = #116)and(c = #117)and(c = #118)and(c = #119)and(c = #120)and(c = #121)and(c = #122)and(c = #123)and
		(c = #124)
		then
		begin
			aux:= true;
		end;
		
		verificaTeclado:= aux;
	End;
	
	//Função que retorna a string protegida e captura os dados digitados
	function protegerSenha:string;
	var
	t:char;
	text:string[15];
	fim:boolean;
	cont:integer;
	Begin
		fim:= false;
		t:= ' ';
		text:= '';
		cont:= 0;
		repeat
			t:= readkey;
						
			if text = '' then
			begin
				text:= t;
				cont:= cont + 1;
				write(#42);
			end
			else if(t = #13)then
			begin
				fim:= true
			end
			else if((t <> '')and(t <> #13))then
			begin
				text:= text + t;
				fim:= false;
				cont:= cont + 1;
				write(#42);
			end;
			
		until(fim);
		protegerSenha:= text;
	End;
	
	//Verifica o tipo de usuário que vai ultilizar o sistema, se for 0 é administrador, e se for 1 é atendente
	function verificarUsuario(var us: user):boolean;
	var
	usuario: user;
	arq: file of user;
	a: boolean;
	Begin
		assign(arq, 'aqv/users.dat');
		{$I-}reset(arq);{$I+};
		a:= false;
		if ioresult <> 0 then
		begin
			gotoxy(10, 16);
			write('N',#198,'o h',#160,' usu',#160,'rios no sistema');
			a:= false;
		end
		else
		begin
			seek(arq, 0);
			while(not eof(arq)or(a = true))do
			begin
				read(arq, usuario);
				if(usuario.nome = us.nome)and(usuario.senha = us.senha)then
				begin
					a:= true;
					us:= usuario;
					break;
				end
				else
				begin
					a:= false;
				end;
			end
		end;
		close(arq);
		if(a = false)then
		begin
			gotoxy(10, 16);
			write('Login ou senha Inv',#160,'lidos!');
			readkey;
		end
		else
		begin
			gotoxy(10, 16);
			write('Login e senha V',#160,'lidos');
			readkey;
		end;
		verificarUsuario:= a;
	End;
	
	//Loga a conta no sistema ultilizando nos procedimentos e funções anteriores
	procedure logarConta(var us1: user);
	var
	aux:boolean;
	valor1, valor2:string[15];
	entrar:string[1];
	Begin
		aux:= false;
		repeat
			montarTela('Login Blibioteca', 'Carregando');
						
			gotoxy(10,10);
			write('Login: ');
			readln(valor1);
			
			gotoxy(10,12);
			write('Senha: ');
			valor2:= protegerSenha;
			
			if((length(valor1) > 0)and(length(valor1) <= 15))and((length(valor2) > 0)and(length(valor2) <= 15))then
			begin
				aux:= true;
				us1.nome:= valor1;
				us1.senha:= valor2;
				
				gotoxy(10,14);
				write('Deseja entrar : S\N');
				
				repeat
					entrar:= readkey;
				until((entrar = 's')or(entrar = 'S')or(entrar = 'n')or(entrar = 'N'));
				
				entrar:= UpperCase(entrar);
				if(entrar = 'S')then
				begin
					aux:= verificarUsuario(us1);
				end
				else if(entrar = 'N')then
				begin
					aux:= false;
				end;
			end
			else 
			begin
				aux:= false;
				gotoxy(10,14);
				textcolor(black);
				write('N',#198,'o foi digitado a senha ou o login');
			end;
		until(aux);
	End;
		
	//Controla o que será aperatado na tela principal e o redireciona para onde deve ir
	procedure controlaAction(var c: char; usuar: user; var cont: boolean);
	Begin
		if(usuar.tipoDeUser = 0)then
		begin
			case c of
				'1':begin
						principalCliente;
					end;
				'2':begin
						Livro.Livro;
					end;
				'3':begin
						Usuario.Usuario;
					end;
				'4':begin
						cont:= true;
					end;
			end;
		end
		else if(usuar.tipoDeUser = 1)then
		begin
			case c of
				'1':begin
						principalCliente;
					end;
				'2':begin
						Livro.Livro;
					end;
				'3':begin
						cont:= true;
					end;
			end;
		end;
	End;
	
	//Tela principal do sistema onde gerência tudo o que o usuário pode fazer
	procedure TelaPrincipal(usuario: user; var cont: boolean);
	var
	codigo:char;
	Begin
		cont:= false;
		repeat
			if(usuario.tipoDeUser = 1)then
			begin
				clrscr;
				montarTela('Biblioteca', 'Inicializando');
				gotoxy(10, 10);
				write(usuario.nome,' Seja bem vindo ao sistema, voc',chr(136),' deseja fazer o que ?');
				
				gotoxy(10, 12);
				write('1 - Area Cliente');
				
				gotoxy(10, 14);
				write('2 - Area Livro');
				
				gotoxy(10, 16);
				write('3 - Encerrar');
				
				repeat
					codigo:= readkey;
				until((codigo = '1')or(codigo = '2')or(codigo = '3'));
				
				controlaAction(codigo, usuario, cont);
			end
			else if(usuario.tipoDeUser = 0)then
			begin
				montarTela('Biblioteca', 'Inicializando');
				gotoxy(10, 10);
				write(usuario.nome,' Seja bem vindo ao sistema, voc',chr(136),' deseja fazer o que ?');
				
				gotoxy(10, 12);
				write('1 - Area Cliente');
				
				gotoxy(10, 14);
				write('2 - Area Livro');
				
				gotoxy(10, 16);
				write('3 - Area Usu',chr(160),'rio');
				
				gotoxy(10, 18);
				write('4 - Encerrar');
				
				repeat
					codigo:= readkey;
				until((codigo = '1')or(codigo = '2')or(codigo = '3')or(codigo = '4'));
				
				controlaAction(codigo, usuario, cont);
			end;
		until(cont);
	End;
			
End.