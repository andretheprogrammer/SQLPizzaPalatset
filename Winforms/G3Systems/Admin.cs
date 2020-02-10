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
			// TODO: This line of code loads data into the 'g3SystemsDataSet1.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter1.Fill(this.g3SystemsDataSet1.Employees);
			// TODO: This line of code loads data into the 'g3SystemsDataSet.Employees' table. You can move, or remove it, as needed.
			this.employeesTableAdapter.Fill(this.g3SystemsDataSet.Employees);

		}

		private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
		{

		}

		private void Admin_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}
	}
}
