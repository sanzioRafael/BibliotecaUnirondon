Unit Visual1;
interface
uses Crt, sysutils;
const
TLINHA = 24;
TCOLUNA = 80;

procedure carregando(c:string);
procedure montarTela(t,c:string);

implementation
	
	//Procedimento responsável pela animação de "carregando..." no sistema.
	procedure carregando(c:string);
	var
	c1, c2, c3, c4: string[13];
	i:integer;
	begin
		//Posiciona o cursor coluna 1 da linha "TLINHA"
		gotoxy(1,TLINHA);
		//pega o valor referenciado e monta a animação
		c1:= c;
		c2:= concat(c,'.');
		c3:= concat(c,'..');
		c4:= concat(c,'...');
		//loop que monta tela, define a cor de fundo
		textbackground(red);
		textbackground(red);
		for i:=0 to 20 do
		begin
			clrscr;
			textcolor(white);
			textbackground(red);
			if(i = 0)then
			begin
				write(c1);
				delay(100);
			end
			else if((i = 1)or(i = 5)or(i = 9)or(i = 12)or(i = 15)or(i = 18))then
			begin
				write(c2);
				delay(100);
			end
			else if((i = 2)or(i = 6)or(i = 10)or(i = 13)or(i = 16)or(i = 19))then
			begin
				write(c3);
				delay(100);
			end
			else if((i = 3)or(i = 7)or(i = 11)or(i = 14)or(i = 17)or(i = 20))then
			begin
				write(c4);
				delay(100);
			end;
		end;
	end;

	(*
	procedimento que monta as telas de interação do sistema, e também define o titulo e a aninação de
	"carregando.." no sistema.
	*)
	procedure montarTela(t,c: string);
	var
	i:integer;
	begin
		clrscr;
		carregando(c);
		
		for i:=1 to TCOLUNA do
		begin
			textbackground(white);
			
			gotoxy(i,1);
			write(' ');
			gotoxy(i,2);
			write(' ');
			gotoxy(i,3);
			write(' ');
			
			gotoxy(i,TLINHA+1);
			write(' ');
			
		end;
		
		gotoxy(35, 2);
		textcolor(black);
		write(t);
		sleep(20);
		textbackground(red);
		textcolor(white);
	end;
	
End.