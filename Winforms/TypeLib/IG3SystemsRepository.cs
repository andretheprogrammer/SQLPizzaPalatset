using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    // TODO Dela upp IRepository för varje object(table)
    public interface IG3SystemsRepository 
    {
        Task<Employee> EmployeeLoginAsync(string username, string password);

        Task<IEnumerable<Product>> GetProductsAsync(ProductType productType);

        Task<IEnumerable<ProductOrder>> GetProductOrdersAsync();
    }
}
