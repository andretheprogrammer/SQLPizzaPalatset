using System;
using System.Runtime;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CSharp;
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
            // Gets connectionstring from App.config in G3Systems
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

        /// <summary>
        /// Get all products and return chosen category by matching productType with productTypeID
        /// </summary>
        /// <param name="productType"></param>
        /// <returns></returns>
        public async Task<IEnumerable<Product>> GetProductsAsync(ProductType productType)
        {
            var sqlQuery = "Select * From Products Where ProductTypeID = @ProductTypeID";

            using (var connection = CreateConnection())
            {
                return await connection.QueryAsync<Product>(sqlQuery, new { ProductTypeID = productType });
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
            if (string.IsNullOrWhiteSpace(username + password))
            {
                return null;
            }

            using (var connection = CreateConnection())
            {
                return (await connection.QueryAsync<Employee>(
                       sql: "Proc_VerifyLogin",
                     param: new { Username = username, Password = password },
               commandType: CommandType.StoredProcedure)).FirstOrDefault();
            }
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



        //-------------- Infoscreen
        public async Task<IEnumerable<Order>> GetFinishedOrdersAsync(int id)
        {
            using (var connection = CreateConnection())
            {
                return (await connection.QueryAsync<Order>(
                      sql: "Proc_RightColumnInfoScreen",
                    param: new { @Building = id },
               commandType: CommandType.StoredProcedure));
            }
        }

        public async Task<IEnumerable<Order>> GetInProcessOrderssAsync(int id)
        {
            using (var connection = CreateConnection())
            {
                return (await connection.QueryAsync<Order>(
                      sql: "Proc_LeftColumnInfoScreen",
                    param: new { @Building = id },
               commandType: CommandType.StoredProcedure)).ToList();
            }
        }
        //_------------------

        public async Task CreateProductOrdersAsync(object[] parameters)
        {
            using (var connection = CreateConnection())
            {
                // Wrap order data insert in transaction
                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Loop through object array parameters for each insert
                        await connection.ExecuteAsync(
                                sql: "Proc_InsertProductOrders",
                              param: parameters,
                        commandType: CommandType.StoredProcedure,
                        transaction: transaction);

                        // Save if all inserts successfull
                        transaction.Commit();
                    }
                    catch
                    {
                        // Undo inserts if error occured
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }
        

        public async Task<int> CreateNewOrderAsync(Order order)
        {
            var orderParam = new DynamicParameters();
            orderParam.AddDynamicParams(new { TerminalID = order.ByTerminal });
            orderParam.Add("OrderID",
                    dbType: DbType.Int32,
                 direction: ParameterDirection.Output);

            using (var connection = CreateConnection())
            {
                await connection.ExecuteScalarAsync("Proc_NewOrder", 
                                              param: orderParam, 
                                        commandType: CommandType.StoredProcedure);
            }

            return orderParam.Get<int>("OrderID");
        }


        // Ingredients
        public async Task<IEnumerable<Ingredient>> GetHaveIngredientsAsync(int id)
        {
            using (var connection = CreateConnection())
            {
                return (await connection.QueryAsync<Ingredient>(
                        sql: "Proc_GetProductHaveIngredients",
                      param: new { ProductID = id },
                commandType: CommandType.StoredProcedure));
            }
        }

        public async Task<IEnumerable<Ingredient>> GetCanHaveIngredientsAsync(int id)
        {
            using (var connection = CreateConnection())
            {
                return (await connection.QueryAsync<Ingredient>(
                        sql: "Proc_GetProductCanHaveIngredients",
                      param: new { ProductID = id },
                commandType: CommandType.StoredProcedure));
            }
        }

        //Cashier  - Hariz
        //Sätter picked up på en order.
        public async Task SetOrderPickedUpToAsync(int id, bool pickbit)
        {
            //Konvertera bool till en int
            int bit_from_bool;
            if (pickbit == true) bit_from_bool = 1;
            else bit_from_bool = 0;

            using (var connection = CreateConnection())
            {
                 await connection.QueryAsync<Order>(
                       sql: "SetPickedUp",
                     param: new { OrderID = id, PickedUp = bit_from_bool },
                commandType: CommandType.StoredProcedure);
            }

            //Return signal of successs?
        }


    }
}
