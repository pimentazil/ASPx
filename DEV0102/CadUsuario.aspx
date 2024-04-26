<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CadUsuario.aspx.cs" Inherits="DEV0102.cadUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Cadastro de Usuários</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Cadastro de Usuário</h1>
            <label>Nome:</label><br />
            <asp:TextBox ID="txtNome" runat="server"></asp:TextBox><br />
            <label>CEP:</label><br />
            <asp:TextBox ID="txtCEP" runat="server"></asp:TextBox> <br />
            <label>Endereço:</label><br />
            <asp:TextBox ID="txtEndereco" runat="server"></asp:TextBox> <br />
            <label>Bairro:</label><br />
            <asp:TextBox ID="txtBairro" runat="server"></asp:TextBox> <br />
            <label>Cidade:</label><br />
            <asp:TextBox ID="txtCidade" runat="server"></asp:TextBox><br />
            <label>UF:</label><br />
            <asp:TextBox ID="txtUF" runat="server"></asp:TextBox><br />
            <label>Email:</label<br /><br />
            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox><br />
            <label>Senha:</label><br />
            <asp:TextBox ID="txtSenha" runat="server" TextMode="Password"></asp:TextBox><br />
            <br />
            <asp:FileUpload ID="fupFoto" runat="server" /> <br />
            <asp:Button ID="btnCadastrar" runat="server" Text="Cadastrar" Onclick="btnCadastrar_Click" /> <br />  

            <h4>Usuários Cadastrados</h4>
            <asp:GridView ID="gridUsuario" runat="server" AutoGenerateColumns="False" DataKeyNames="codigo" DataSourceID="SqlDataSourceUsuario" AllowPaging="True" AllowSorting="True">
                <Columns>
                    <asp:ImageField DataImageUrlField="caminhoFoto" ControlStyle-Height="50px" HeaderText="Foto"></asp:ImageField>
                    <asp:BoundField DataField="codigo" Visible="false" HeaderText="codigo" ReadOnly="True" InsertVisible="False" SortExpression="codigo"></asp:BoundField>
                    <asp:BoundField DataField="nome" HeaderText="Nome" SortExpression="nome"></asp:BoundField>
                    <asp:BoundField DataField="cep" HeaderText="CEP" SortExpression="cep"></asp:BoundField>
                    <asp:BoundField DataField="endereco" HeaderText="Endereço" SortExpression="endereco"></asp:BoundField>
                    <asp:BoundField DataField="bairro" HeaderText="Bairro" SortExpression="bairro"></asp:BoundField>
                    <asp:BoundField DataField="cidade" HeaderText="Cidade" SortExpression="cidade"></asp:BoundField>
                    <asp:BoundField DataField="uf" HeaderText="UF" SortExpression="UF"></asp:BoundField>
                    <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="E-mail"></asp:BoundField>
                    <asp:BoundField DataField="senha" Visible="false" SortExpression="senha"></asp:BoundField>
                    <asp:BoundField DataField="nomeFoto" Visible="false" SortExpression="nomeFoto"></asp:BoundField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceUsuario" ConnectionString='<%$ ConnectionStrings:DEV0102ConnectionString %>' SelectCommand="select '~/fotoUsuario/' + nomeFoto as caminhoFoto, * from tabUsuario"></asp:SqlDataSource>
        </div>
    </form>

    <style type="text/css">
        body {
            font-family: 'Poppins', BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        #form1 {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1, h4 {
            margin-top: 0;
        }

        label {
            font-weight: bold;
        }

        button,
        input[type="button"],
        input[type="submit"],
        input[type="reset"] {
            padding: 5px 10px; 
            background-color: #F0F0F0; 
            color: black; 
            border-radius: 4px;
            border: none;
            cursor: pointer; 
            margin-bottom: 2%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td, th {
            padding: 8px;
            border: 1px solid #ddd;
        }

        img {
            max-width: 100px;
            height: auto;
            display: block;
            margin: 0 auto;
        }
    </style>

    <script>
        $(document).ready(function () {
            $('#txtCEP').on('input', function () {
                var cep = $(this).val();
                if (cep.length === 8) { 
                    $.ajax({
                        url: 'https://viacep.com.br/ws/' + cep + '/json/',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (!response.erro) {
                                $('#txtEndereco').val(response.logradouro);
                                $('#txtBairro').val(response.bairro);
                                $('#txtCidade').val(response.localidade);
                                $('#txtUF').val(response.uf);
                            } else {
                                alert('CEP não encontrado!');
                            }
                        },
                        error: function () {
                            alert('Erro ao consultar o CEP!');
                        }
                    });
                }
            });
        });
    </script>

</body>
</html>
