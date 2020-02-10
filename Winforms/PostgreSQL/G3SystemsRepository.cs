using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using TypeLib;
using Dapper;
using Npgsql;

namespace PostgreSQL
{
    public class G3SystemsRepository : IG3SystemsRepository
    {
        private readonly string _connString;

        public G3SystemsRepository()
        {
            // Gets connectionstring from App.config in G3Systems
            _connString = ConfigurationManager.ConnectionStrings["npgsql"].ConnectionString;
        }

        /// <summary>
        /// Open new connection and return it for use
        /// </summary>
        /// <returns></returns>
        private IDbConnection CreateConnection()
        {
            var conn = new NpgsqlConnection(_connString);
            conn.Open();
            return conn;
        }


        public Task<int> CreateNewOrderAsync(Order order)
        {
            throw new NotImplementedException();
        }

        public Task CreateProductOrdersAsync(object[] parameters)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Ingredient>> GetCanHaveIngredientsAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<Employee> GetEmployeeLoginAsync(string username, string password)
        {
            throw new NotImplementedException();
        }

        public Task GetEmployeeTypesAsync(Employee employee)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Order>> GetFinishedOrdersAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Ingredient>> GetHaveIngredientsAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Order>> GetInProcessOrderssAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Workload>> GetOpenPOAsync(int pBuidlingid = 1)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<ProductOrder>> GetProductOrdersAsync()
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Product>> GetProductsAsync(ProductType productType)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Ingredient>> GetStuffingsAsync(int pProductOrderid)
        {
            throw new NotImplementedException();
        }

        public Task SetLockOnkPOAsync(int pProductOrderid, int pStationid)
        {
            throw new NotImplementedException();
        }

        public Task SetOrderPickedUpToAsync(int id, bool pickbit)
        {
            throw new NotImplementedException();
        }

        public Task SetProcessedOnkPOAsync(int pProductOrderid, bool processed)
        {
            throw new NotImplementedException();
        }

        public Task UpdateOrderStatusAsync(Order order)
        {
            throw new NotImplementedException();
        }

        public Task UpdateEmployeeStatusAsync(Employee employee)
        {
            throw new NotImplementedException();
        }
    }
}
