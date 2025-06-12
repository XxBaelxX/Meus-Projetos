function Cadastrar(){
    nome = document.getElementById("nome").value;
    telefone = document.getElementById("telefone").value;
    email = document.getElementById("email").value;
    senha = document.getElementById("senha").value;
    if(nome == "" || telefone == "" || email == "" || senha == ""){
        alert("Por favor, preencha todos os campos!");
        return;
    }
    if(!email.includes("@") || !email.includes(".")){
        alert("Por favor, insira um email válido!");
        return;
    }
    if(senha.length < 6){
        alert("A senha deve ter pelo menos 6 caracteres!");
        return;
    }
    let mensagem = `Confirme seus dados:\n\nNome: ${nome}\nTelefone: ${telefone}\nEmail: ${email}\nSenha: ${senha}\n\nDeseja confirmar o cadastro?`;
    if(confirm(mensagem)){
        usuario = {
            nome: nome,
            telefone: telefone,
            email: email,
            senha: senha
        };
        console.log("Usuário cadastrado:", usuario);
        alert("Cadastro realizado com sucesso!");
    } else {
        alert("Cadastro cancelado.");
    }
}
function Limpar() {
    document.getElementById("nome").value = '';
    document.getElementById("telefone").value = '';
    document.getElementById("email").value = '';
    document.getElementById("senha").value = '';
}
