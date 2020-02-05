using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Dapper;
using TypeLib;

namespace SQLServer
{
    public class G3SystemsRepository : IG3SystemsRepository
    {
        private readonly string _connString;

        private SqlConnection Connection;

        public G3SystemsRepository()
        {
            // Gets connectionstring from App.config in TerminalUI
            _connString = ConfigurationManager.ConnectionStrings["PizzaDB"].ConnectionString;
            Connection = new SqlConnection(_connString);
        }

        /// <summary>
        /// Generate new connection based on connection string
        /// </summary>
        /// <returns></returns>
        private SqlConnection SqlConnection()
        {
            return new SqlConnection(_connString);
        }

        /// <summary>
        /// Open new connection and return it for use
        /// </summary>
        /// <returns></returns>
        private IDbConnection CreateConnection()
        {
            var conn = SqlConnection();
            conn.Open();
            return conn;
        }

        public async Task<IEnumerable<ProductOrder>> GetProductOrders()
        {
            return await Connection.QueryAsync<ProductOrder>("Select * from ProductOrders");
        }

        public async Task<IEnumerable<Product>> GetProducts(ProductType productType)
        {
            var sqlQuery = "Select * From Products";

            if (productType != ProductType.All)
            {
                sqlQuery += " Where ProductTypeID = @ID";
                return (await Connection.QueryAsync<Product>(sqlQuery)).Where(p => p.ProductTypeID == productType);
            }

            return (await Connection.QueryAsync<Product>(sqlQuery, new { @ID = (int)productType }));
        }

        /// <summary>
        /// Get employee by matching username and password
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public async Task<Employee> EmployeeLogin(string username, string password)
        {
            var employee = new Employee();

            if (string.IsNullOrWhiteSpace(username + password))
            {
                return null;
            }

            using (var connection = CreateConnection())
            {
                employee = (await connection.QueryAsync<Employee>(
                       sql: "spVerifyLogin2",
                     param: new { @Username = username, @Password = password },
               commandType: CommandType.StoredProcedure)).FirstOrDefault();
            }

            return employee;
        }

        /// <summary>
        /// Get all employeeTypes for employee through ID
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        public async Task<IEnumerable<EmployeeType>> GetEmployeeTypesByID(Employee employee)
        {
            var sqlQuery = "select EmployeeTypeID from EmployeesAreEmployeeTypes where EmployeeID = @EmployeeID";

            using (var connection = CreateConnection())
            {
                return await connection.QueryAsync<EmployeeType>(sqlQuery, new { employee.EmployeeID });
            }
        }
    }
}
