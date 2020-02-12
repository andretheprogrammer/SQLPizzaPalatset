using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using TypeLib;
using G3Systems.Extensions;

namespace G3Systems
{
	/// <summary>
	/// Customer terminal form for handling new orders
	/// </summary>
	public partial class PickProduct : Form
	{
		private readonly IG3SystemsRepository _repo;
		private readonly List<Product> cart;
		private readonly Order order;

		#region Form Load/Close

		public PickProduct(int terminalID)
		{
			InitializeComponent();

			cart = new List<Product>();
			order = new Order() { ByTerminal = terminalID, Paid = false };

			try
			{
				// Get key string from App.config appsettings
				string _postgreBackEnd = ConfigurationManager.AppSettings.Keys[0];

				// Check if postgreSQL Back-End is set to true App.Config 
				if (_postgreBackEnd.GetConfigSetting())
				{
					MessageBox.Show("PostgreSQL", "Connected");
					_repo = new PostgreSQL.G3SystemsRepository();
				}
				else
				{
					//MessageBox.Show("MSSQL", "Connected");
					_repo = new SQLServer.G3SystemsRepository();
				}
			}
			catch
			{
				MessageBox.Show("Fel i App.config", "Error");
				throw;
			}
		}

		// Get cart sorted by producttype
		private List<Product> GetCart() => cart.OrderBy(p => p.ProductTypeID).ToList();

		// Return calculated total price for order as string
		private string GetTotalPrice() => $"Totalt pris: {cart.Sum(p => p.BasePrice)}";

		private async void PickProduct_Load(object sender, EventArgs e)
		{
			try
			{
				// Try to create a new order and collect OrderID from database
				order.OrderID = (await _repo.CreateNewOrderAsync(order));
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}

			// Hide and minimize tabs from display
			HideAllTabs();

			// Populate producttype listboxes
			LoadProductTypesListbox();
		}

		private void PickProduct_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}
		#endregion

		#region Main Navigation Buttons

		private void ContinueBtn_Click(object sender, EventArgs e)
		{
			if (cart.Count <= 0)
			{
				return;
			}

			// Go to finish order tab
			tabControlMenu.SelectedTab = tabPayment;

			if (gridViewFinishCart.DataSource != null)
			{
				gridViewFinishCart.DataSource = null;
			}

			// Load cart
			gridViewFinishCart.DataSource = GetCart();
			lblTotalPrice.Text = GetTotalPrice();
		}

