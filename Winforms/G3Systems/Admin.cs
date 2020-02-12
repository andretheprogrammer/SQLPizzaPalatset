using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TypeLib;
using SQLServer;


namespace G3Systems
{
	public partial class Admin : Form
	{
		private readonly IG3SystemsRepository _repo;
		private Employee user;
		private Employee editEmployee;
		private Product editProduct;
		private Ingredient editIngredient;

		public Admin(Employee user)
		{
			InitializeComponent();
			this.user = user;
			_repo = new G3SystemsRepository();
		}

		private void Admin_Load(object sender, EventArgs e)
		{
			usrnLabel.Text = user.Username;

			// Cast all EmployeeType enums to list
			var values = Enum.GetValues(typeof(EmployeeType)).Cast<EmployeeType>().ToList();

			// Add values to listbox in Extras tab
			values.ForEach(type => chkListBoxEmployeeType.Items.Add(type));

			// Load employees datagridview
			GetEmployeesBtn_Click(sender, e);

			
			lstbx_types.Items.Clear();
			lstboxAddtype.Items.Clear();
			
			//Todo Enums till class
			foreach (var i in Enum.GetNames(typeof(ProductType)))
			{
				lstbx_types.Items.Add(i);
				lstboxAddtype.Items.Add(i);
			}
		}
		private void Admin_FormClosed(object sender, FormClosedEventArgs e)
		{
			//var form = new Login();
			//this.Dispose();
			//form.ShowDialog();

			Application.Exit();
		}

		// Employees - Get employees and bind to datagrid
		private async void GetEmployeesBtn_Click(object sender, EventArgs e)
		{
			dataGridViewEmployees.DataSource = await _repo.GetEmployeesAsync();
		
		}

		// Employees - Add new employee with selected types
		private async void AddNewEmployeeBtn_Click(object sender, EventArgs e)
		{
			if (string.IsNullOrWhiteSpace(tbUsername.Text) ||
				string.IsNullOrWhiteSpace(tbPassword.Text))
			{
				MessageBox.Show("Invalid input");
				return;
			}

			var parameters = new List<object>();
			var newEmployee = new Employee
			{
				Username = tbUsername.Text,
				Password = tbPassword.Text
			};

			foreach (var item in chkListBoxEmployeeType.CheckedItems)
			{
				newEmployee.Types.Add((EmployeeType)item);
			}

			if (newEmployee.Types.Count <= 0)
			{
				MessageBox.Show("Add a type");
				return;
			}

			newEmployee.Types.ForEach(type => parameters.Add(InsertParameters(newEmployee, type)));

			try
			{
				await _repo.CreateNewEmployee(parameters.ToArray());
			}
			catch (System.Data.SqlClient.SqlException)
			{
				MessageBox.Show("Username already exist");
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.ToString());
			}

			ClearEmployeeTextBoxes();
			GetEmployeesBtn_Click(sender, e);
		}

		private object InsertParameters(Employee employee, EmployeeType employeeType) => new
		{
			Username = employee.Username,
			Password = employee.Password,
			EmployeeTypeID = employeeType
		};

		private void ClearEmployeeTextBoxes()
		{
			tbUsername.Text = string.Empty;
			tbPassword.Text = string.Empty;

			for (int i = 0; i < chkListBoxEmployeeType.Items.Count; i++)
			{
				chkListBoxEmployeeType.SetItemCheckState(i, CheckState.Unchecked);
			}
		}

		// Employees - Delete selected employee
		private async void DeleteEmployeeBtn_Click(object sender, EventArgs e)
		{
			if (editEmployee == null)
			{
				return;
			}

			if (editEmployee.EmployeeID == 1)
			{
				MessageBox.Show("Can't delete superadmin");
			}

			await _repo.DeleteEmployeeAtId(editEmployee);

			GetEmployeesBtn_Click(sender, e);
		}

