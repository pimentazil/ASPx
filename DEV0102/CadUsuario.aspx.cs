using DEV0102.DAL;
using DEV0102.Response;
using DEV0102.Utills;
using Newtonsoft.Json;
using System;
using System.Net;

namespace DEV0102
{
    public partial class cadUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnConsultaCEP_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtCEP.Text))
                {
                    WebClient wc = new WebClient();

                    string resultado = wc.DownloadString("https://viacep.com.br/ws/" + txtCEP.Text + "/json/");

                    CepResponse response = JsonConvert.DeserializeObject<CepResponse>(resultado);

                    if (response.erro)
                    {
                        ExibirMensagem("Este CEP não existe!");
                    }
                    else
                    {
                        txtEndereco.Text = response.logradouro;
                        txtBairro.Text = response.bairro;
                        txtCidade.Text = response.localidade;
                        txtUF.Text = response.uf;
                    }
                }
                else
                    ExibirMensagem("Digite um CEP!");
            }
            catch 
            {
                ExibirMensagem("CEP inválido!");
            }
        }


        public void ExibirMensagem(string msg)
        {
            Response.Write("<script>alert('" + msg + "')</script>");
        }

        public void LimparCampos()
        {
            txtBairro.Text = "";
            txtCEP.Text = "";
            txtCidade.Text = "";
            txtEmail.Text = "";
            txtEndereco.Text = "";
            txtNome.Text = "";
            txtSenha.Text = "";
            txtUF.Text = "";
        }

        protected void btnCadastrar_Click(object sender, EventArgs e)
        {
            try
            {
                if (fupFoto.HasFile)
                {
                    string caminhoArquivo = Server.MapPath("/fotoUsuario/");
                    string nomeArquivo = fupFoto.FileName;

                    fupFoto.SaveAs(caminhoArquivo + nomeArquivo);

                    tabUsuario objUsuario = new tabUsuario();
                    objUsuario.bairro = txtBairro.Text;
                    objUsuario.cep = txtCEP.Text;
                    objUsuario.cidade = txtCidade.Text;
                    objUsuario.email = txtEmail.Text;
                    objUsuario.endereco = txtEndereco.Text;
                    objUsuario.nome = txtNome.Text;
                    objUsuario.senha = txtSenha.Text;
                    objUsuario.uf = txtUF.Text;
                    objUsuario.nomeFoto = fupFoto.FileName;

                    tabUsuario objValidador = new tabUsuario();
                    UsuarioDAL uDal = new UsuarioDAL();

                    objValidador = uDal.consultarUsuarioPorEmail(txtEmail.Text);

                    if (objValidador != null)
                    {
                        ExibirMensagem("Usuário já existe no banco de dados!");
                    }
                    else
                    {
                        uDal.cadastrarUsuario(objUsuario);
                        gridUsuario.DataBind();

                        ExibirMensagem("Usuário cadastrado com sucesso!");
                        Suporte objsup = new Suporte();
                        string corpoEmail = "Olá " + txtNome.Text + ", bem vindo ao sistema.";
                        objsup.EnviarEmail("Bem vindo ao Sistema Desenvti", txtEmail.Text, corpoEmail);

                        LimparCampos();
                    }
                }
                else
                {
                    ExibirMensagem("Selecione uma foto para o usuário");
                }
            }
            catch (Exception ex)
            {

                ExibirMensagem("Error ao salvar cadastro! Entre em contato com o administrador do sistema." + ex);
            }
        }
    }
}
