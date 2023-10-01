use strict;
use warnings;
use DBI;
use JSON;

# Configurações de conexão ao PostgreSQL
my $db_name = "bank";
my $db_user = "postgres";
my $db_pass = "1234";
my $db_host = "localhost";

# Conectar ao banco de dados
my $dbh = DBI->connect("dbi:Pg:dbname=$db_name;host=$db_host", $db_user, $db_pass, { AutoCommit => 1 })
    or die "Erro ao conectar ao banco de dados: $DBI::errstr";

# Função para cadastrar uma conta bancária
sub cadastrar_conta {
    my ($login, $senha, $cpf, $nome_completo, $saldo_inicial) = @_;
    
    # Inserir os dados na tabela contas
    my $insert = $dbh->prepare("INSERT INTO contas (login, senha, cpf, nome_completo, saldo) VALUES (?, ?, ?, ?, ?)");
    $insert->execute($login, $senha, $cpf, $nome_completo, $saldo_inicial);
    
    # Salvar os dados em um arquivo JSON
    my $contas = carregar_contas();
    push @$contas, {
        login => $login,
        senha => $senha,
        cpf => $cpf,
        nome_completo => $nome_completo,
        saldo => $saldo_inicial,
    };
    salvar_contas($contas);
    
    print "Conta cadastrada com sucesso!\n";
}

# Função para carregar contas a partir de um arquivo JSON
sub carregar_contas {
    my $json_data;
    if (-e 'contas.json') {
        open my $json_file, '<', 'contas.json' or die "Erro ao abrir contas.json: $!";
        local $/ = undef;
        $json_data = <$json_file>;
        close $json_file;
    }
    return $json_data ? decode_json($json_data) : [];
}

# Função para salvar contas em um arquivo JSON
sub salvar_contas {
    my ($contas) = @_;
    open my $json_file, '>', 'contas.json' or die "Erro ao abrir contas.json para escrita: $!";
    print $json_file encode_json($contas);
    close $json_file;
}

# Função para realizar login e visualizar informações
sub visualizar_informacoes {
    my ($login, $senha) = @_;
    
    # Consultar o banco de dados
    my $query = $dbh->prepare("SELECT * FROM contas WHERE login = ? AND senha = ?");
    $query->execute($login, $senha);
    
    my $row = $query->fetchrow_hashref();
    if ($row) {
        if (defined $row->{saldo}) {
            print "Nome Completo: $row->{nome_completo}\n";
            print "CPF: $row->{cpf}\n";
            print "Saldo: R$ $row->{saldo}\n";
        } else {
            print "Erro: Não foi possível obter o saldo da conta.\n";
        }
    } else {
        print "Login ou senha incorretos.\n";
    }
}

# Menu principal
while (1) {
    print "Escolha uma opção:\n";
    print "1. Cadastrar conta\n";
    print "2. Visualizar informações\n";
    print "3. Sair\n";
    
    my $opcao = <STDIN>;
    chomp $opcao;
    
    if ($opcao == 1) {
        print "Login: ";
        my $login = <STDIN>;
        chomp $login;
        print "Senha: ";
        my $senha = <STDIN>;
        chomp $senha;
        print "CPF: ";
        my $cpf = <STDIN>;
        chomp $cpf;
        print "Nome Completo: ";
        my $nome_completo = <STDIN>;
        chomp $nome_completo;
        print "Saldo Inicial: ";
        my $saldo_inicial = <STDIN>;
        chomp $saldo_inicial;
        cadastrar_conta($login, $senha, $cpf, $nome_completo, $saldo_inicial);
    } elsif ($opcao == 2) {
        print "Login: ";
        my $login = <STDIN>;
        chomp $login;
        print "Senha: ";
        my $senha = <STDIN>;
        chomp $senha;
        visualizar_informacoes($login, $senha);
    } elsif ($opcao == 3) {
        last;
    } else {
        print "Opção inválida. Tente novamente.\n";
    }
}

# Fechar a conexão com o banco de dados
$dbh->disconnect();
