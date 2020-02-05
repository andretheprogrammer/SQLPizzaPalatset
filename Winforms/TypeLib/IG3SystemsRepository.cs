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

        Task<IEnumerable<Product>> GetProducts(ProductType productType);

        // Temp test
        Task<IEnumerable<ProductOrder>> GetProductOrders();

        Task<Employee> EmployeeLogin(string username, string password);

        Task<IEnumerable<EmployeeType>> GetEmployeeTypesByID(Employee employee);
    }
}
