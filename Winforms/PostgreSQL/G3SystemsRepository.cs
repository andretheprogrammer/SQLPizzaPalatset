using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using TypeLib;

namespace PostgreSQL
{
    public class G3SystemsRepository : IG3SystemsRepository
    {
        public Task<Employee> EmployeeLoginAsync(string username, string password)
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
    }
}
