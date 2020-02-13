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
        Task<IEnumerable<Product>> GetProductsAsync();

        Task<IEnumerable<Product>> GetProductsAsync(ProductType productType);

        Task UpdateCreateProduct(Product product);

        Task<IEnumerable<ProductOrder>> GetProductOrdersAsync();

        // Employees
        Task CreateNewEmployee(List<object> parameters);

        Task<IEnumerable<Employee>> GetEmployeesAsync();

        Task UpdateEmployeeAsync(Employee employee);

        Task<Employee> GetEmployeeLoginAsync(string username, string password);

        Task GetEmployeeTypesByIdAsync(Employee employee);

        Task UpdateEmployeeStatusAsync(Employee employee);

        Task DeleteEmployeeAtId(Employee employee);

        // InfoScreen - Hariz
        Task<IEnumerable<Order>> GetFinishedOrdersAsync(int id);
        Task<IEnumerable<Order>> GetInProcessOrderssAsync(int id);
        
        //Cashier - Hariz
        Task SetOrderPickedUpToAsync(int id, bool pickbit);
        
        //Baker - Hariz
        //Obs Open ProductOrders. Only for baker.
        Task<IEnumerable<Workload>> GetOpenPOAsync(int pBuidlingid=1); //Byt workload till Object oom du måste
        Task<IEnumerable<Ingredient>> GetStuffingsAsync(int pProductOrderid);
        Task SetLockOnkPOAsync(int pProductOrderid,int pStationid);
        Task SetProcessedOnkPOAsync(int pProductOrderid, bool processed);
        
        //Stations - Hariz
        Task<ProductOrder> GetLockedPOByStation(int pStationid);
        Task<Station> GetAssignedStation(int pEmployeeid);
        Task<Product> GetProductInfoFromPO(int pProductOrderId);

        Task<IEnumerable<Station>> GetPossibleStationsForEmployee(int pEmployeeid);
        Task AssignStationAsync(int pEmployeeid, int pStationid);
                      
        // Order Create
        Task<int> CreateNewOrderAsync(Order order);

        Task CreateProductOrdersAsync(List<object> parameters);

        // Orders Read
        Task<IEnumerable<Order>> GetOrdersAsync();

        // Order Update
        Task UpdateOrderStatusAsync(Order order);

        // Ingredients
        Task<IEnumerable<Ingredient>> GetIngredients();

        Task UpdateCreateIngredient(Ingredient ingredient);

        Task<IEnumerable<Ingredient>> GetHaveIngredientsAsync(int id);

        Task<IEnumerable<Ingredient>> GetCanHaveIngredientsAsync(int id);


        //Admin
        Task AddNewProductAsync(Product product);

        Task AddNewIngredientAsync(Ingredient ingredient);

        Task AddNewIngredientToProductAsync(Product product);

        Task<IEnumerable<Ingredient>> GetAllIngredientsAsync();

        Task<IEnumerable<Ingredient>> GetAllowedIngredientsByPTypeAsync(ProductType type);

        Task DeleteIngredientsByProductId(Product product);
    }
}
