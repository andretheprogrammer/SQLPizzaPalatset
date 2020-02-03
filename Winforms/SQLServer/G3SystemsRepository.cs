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
    class G3SystemsRepository : IDataConnection
    {
        // Gets connectionstring from App.config in TerminalUI
        private readonly string _connString = ConfigurationManager.ConnectionStrings["PizzaDB"].ConnectionString;

        private SqlConnection Connection;

        public G3SystemsRepository()
        {
            Connection = new SqlConnection(_connString);
        }

        public async Task<IEnumerable<ProductOrder>> GetProductOrdersAsync()
        {
            return await Connection.QueryAsync<ProductOrder>("Select * from ProductOrders");
        }

        public async Task<IEnumerable<Product>> GetProductsAsync(ProductType productType)
        {
            var sqlQuery = "Select * From Products";

            if (productType != ProductType.All)
            {
                sqlQuery += " Where ProductTypeID = @ID";
            }

            return await Connection.QueryAsync<Product>(sqlQuery, new { @ID = (int)productType });
        }

        public async Task<Employee> LogInAsync(string username, string password)
        {
            if (string.IsNullOrWhiteSpace(username + password))
            {
                return null;
            }

            return (await Connection.QueryAsync<Employee>(
                       sql: "spVerifyLogin",
                     param: new { @Username = username, @Password = password },
               commandType: CommandType.StoredProcedure)).FirstOrDefault();
        }
    }
}
