using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypeLib
{
    // TODO Dela upp repository?
    // TODO en repository för varje form?
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

        //Baker
        //Obs Open ProductOrders. Only for baker.
        Task<IEnumerable<ProductOrder>> GetOpenPOAsync(int pBuidlingid=1);
        Task<IEnumerable<Ingredient>> GetStuffingsAsync(int pProductOrderid);
        Task SetLockOnkPOAsync(int pProductOrderid,int pStationid);
        Task SetProcessedOnkPOAsync(int pProductOrderid, bool processed);


        //// ???????
        Task<int> CreateNewOrderAsync(Order order);

        Task CreateProductOrdersAsync(object[] parameters);


        // Ingredients
        Task<IEnumerable<Ingredient>> GetHaveIngredientsAsync(int id);

        Task<IEnumerable<Ingredient>> GetCanHaveIngredientsAsync(int id);

    }
}
