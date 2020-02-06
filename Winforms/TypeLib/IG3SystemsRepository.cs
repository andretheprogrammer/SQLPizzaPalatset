using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    // TODO Dela upp repository
    public interface IG3SystemsRepository 
    {
        Task<IEnumerable<Product>> GetProductsAsync(ProductType productType);

        // Temp test
        Task<IEnumerable<ProductOrder>> GetProductOrdersAsync();

        Task<Employee> EmployeeLoginAsync(string username, string password);

        Task GetEmployeeTypesAsync(Employee employee);

        Task<IEnumerable<Order>> GetOrdersAsync();
    }
}
