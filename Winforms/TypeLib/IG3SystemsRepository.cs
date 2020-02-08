using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    // TODO Dela upp repository?
    public interface IG3SystemsRepository 
    {
        // Products
        Task<IEnumerable<Product>> GetProductsAsync(ProductType productType);

        // Temp test
        Task<IEnumerable<ProductOrder>> GetProductOrdersAsync();

        // Employees
        Task<Employee> EmployeeLoginAsync(string username, string password);

        Task GetEmployeeTypesAsync(Employee employee);
        
        // InfoScreen
        Task<IEnumerable<Order>> GetFinishedOrdersAsync(int id);
        Task<IEnumerable<Order>> GetInProcessOrderssAsync(int id);

        //Cashier
        Task SetOrderPickedUpToAsync(int id, bool pickbit);


        //// ???????
        Task<int> CreateNewOrderAsync(Order order);

        Task CreateProductOrdersAsync(object[] parameters);


        // Ingredients
        Task<IEnumerable<Ingredient>> GetHaveIngredientsAsync(int id);

        Task<IEnumerable<Ingredient>> GetCanHaveIngredientsAsync(int id);

    }
}