		// Return to start tab
		private void ReturnBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabProducts;
			CustomizeBtn.Enabled = true;
		}

		private async void CancelOrderBtn_Click(object sender, EventArgs e)
		{
			// Set order to cancelled 
			order.Canceled = true;
			order.Paid = false;

			// Update orderstatus in database
			await _repo.UpdateOrderStatusAsync(order);

			// Return to entry form
			ReturnToEntryForm();
		}
		#endregion

		#region Tab 1 - Products tab

		private void CustomizeBtn_Click(object sender, EventArgs e)
		{
			// Go to tab 2 customize product ingredients
			tabControlMenu.SelectedTab = tabCustomize;

			UpdateGridViewCart();

			CustomizeBtn.Enabled = false;
		}

		// Add selected product to cart
		private async void AddProductBtn_Click(object sender, EventArgs e)
		{
			if ((gridViewProducts.SelectedRows.Count <= 0) ||
				!(gridViewProducts.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			// Save selected product from datagridview to product object
			var product = (Product)gridViewProducts.SelectedRows[0].DataBoundItem;

			// Fill product List<Ingredients> from database table ProductHaveIngredients
			product.Ingredients = (await _repo.GetHaveIngredientsAsync(product.ProductID)).ToList();

			AddProductToCart(product);
		}

		private async void ListBoxProductTypes_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (listBoxProductTypes.SelectedItem == null)
			{
				return;
			}

			try
			{
				var type = (ProductType)listBoxProductTypes.SelectedItem;
				gridViewProducts.DataSource = (await _repo.GetProductsAsync(type));
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:", msg.ToString());
				Application.Exit();
			}
		}
		#endregion

		#region Tab 2 - Customize

		private async void GridViewCart_SelectionChanged(object sender, EventArgs e)
		{
			if ((gridViewCart.SelectedRows.Count <= 0) ||
				!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;

			gridViewIngredients.DataSource = product.Ingredients;
			gridViewExtraIngredients.DataSource = await _repo.GetCanHaveIngredientsAsync(product.ProductID);
		}

		private void AddIngredientBtn_Click(object sender, EventArgs e)
		{
			if ((gridViewExtraIngredients.SelectedRows.Count <= 0) ||
				!(gridViewExtraIngredients.SelectedRows[0].DataBoundItem is Ingredient))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			var ingredient = (Ingredient)gridViewExtraIngredients.SelectedRows[0].DataBoundItem;

			ValidateAddIngredient(product, ingredient);
			UpdateIngredientGridView();
		}

		private void ValidateAddIngredient(Product product, Ingredient ingredient)
		{
			if (!product.Ingredients.Any(i => i.IngredientID == ingredient.IngredientID))
			{
				product.Ingredients.Add(ingredient);
			}
			else
			{
				var productIngredient = product.Ingredients.Where(i => i.IngredientID == ingredient.IngredientID).FirstOrDefault();

				if (productIngredient.Quantity >= 3)
				{
					MessageBox.Show("Kan inte lägga till fler");
					return;
				}
				else
				{
					productIngredient.Quantity += 1;
				}
			}

			if (product.Ingredients.Count > 4)
			{
				product.BasePrice += ingredient.Price;
			}
		}

		private void RemoveIngredientBtn_Click(object sender, EventArgs e)
		{
			if ((gridViewIngredients.SelectedRows.Count <= 0) ||
				!(gridViewIngredients.SelectedRows[0].DataBoundItem is Ingredient))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			var ingredient = (Ingredient)gridViewIngredients.SelectedRows[0].DataBoundItem;
			var dialogResult = MessageBox.Show($"Ta bort {ingredient.IngredientName}?", "", MessageBoxButtons.YesNo);

			if (product.Ingredients.Count <= 1)
			{
				MessageBox.Show("Kan inte ta bort allt innehåll", "Felmeddelande");
				return;
			}

			if (dialogResult == DialogResult.No)
			{
				return;
			}

			product.Ingredients.Remove(ingredient);

			// Stop price from going below baseprice
			if (!((product.BasePrice + ingredient.Price) <= 105))
			{
				product.BasePrice -= ingredient.Price;
			}

			UpdateGridViewCart();
			UpdateIngredientGridView();
		}

		private void RemoveProductBtn_Click(object sender, EventArgs e)
		{
			if ((gridViewCart.SelectedRows.Count <= 0) ||
				!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;

			RemoveProductFromCart(product);
			UpdateGridViewCart();
			UpdateIngredientGridView();
		}
		#endregion

		#region Tab 3 - Payment

		private void DeleteProductBtn_Click(object sender, EventArgs e)
		{
			if ((gridViewFinishCart.SelectedRows.Count <= 0) ||
				!(gridViewFinishCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewFinishCart.SelectedRows[0].DataBoundItem;
					   
			RemoveProductFromCart(product);

			UpdateFinishCart();
		}

		private async void ConfirmBtn_Click(object sender, EventArgs e)
		{
			try
			{
				// Try to create new order
				await _repo.CreateProductOrdersAsync(GetInsertParameters(order));
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.ToString());
			}

			ShowReceipt();

			// Set order to paid
			order.Paid = true;

			try
			{
				// Try to update orderstatus to paid
				await _repo.UpdateOrderStatusAsync(order);
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:", msg.ToString());
				Application.Exit();
			}

			// Close after n seconds
			await Task.Delay(TimeSpan.FromSeconds(2));
			ReturnToEntryForm();
		}
		#endregion

		#region Helper Methods

		// Add new product to cart list
		private void AddProductToCart(Product product)
		{
			// Save product to cart
			cart.Add(new Product()
			{
				ProductID = product.ProductID,
				ProductTypeID = product.ProductTypeID,
				ProductName = product.ProductName,
				PrepTime = product.PrepTime,
				BasePrice = product.BasePrice,
				Ingredients = product.Ingredients
			});

			UpdateListBoxCart();
		}

		// 
		private void RemoveProductFromCart(Product product)
		{
			var dialogResult = MessageBox.Show($"Ta bort {product.ProductName}?", "", MessageBoxButtons.YesNo);

			if (dialogResult == DialogResult.No)
			{
				return;
			}

			cart.Remove(product);
		}

		// Convert cart into parameter object array for database insert
		private object[] GetInsertParameters(Order order)
		{
			var parameterList = new List<object>();

			foreach (var product in cart)
			{
				if (product.Ingredients == null)
				{
					parameterList.Add(InsertParameters(order, product));
					continue;
				}

				product.Ingredients.ForEach(ingredient => 
					parameterList.Add(InsertParameters(
						order,
						product,
						ingredient)));
			}

			return parameterList.ToArray();
		}

		// Parameters for products with no ingredients
		private object InsertParameters(Order order, Product product) => new
		{
			order.OrderID,
			product.ProductID,
		};

		// Parameters for products with ingredients
		private object InsertParameters(Order order, Product product, Ingredient ingredient) => new
		{
			order.OrderID,
			product.ProductID,
			ingredient.IngredientID,
			ingredient.Quantity,
		};

		// Update the bottom cart listbox with all products for display purposes
		private void UpdateListBoxCart()
		{
			listBoxCart.Items.Clear();

			foreach (var p in cart)
			{
				listBoxCart.Items.Add($"+ {p.ProductName}");
				{ Tag = p.ProductID; };
			}
		}

		// Update gridview cart in customize tab
		private void UpdateGridViewCart()
		{
			if (gridViewCart.DataSource != null)
			{
				gridViewCart.DataSource = null;
			}

			// Load cart
			gridViewCart.DataSource = GetCart();
		}

		// Update ingredients gridviews in customize tab
		private void UpdateIngredientGridView()
		{
			gridViewIngredients.DataSource = null;

			if ((gridViewCart.SelectedRows.Count <= 0) ||
				!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			gridViewIngredients.DataSource = product.Ingredients;

			UpdateListBoxCart();
		}

		// Update gridviewcart in finished order tab
		private void UpdateFinishCart()
		{
			gridViewFinishCart.DataSource = null;
			gridViewFinishCart.DataSource = GetCart();
			lblTotalPrice.Text = GetTotalPrice();
			UpdateListBoxCart();
		}

		// Update list with all producttypes
		private void LoadProductTypesListbox()
		{
			// Cast all producttypes enums to list
			var values = Enum.GetValues(typeof(ProductType)).Cast<ProductType>().ToList();

			// Add values to listbox in Extras tab
			values.ForEach(type => listBoxProductTypes.Items.Add(type));

			listBoxProductTypes.SelectedIndex = 0;
		}

		// Show order complete screen
		private void ShowReceipt()
		{
			var dialogResult = MessageBox.Show("Visa kvitto?", "Betalning Godkänd", MessageBoxButtons.YesNo);

			if (dialogResult == DialogResult.Yes)
			{
				MessageBox.Show(
					string.Join("\n", cart.Select(p => p.ProductName)) +
					Environment.NewLine +
					GetTotalPrice(),
					$"Order# {order.OrderID}\n");
			}

			tabControlMain.SelectedTab = tabReceipt;
			labelQueue.Text = order.OrderID.ToString();
		}

		// Hide from tabs from selection
		private void HideAllTabs()
		{
			tabControlMain.ItemSize = new Size(0, 1);
			tabControlMain.SizeMode = TabSizeMode.Fixed;
			tabControlMenu.ItemSize = new Size(0, 1);
			tabControlMenu.SizeMode = TabSizeMode.Fixed;

			foreach (TabPage tab in tabControlMenu.TabPages)
			{
				tab.Text = "";
			}
		}

		// Call when return to CustomerEntry when order is complete or cancelled
		private void ReturnToEntryForm()
		{
			var form = new CustomerEnter(order.ByTerminal);
			this.Dispose();
			form.ShowDialog();
		}
		#endregion
	}
}
