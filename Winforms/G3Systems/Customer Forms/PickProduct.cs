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
	public partial class PickProduct : Form
	{
		private readonly IG3SystemsRepository _repo;
		private readonly List<Product> cart;
		private readonly Order order;

		#region Form Load/Close
		public PickProduct(int terminalID)
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
			cart = new List<Product>();
			order = new Order() { ByTerminal = terminalID, Paid = false };
		}

		// Get cart sorted by producttype
		private List<Product> GetCart() => cart.OrderBy(p => p.ProductTypeID).ToList();

		private async void PickProduct_Load(object sender, EventArgs e)
		{
			try
			{
				order.OrderID = (await _repo.CreateNewOrderAsync(order));
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}

			// Cast and load productype enum onto listbox 
			//var values = Enum.GetValues(typeof(ProductType)).Cast<ProductType>().ToList();
			//values.ForEach(type => listBoxProductTypes.Items.Add(type));

			listBoxProductTypes.Items.Add(ProductType.Pizza);
			listBoxProductTypes.Items.Add(ProductType.Sallad);

			listBoxProductTypes.SelectedIndex = 0;
		}

		private void PickProduct_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}
		#endregion

		#region NavigationButtons
		private void FinishOrderBtn_Click(object sender, EventArgs e)
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
			lblTotalPrice.Text = $"Totalt pris: {cart.Sum(p => p.BasePrice)}";
		}

		// Return to start tab
		private void ReturnBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabProducts;
		}
		#endregion

		#region Tab 1 - Products tab
		private void CustomizeBtn_Click(object sender, EventArgs e)
		{
			// Go to tab 2 customize product ingredients
			tabControlMenu.SelectedTab = tabCustomize;

			if (gridViewCart.DataSource != null)
			{
				gridViewCart.DataSource = null;
			}

			// Load cart
			gridViewCart.DataSource = GetCart();
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

			// Save product to cart
			cart.Add(product);

			UpdateCart();
		}

		// Bottom cart
		private async void ListBoxProductTypes_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (listBoxProductTypes.SelectedItem == null)
			{
				return;
			}

			try
			{
				var type = (ProductType)listBoxProductTypes.SelectedItem;
				gridViewProducts.DataSource = await _repo.GetProductsAsync(type);
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
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

			var selectedProduct = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			var product = cart.Where(p => p.ProductID == selectedProduct.ProductID).FirstOrDefault();
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
				}
				else
				{
					productIngredient.Quantity += 1;
				}
			}
		}

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

			UpdateCart();
		}
		#endregion

		private async void ConfirmBtn_Click(object sender, EventArgs e)
		{
			await _repo.CreateProductOrdersAsync(GetInsertParameters(order));

			cart.Clear();
			gridViewCart.DataSource = null;
			UpdateIngredientGridView();
			UpdateCart();
			tabControlMenu.SelectedTab = tabQueue;
			labelQueue.Text = order.OrderID.ToString();

			// Temp ny order
			try
			{
				order.OrderID = (await _repo.CreateNewOrderAsync(order));
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}
		}

		private object[] GetInsertParameters(Order order)
		{
			var parameterList = new List<object>();

			foreach (var product in cart)
			{
				if (product.Ingredients == null)
				{
					parameterList.Add(InsertParameters(order, product));
				}

				foreach (var ingredient in product.Ingredients)
				{
					parameterList.Add(InsertParameters(order, product, ingredient));
				}
			}

			return parameterList.ToArray();
		}

		private object InsertParameters(Order order, Product product, Ingredient ingredient) => new
		{
			order.OrderID,
			product.ProductID,
			ingredient.IngredientID,
			ingredient.Quantity,
		};

		private object InsertParameters(Order order, Product product) => new
		{
			order.OrderID,
			product.ProductID,
		};

		private void UpdateCart()
		{
			listBoxCart.Items.Clear();

			foreach (var p in cart)
			{
				listBoxCart.Items.Add($"+ {p.ProductName}");
				{ Tag = p.ProductID; };
			}
		}
	}
}
