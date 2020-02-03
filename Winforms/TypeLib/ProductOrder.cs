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
        public bool Handled { get; set; }
        public bool Activated { get; set; }
        public bool Visible { get; set; }
        public bool Paid { get; set; }
    }
}
