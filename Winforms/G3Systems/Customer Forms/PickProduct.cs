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

		private void UpdateCart()
		{
			listBoxCart.Items.Clear();

			foreach (var p in cart)
			{
				listBoxCart.Items.Add($"1x {p.ProductName}");
				{ Tag = p.ProductID; };
			}
		}

		private void FinishOrderBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabPayment;
		}

		private void CustomizeBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabCustomize;

			gridViewCart.DataSource = cart;
		}

		private void ReturnBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabProducts;
		}

		private void PickProduct_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
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

		private async void GridViewCart_SelectionChanged(object sender, EventArgs e)
		{
			await UpdateGridViewCart();
		}

		private async Task UpdateGridViewCart()
		{
			if ((gridViewCart.SelectedRows.Count <= 0) ||
				!(gridViewCart.SelectedRows[0].DataBoundItem is Product))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			gridViewExtraIngredients.DataSource = await _repo.GetCanHaveIngredientsAsync(product.ProductID);
			gridViewIngredients.DataSource = product.Ingredients;
			UpdateCart();
		}

		private async void AddIngredientBtn_Click(object sender, EventArgs e)
		{
			if ((gridViewExtraIngredients.SelectedRows.Count <= 0) ||
				!(gridViewExtraIngredients.SelectedRows[0].DataBoundItem is Ingredient))
			{
				return;
			}

			var product = (Product)gridViewCart.SelectedRows[0].DataBoundItem;
			var ingredient = (Ingredient)gridViewExtraIngredients.SelectedRows[0].DataBoundItem;

			if (!product.Ingredients.Any(i => i.IngredientID == ingredient.IngredientID))
			{
				product.Ingredients.Add(ingredient);
			}
			else
			{
				product.Ingredients.Where(i => i.IngredientID == ingredient.IngredientID).FirstOrDefault().Quantity += 1;
			}

			await UpdateGridViewCart();
		}
	}
}
