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
		}

		private void Admin_FormClosed(object sender, FormClosedEventArgs e)
		{
			var form = new Login();
			this.Dispose();
			form.ShowDialog();
		}

		// Employees
		private async void GetEmployeesBtn_Click(object sender, EventArgs e)
		{
			dataGridViewEmployees.DataSource = await _repo.GetEmployeesAsync();
		
		}

		// Employees
		private async void AddNewEmployeeBtn_Click(object sender, EventArgs e)
		{
			if (string.IsNullOrWhiteSpace(tbUsername.Text) ||
				string.IsNullOrWhiteSpace(tbPassword.Text))
			{
				MessageBox.Show("Invalid input");
				return;
			}

			editEmployee.Username = tbUsername.Text;
			editEmployee.Password = tbPassword.Text;

			await _repo.UpdateEmployeeAsync(editEmployee);
		}

		// Employees
		private void dataGridViewEmployees_SelectionChanged(object sender, EventArgs e)
		{
			if ((dataGridViewEmployees.SelectedRows.Count <= 0))
			{
				//tbUsername.Text = "";
				//tbPassword.Text = "";
				return;
			}

			editEmployee = (Employee)dataGridViewEmployees.SelectedRows[0].DataBoundItem;

			//tbUsername.Text = editEmployee.Username;
			//tbPassword.Text = editEmployee.Password;
		}

		// Employees
		private async void dataGridViewEmployees_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{
			if (e.ColumnIndex != dataGridViewEmployees.Columns["Selected"].Index)
			{
				return;
			}

			dataGridViewEmployees.CommitEdit(DataGridViewDataErrorContexts.Commit);
			await _repo.UpdateEmployeeAsync(this.editEmployee);
		}

		// Employees
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

		}
	}
}
