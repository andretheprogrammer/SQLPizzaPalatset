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
	public partial class Admin : Form
	{
		public Admin()
		{
			InitializeComponent();
		}

		private void splitContainer2_Panel2_Paint(object sender, PaintEventArgs e)
		{

		}

		private void tabPage1_Click(object sender, EventArgs e)
		{

		}

		private void splitContainer1_Panel1_Paint(object sender, PaintEventArgs e)
		{

		}

		private void splitContainer4_SplitterMoved(object sender, SplitterEventArgs e)
		{

		}

		private void Admin_Load(object sender, EventArgs e)
		{
			// TODO: This line of code loads data into the 'yODataSet.ProductOrders' table. You can move, or remove it, as needed.
			this.productOrdersTableAdapter.Fill(this.yODataSet.ProductOrders);
			// TODO: This line of code loads data into the 'yODataSet.Orders' table. You can move, or remove it, as needed.
			this.ordersTableAdapter.Fill(this.yODataSet.Orders);
			// TODO: This line of code loads data into the 'yODataSet.EmployeesHaveProductOrdersLockedInStations' table. You can move, or remove it, as needed.
			this.employeesHaveProductOrdersLockedInStationsTableAdapter.Fill(this.yODataSet.EmployeesHaveProductOrdersLockedInStations);
			// TODO: This line of code loads data into the 'yODataSet.Buildings' table. You can move, or remove it, as needed.
			this.buildingsTableAdapter.Fill(this.yODataSet.Buildings);
			// TODO: This line of code loads data into the 'yODataSet.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet.Employees);

		}

		private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
		{

		}
	}
}
