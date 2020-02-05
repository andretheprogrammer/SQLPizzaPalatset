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
	public partial class Baker : Form
	{
		public Baker()
		{
			InitializeComponent();
		}

		private void splitContainer4_Panel2_Paint(object sender, PaintEventArgs e)
		{

		}

		private void button1_Click(object sender, EventArgs e)
		{
			if (dataGridView1.SelectedRows.Count != 0)
			{
			
			}
		}

		private void Baker_Load(object sender, EventArgs e)
		{
			// TODO: This line of code loads data into the 'yODataSet1.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet1.Employees);
			// TODO: This line of code loads data into the 'yODataSet1.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet1.Employees);
			// TODO: This line of code loads data into the 'yODataSet1.Buildings' table. You can move, or remove it, as needed.
			this.buildingsTableAdapter.Fill(this.yODataSet1.Buildings);
			// TODO: This line of code loads data into the 'yODataSet1.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet1.Employees);
			// TODO: This line of code loads data into the 'yODataSet1.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet1.Employees);
			// TODO: This line of code loads data into the 'yODataSet1.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet1.Employees);
			// TODO: This line of code loads data into the 'yODataSet.Stuffings' table. You can move, or remove it, as needed.
			this.stuffingsTableAdapter.Fill(this.yODataSet.Stuffings);
			// TODO: This line of code loads data into the 'yODataSet.ProductOrders' table. You can move, or remove it, as needed.
			this.productOrdersTableAdapter.Fill(this.yODataSet.ProductOrders);
			// TODO: This line of code loads data into the 'yODataSet.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.yODataSet.Employees);

		}

		private void splitContainer5_SplitterMoved(object sender, SplitterEventArgs e)
		{

		}

		private void splitContainer3_SplitterMoved(object sender, SplitterEventArgs e)
		{

		}

		private void fillByToolStripButton_Click(object sender, EventArgs e)
		{
			try
			{
				this.employeesTableAdapter.FillBy(this.yODataSet.Employees);
			}
			catch (System.Exception ex)
			{
				System.Windows.Forms.MessageBox.Show(ex.Message);
			}

		}

		private void fillByToolStripButton1_Click(object sender, EventArgs e)
		{
			try
			{
				this.employeesTableAdapter.FillBy(this.yODataSet.Employees);
			}
			catch (System.Exception ex)
			{
				System.Windows.Forms.MessageBox.Show(ex.Message);
			}

		}

		private void fillByToolStripButton2_Click(object sender, EventArgs e)
		{
			try
			{
				this.employeesTableAdapter.FillBy(this.yODataSet.Employees);
			}
			catch (System.Exception ex)
			{
				System.Windows.Forms.MessageBox.Show(ex.Message);
			}

		}

		private void fillByToolStripButton3_Click(object sender, EventArgs e)
		{
			try
			{
				this.employeesTableAdapter.FillBy(this.yODataSet.Employees);
			}
			catch (System.Exception ex)
			{
				System.Windows.Forms.MessageBox.Show(ex.Message);
			}

		}

		private void fillByToolStripButton_Click_1(object sender, EventArgs e)
		{
			try
			{
				this.employeesTableAdapter.FillBy(this.yODataSet.Employees);
			}
			catch (System.Exception ex)
			{
				System.Windows.Forms.MessageBox.Show(ex.Message);
			}

		}
	}
}
