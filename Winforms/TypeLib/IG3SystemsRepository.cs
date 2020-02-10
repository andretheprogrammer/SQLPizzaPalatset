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

        // TODO Delete om ej används
        Task<IEnumerable<ProductOrder>> GetProductOrdersAsync();

        // Employees
        Task<Employee> GetEmployeeLoginAsync(string username, string password);

        Task GetEmployeeTypesAsync(Employee employee);
        
        // InfoScreen
        Task<IEnumerable<Order>> GetFinishedOrdersAsync(int id);
        Task<IEnumerable<Order>> GetInProcessOrderssAsync(int id);

        //Cashier
        Task SetOrderPickedUpToAsync(int id, bool pickbit);

        //Baker
        //Obs Open ProductOrders. Only for baker.
        Task<IEnumerable<Workload>> GetOpenPOAsync(int pBuidlingid=1); //Byt workload till Object oom du måste
        Task<IEnumerable<Ingredient>> GetStuffingsAsync(int pProductOrderid);
        Task SetLockOnkPOAsync(int pProductOrderid,int pStationid);
        Task SetProcessedOnkPOAsync(int pProductOrderid, bool processed);


        // Order Create
        Task<int> CreateNewOrderAsync(Order order);

        Task CreateProductOrdersAsync(object[] parameters);

        // Order Update
        Task UpdateOrderStatusAsync(Order order);


        // Ingredients
        Task<IEnumerable<Ingredient>> GetHaveIngredientsAsync(int id);

        Task<IEnumerable<Ingredient>> GetCanHaveIngredientsAsync(int id);

    }
}
