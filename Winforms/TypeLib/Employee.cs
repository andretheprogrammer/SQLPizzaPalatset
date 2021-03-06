﻿using System;
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
        public string Password { get; set; }
        public bool LoggedIn { get; set; }
        public int? AssignedToStation { get; set; }

        public List<EmployeeType> Types { get; set; }



        public bool HasAccess(int station)
        {
            if (Types.Any(type => type == EmployeeType.Administrator))
            {
                return true;
            }
            else if (station == 1 && Types.Any(type => type == EmployeeType.Cashier))
            {
                return true;
            }
            else if (station == 2) //&& Types.Any(type => type == EmployeeType.Pizzabaker))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