		// Employees - Link selected employee to editEmployee
		private async void dataGridViewEmployees_SelectionChanged(object sender, EventArgs e)
		{
			if ((dataGridViewEmployees.SelectedRows.Count <= 0))
			{
				return;
			}

			editEmployee = (Employee)dataGridViewEmployees.SelectedRows[0].DataBoundItem;

			await _repo.GetEmployeeTypesByIdAsync(editEmployee);

			ClearEmployeeTextBoxes();
		}

		// Employees - Confirm edit directly in datagrid
		private async void dataGridViewEmployees_CellEndEdit(object sender, DataGridViewCellEventArgs e)
		{
			if (this.editEmployee.EmployeeID == -1)
			{
				return;
			}

			dataGridViewEmployees.CommitEdit(DataGridViewDataErrorContexts.Commit);
			await _repo.UpdateEmployeeAsync(this.editEmployee);
		}

		// Products
		private async void dataGridViewProducts_CellEndEdit(object sender, DataGridViewCellEventArgs e)
		{
			if (this.editProduct.ProductID == -1)
			{
				return;
			}

			await _repo.UpdateCreateProduct(this.editProduct);
		}

		// Products
		private void dataGridViewProducts_SelectionChangedAsync(object sender, EventArgs e)
		{
			if ((dataGridViewProducts.SelectedRows.Count <= 0))
			{
				return;
			}

			this.editProduct = (Product)dataGridViewProducts.SelectedRows[0].DataBoundItem;

			lstbx_types.SelectedIndex = (int)editProduct.ProductTypeID - 1;
		}

		// Products
		private async void GetAllProductsBtn_Click(object sender, EventArgs e)
		{
			dataGridViewProducts.DataSource = await _repo.GetProductsAsync();
		}

		// Ingredients
		private async void dataGridViewIngredients_CellEndEdit(object sender, DataGridViewCellEventArgs e)
		{
			await _repo.UpdateCreateIngredient(this.editIngredient);
		}

		// Ingredients
		private async void GetAllIngredientsBtn_Click(object sender, EventArgs e)
		{
			dataGridViewIngredients.DataSource = await _repo.GetIngredients();
		}

		// Ingredients
		private void dataGridViewIngredients_SelectionChanged(object sender, EventArgs e)
		{
			if ((dataGridViewIngredients.SelectedRows.Count <= 0))
			{
				return;
			}

			this.editIngredient = (Ingredient)dataGridViewIngredients.SelectedRows[0].DataBoundItem;
		}

		// Orders
		private async void GetAllOrdersBtn_Click(object sender, EventArgs e)
		{
			dataGridViewOrders.DataSource = await _repo.GetOrdersAsync();
		}

		private async void GetAllProductOrdersBtn_Click(object sender, EventArgs e)
		{
			dataGridViewPOrders.DataSource = await _repo.GetProductOrdersAsync();
		}

		private void timer1_Tick(object sender, EventArgs e)
		{
			listViewLoggedInEmployees.Items.Add(
												new ListViewItem("HEY")
												);
			
			
			var yo = listViewLoggedInEmployees.Items;

		}

		private async void timer1_Tick_1(object sender, EventArgs e)
		{

			//Server sends too big list
			//Make it send only logged in users. Not ALL users.
			List<Employee> Loggedin = (await _repo.GetEmployeesAsync()).ToList();

			listViewLoggedInEmployees.Items.Clear();

			foreach(Employee emp in Loggedin)
			{
				
				if (emp.LoggedIn == true)
				{
					listViewLoggedInEmployees.Items.Add
									(
									new ListViewItem(  emp.Username)
									); 
				}	
			}

		}

		private void LogoutButton_Click(object sender, EventArgs e)
		{
			var form = new Login();
			this.Dispose();
			form.ShowDialog();
		}

		private async void btn_ResetProd_Click(object sender, EventArgs e)
		{

			lstbx_types.ClearSelected();
			chbxlist_ingrs.Items.Clear();
			List<Ingredient> all_ingredients = (await _repo.GetAllIngredientsAsync()).ToList();

			all_ingredients.ForEach(a => chbxlist_ingrs.Items.Add(a.IngredientName));
			
			//Refresh productlist
			dataGridViewProducts.DataSource = await _repo.GetProductsAsync();
		}

