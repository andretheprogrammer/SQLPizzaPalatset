using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    public class Product
    {
        public int ProductID { get; set; }
        public ProductType ProductTypeID { get; set; }
        public string ProductName { get; set; }
        //public string Description { get; set; }
        public int PrepTime { get; set; }
        public int BasePrice { get; set; }
        //public bool Activated { get; set; }
        //public bool Visible { get; set; }
    }
}
