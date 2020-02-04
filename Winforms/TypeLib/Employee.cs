using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string Username { get; set; }

        public EmployeeType EmployeeTypeID { get; set; }

        // TODO Byt till enum?
        // Stations
        //"Administrator" = 0
        //"Cashier"
        //"Pizza Station 1"
        //"Terminal1"
        //"Terminal2"
        //"Terminal3"

        public bool HasAccess(int station)
        {
            if (EmployeeTypeID == EmployeeType.Administrator)
            {
                return true;
            }
            else if (station == 1 && 
                EmployeeTypeID == EmployeeType.Cashier)
            {
                return true;
            }
            else if (station == 2 &&
                EmployeeTypeID == EmployeeType.Pizzabaker)
            {
                return true;
            }

            return false;
        }
    }
}