		private async void lstbx_types_SelectedIndexChanged(object sender, EventArgs e)
		{
			int temp = lstbx_types.SelectedIndex + 1;

			List<Ingredient> allowed_ingredients = (await _repo.GetAllowedIngredientsByPTypeAsync(temp)).ToList();

			//chbxlist_ingrs.Items.Clear();
			//allowed_ingredients.ForEach(a => chbxlist_ingrs.Items.Add(a.IngredientID + " : " + a.IngredientName));
			((ListBox)chbxlist_ingrs).DataSource = null;
			((ListBox)chbxlist_ingrs).DataSource = allowed_ingredients;
			((ListBox)chbxlist_ingrs).DisplayMember = "IngredientName";
			((ListBox)chbxlist_ingrs).ValueMember = "IngredientID";
		}


		private async void btn_saveProd_Click(object sender, EventArgs e)
		{
			editProduct.Ingredients = new List<Ingredient>();
			//var ingredients = new List<Ingredient>();
			//Fetcha allting i formuläret.
			foreach (var ingredient in chbxlist_ingrs.CheckedItems)
			{
				editProduct.Ingredients.Add((Ingredient)ingredient);
			}

			if (editProduct.Ingredients.Count <= 0)
			{
				MessageBox.Show("Select ingredients");
				return;
			}
			//Spara i databasen

			await _repo.DeleteIngredientsByProductId(editProduct);

			await _repo.AddNewIngredientToProductAsync(editProduct);

			//Refresh ProductList
			GetAllProductsBtn_Click(sender, e);
			ClearIngredientsChkbxList();
		}

		private void ClearIngredientsChkbxList()
		{

			for (int i = 0; i < chbxlist_ingrs.Items.Count; i++)
			{
				chbxlist_ingrs.SetItemCheckState(i, CheckState.Unchecked);
			}
		}

		private void Clearform()
		{
			lstbx_types.ClearSelected();
		}


		private void button1_Click_1(object sender, EventArgs e)
		{
			txtboxaddname.Text = "";
			txtboxaddprice.Text = "";
			txtboxadddescr.Text = "";
		}


		private async void BtnAddProduct_Click(object sender, EventArgs e)
		{
			try {
				//Might cause increase in ID on failed insert.

				//Fix: Potential TRANSACTION HERE. 
				string name = txtboxaddname.Text;
				int baseprice = Int32.Parse(txtboxaddprice.Text);
				string descr = txtboxadddescr.Text;
			
				//Todo Convert Enum to Class
				int selectedType = lstboxAddtype.SelectedIndex + 1;

			

				await _repo.AddNewProductAsync(name, selectedType, baseprice, descr);
				MessageBox.Show("Product: " + name + " was added!");

				txtboxaddname.Text = "";
				txtboxaddprice.Text = "";
				txtboxadddescr.Text = "";
			}
			catch(Exception){ MessageBox.Show("ERROR. Could not import product - Try Again."); }

		}

		private void dataGridViewProducts_DataError(object sender, DataGridViewDataErrorEventArgs e)
		{
			MessageBox.Show("Unallowed edit");
		}

		private async void btn_AddIngredient_Click(object sender, EventArgs e)
		{
			int price = 0;

			if (!int.TryParse(txbxAddIngPrice.Text, out price))
			{
				MessageBox.Show("Price must be a number");
				return;
			}

			var newIngredient = new Ingredient()
			{
				IngredientName = txbxAddIngName.Text,
				Price = price
			};

			try 
			{ 
				await _repo.AddNewIngredientAsync(newIngredient);
				MessageBox.Show("Successfully added new ingredient!");
			}
			catch
			{ 
				MessageBox.Show("Failed importing Ingredient. Please try again."); 
			}

			GetAllIngredientsBtn_Click(sender, e);
		}
	}
}
