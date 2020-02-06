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

		public PickProduct()
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
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
			GridViewProducts.DataSource = (await _repo.GetProductsAsync(ProductType.Pizza));
		}
	}
}
