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
		private List<Product> cart;

		public PickProduct()
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
			cart = new List<Product>();
		}

		private void AddProductBtn_Click(object sender, EventArgs e)
		{
			
		}

		private void FinishOrderBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabPayment;
		}

		private void CustomizeBtn_Click(object sender, EventArgs e)
		{
			tabControlMenu.SelectedTab = tabCustomize;
		}

		private void PickProduct_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}

		private async void PickProduct_Load(object sender, EventArgs e)
		{
			try
			{
				var values = Enum.GetValues(typeof(ProductType)).Cast<ProductType>().ToList();
				values.ForEach(type => ProductTypesListBox.Items.Add(type));
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}

			ProductTypesListBox.SelectedIndex = 0;
		}

		private async void ProductTypesListBox_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (ProductTypesListBox.SelectedItem == null)
			{
				return;
			}

			var type = (ProductType)ProductTypesListBox.SelectedItem;

			try
			{
				GridViewProducts.DataSource = await _repo.GetProductsAsync(type);
			}
			catch (Exception msg)
			{
				MessageBox.Show("Ett fel inträffade:\n" + msg);
				Application.Exit();
			}
		}
	}
}
