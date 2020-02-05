using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace G3Systems
{
	public partial class Cashier : Form
	{
		public Cashier()
		{
			InitializeComponent();
		}

		private void toolStripComboBox1_Click(object sender, EventArgs e)
		{

		}

		private void toolStripContainer1_LeftToolStripPanel_Click(object sender, EventArgs e)
		{

		}

		private void toolStripStatusLabel1_Click(object sender, EventArgs e)
		{

		}

		private void tabPage1_Click(object sender, EventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void statusStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
		{

		}

		private void tabPage1_Click_1(object sender, EventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void splitContainer1_Panel2_Paint(object sender, PaintEventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void bindingSource1_CurrentChanged(object sender, EventArgs e)
		{

		}

		private void Form1_Load(object sender, EventArgs e)
		{
			// TODO: This line of code loads data into the 'yODataSet.ProductOrders' table. You can move, or remove it, as needed.
			this.productOrdersTableAdapter.Fill(this.yODataSet.ProductOrders);
			// TODO: This line of code loads data into the 'yODataSet.Orders' table. You can move, or remove it, as needed.
			this.ordersTableAdapter.Fill(this.yODataSet.Orders);

		}

		private void dataGridView6_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void splitContainer5_Panel1_Paint(object sender, PaintEventArgs e)
		{

		}
	}
}
