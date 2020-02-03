using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    public interface IDataConnection
    {
        Task<Employee> LogInAsync(string username, string password);

        Task<IEnumerable<Product>> GetProductsAsync(ProductType productType);

        Task<IEnumerable<ProductOrder>> GetProductOrdersAsync();
    }
}
