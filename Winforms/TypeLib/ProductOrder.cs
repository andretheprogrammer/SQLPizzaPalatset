using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    public class ProductOrder
    {
        public int ProductOrderID { get; set; }
        public int ProductID { get; set; }
        public int OrderID { get; set; }
        public int LockedByStation { get; set; }
        public bool Processed { get; set; }
        public bool Activated { get; set; }
        public bool Visible { get; set; }
    }

    //Todo: Behöver metod för att fetcha productnamn, produkttyp, pris, etc.?
}
