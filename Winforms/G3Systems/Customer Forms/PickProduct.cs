using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace G3Systems.Customer_Forms
{
	public partial class PickProduct : Form
	{
		public PickProduct()
		{
			InitializeComponent();
		}

		private void splitContainer2_Panel1_Paint(object sender, PaintEventArgs e)
		{

		}

		private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void splitContainer6_Panel1_Paint(object sender, PaintEventArgs e)
		{

		}

		private void PickProduct_Load(object sender, EventArgs e)
		{
			// TODO: This line of code loads data into the 'yODataSet.Orders' table. You can move, or remove it, as needed.
			this.ordersTableAdapter.Fill(this.yODataSet.Orders);
			// TODO: This line of code loads data into the 'yODataSet.Choices' table. You can move, or remove it, as needed.
			this.choicesTableAdapter.Fill(this.yODataSet.Choices);
			// TODO: This line of code loads data into the 'yODataSet.ProductTypes' table. You can move, or remove it, as needed.
			this.productTypesTableAdapter.Fill(this.yODataSet.ProductTypes);

		}

		private void tabPage3_Click(object sender, EventArgs e)
		{

		}

		private void label5_Click(object sender, EventArgs e)
		{

		}
	}
}
