using System;
using System.Collections.Generic;
using System.Text;

namespace TypeLib
{
    //TODO Behövs denna?
    //Potentiell Fix: Lägg som anonym type i baker?
    public class Workload
    {
        public int ProductOrderID { get; set; }
        public string ProductName { get; set; }
        public int PrepTime { get; set; }
    }
}
