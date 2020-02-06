using System;
using System.Collections.Generic;
using System.Text;

namespace TypeLib
{
    public class Order
    {
        public int OrderID { get; set; }

        public int ByTerminal { get; set; }

        public bool Activated { get; set; }

        public bool Visible { get; set; }

        public bool Paid { get; set; }

        public bool Canceled { get; set; }

        public bool PickedUp { get; set; }

        public bool ShowOnScreen { get; set; }

        public bool Paused { get; set; }

        public bool HappyCustomer { get; set; }

        public bool Returned { get; set; }

        public bool HasSpit { get; set; }

        public bool DeliveredByCompany { get; set; }
    }
}
