using System.Linq;

namespace DEV0102.DAL
{
    public class UsuarioDAL
    {
        public tabUsuario consultarUsuarioPorEmail(string email)
        {
            using (DEV0102Entities1 ctx = new DEV0102Entities1())
            {
                return ctx.tabUsuarios.Where(c => c.email == email).FirstOrDefault();
            }
        }

        public void cadastrarUsuario(tabUsuario objU)
        {
            using (DEV0102Entities1 ctx = new DEV0102Entities1())
            {
                ctx.tabUsuarios.Add(objU);
                ctx.SaveChanges();
            }
        }
    }
}