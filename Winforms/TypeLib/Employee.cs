using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    public class Employee
    {
        public Employee ()
        {
            Types = new List<EmployeeType>();
        }

        public int EmployeeID { get; set; }
        public string Username { get; set; }

        //public EmployeeType EmployeeTypeID { get; set; }

        public List<EmployeeType> Types { get; set; }



        public bool HasAccess(int station)
        {
            // TODO Implementera enum för Stations/Stationtypes i ComboBox ?
            // Implementera Employeetypecanworkinstationtype ?
            // Stations
            //"Administrator" = 0
            //"Cashier"
            //"Pizza Station 1"
            //"Terminal1"
            //"Terminal2"
            //"Terminal3"

            if (Types.Any(type => type == EmployeeType.Administrator))
            {
                return true;
            }
            else if (station == 1 && Types.Any(type => type == EmployeeType.Cashier))
            {
                return true;
            }
            else if (station == 2 && Types.Any(type => type == EmployeeType.Pizzabaker))
            {
                return true;
            }
            else
            {
                return false;
            }

            //if (EmployeeTypeID == EmployeeType.Administrator)
            //{
            //    return true;
            //}
            //else if (station == 1 &&
            //    EmployeeTypeID == EmployeeType.Cashier)
            //{
            //    return true;
            //}
            //else if (station == 2 &&
            //    EmployeeTypeID == EmployeeType.Pizzabaker)
            //{
            //    return true;
            //}
        }
    }
}
