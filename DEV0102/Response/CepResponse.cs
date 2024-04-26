using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DEV0102.Response
{
    public class CepResponse
    {
        public string cep { get; set; }
        public string logradouro { get; set; }
        public string complemento { get; set; }
        public string bairro { get; set; }
        public string localidade { get; set; }
        public string uf { get; set; }
        public bool erro { get; set; }
    }
}