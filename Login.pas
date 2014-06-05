Program Login;
uses 
Crt, Visual1, sysutils, Regs, Repository;
var
us: user;
cont: boolean;	
Begin
	cont:= false;
	logarConta(us);
	telaPrincipal(us, cont);
End.