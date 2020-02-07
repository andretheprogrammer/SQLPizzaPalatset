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

		public PickProduct()
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
			cart = new List<Product>();
		}

		private void PickProduct_Load(object sender, EventArgs e)
		{
			try
			{
				var values = Enum.GetValues(typeof(ProductType)).Cast<ProductType>().ToList();
				values.ForEach(type => listBoxProductTypes.Items.Add(type));
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}

			listBoxProductTypes.SelectedIndex = 0;
		}

		private void PickProduct_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}

		private void FinishOrderBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabPayment;
		}

		private void ReturnBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabProducts;
		}

		// Tab 1 - Products
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

		private void CustomizeBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabCustomize;
			gridViewCart.DataSource = cart;

			//if ((gridViewCart.SelectedRows.Count <= 0) ||
			//	!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			//{
			//	return;
			//}

			//var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
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
				gridViewProducts.DataSource = await _repo.GetProductsAsync(type);
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}
		}

		// Tab 2 - Customize
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

			UpdateGridViewCart();
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

			AddIngredient(product, ingredient);

			UpdateGridViewCart();
		}

		private void AddIngredient(Product product, Ingredient ingredient)
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

		private void UpdateGridViewCart()
		{
			gridViewCart.Update();
			gridViewCart.Refresh();

			if ((gridViewCart.SelectedRows.Count <= 0) ||
				!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			//gridViewIngredients.DataSource = product.Ingredients;
			gridViewIngredients.Update();
			gridViewIngredients.Refresh();
			UpdateCart();

			if ((gridViewCart.SelectedRows.Count <= 0) ||
				!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			gridViewIngredients.DataSource = product.Ingredients;
		}

		private void UpdateCart()
		{
			listBoxCart.Items.Clear();

			foreach (var p in cart)
			{
				listBoxCart.Items.Add($"1x {p.ProductName}");
				{ Tag = p.ProductID; };
			}
		}
	}
}
