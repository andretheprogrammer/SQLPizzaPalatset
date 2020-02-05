using System;
using System.Runtime;
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

        public G3SystemsRepository()
        {
            // Gets connectionstring from App.config in TerminalUI
            _connString = ConfigurationManager.ConnectionStrings["PizzaDB"].ConnectionString;
        }

        /// <summary>
        /// Open new connection and return it for use
        /// </summary>
        /// <returns></returns>
        private IDbConnection CreateConnection()
        {
            var conn = new SqlConnection(_connString);
            conn.Open();
            return conn;
        }

        public async Task<IEnumerable<ProductOrder>> GetProductOrdersAsync()
        {
            using (var connection = CreateConnection())
            {
                return await connection.QueryAsync<ProductOrder>("Select * from ProductOrders");
            }
        }

        public async Task<IEnumerable<Product>> GetProductsAsync(ProductType productType)
        {
            var sqlQuery = "Select * From Products";

            // Temporärt måste göras om
            using (var connection = CreateConnection())
            {
                if (productType != ProductType.All)
                {
                    sqlQuery += " Where ProductTypeID = @ID";
                    return (await connection.QueryAsync<Product>(sqlQuery)).Where(p => p.ProductTypeID == productType);
                }

                return (await connection.QueryAsync<Product>(sqlQuery, new { @ID = (int)productType }));
            }
        }

        /// <summary>
        /// Get employee by matching username and password
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public async Task<Employee> EmployeeLoginAsync(string username, string password)
        {
            var employee = new Employee();

            if (string.IsNullOrWhiteSpace(username + password))
            {
                return null;
            }

            using (var connection = CreateConnection())
            {
                employee = (await connection.QueryAsync<Employee>(
                       sql: "spVerifyLogin",
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
        public async Task GetEmployeeTypesAsync(Employee employee)
        {
            var sqlQuery = "select EmployeeTypeID from EmployeesAreEmployeeTypes where EmployeeID = @EmployeeID";

            using (var connection = CreateConnection())
            {
                // Gets all of the users employeeTypes
                var types = (await connection.QueryAsync<EmployeeType>(sqlQuery, new { employee.EmployeeID })).ToList();

                // Add each type to the users List<EmployeeType> Types
                types.ForEach(t => employee.Types.Add(t));
            }
        }
    }
}
