using System.Net;
using System.Net.Mail;

namespace DEV0102.Utills
{
    public class Suporte
    {

        public void EnviarEmail(string Assunto, string emailDestinatario, string corpoEmail)
        {
            MailMessage objmail = new MailMessage();
            objmail.To.Add(emailDestinatario);
            objmail.From = new MailAddress("kaua.martins@varsolutions.com.br");
            objmail.Body = corpoEmail;
            objmail.Subject = Assunto;

            SmtpClient objsmtp = new SmtpClient();
            objsmtp.Host = "smtp.titan.email";
            objsmtp.Port = 587;
            objsmtp.UseDefaultCredentials = false;
            objsmtp.Credentials = new NetworkCredential("kaua.martins@varsolutions.com.br", "Var@1234");
            objsmtp.EnableSsl = true;
            objsmtp.Send(objmail);
        }
    }
}
