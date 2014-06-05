Unit Repository;

interface

Uses Crt;

type
	user = record
		nome, senha:string[15];
		tipoDeUser, identificador:integer;
	end;
	
	livro = record
		nome, autor, editora, obra, isbn: string;
		anoPubl, identificador: integer;
	end;
	
	cliente = record
		nome: string[45];
		cpf: string[11];
		livroEmpre: array[1..3] of livro;
		emprestimos: integer;
	end;
	
	type cadCliente = record
		idCliente: integer;
		nomeCliente: String[60];
		cpfCliente: String[11];
	end;
	
	type cadEmprestimo = record     
		idCliente: integer;	 
		idLivro: integer;
		dataEmprestimo: String;
		statusEmp: String;
	end;
	
implementation

End.