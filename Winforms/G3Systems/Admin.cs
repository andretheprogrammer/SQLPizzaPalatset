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
	public partial class Admin : Form
	{
		private readonly IG3SystemsRepository _repo;
		private Employee user;

		public Admin(Employee user)
		{
			InitializeComponent();
			this.user = user;
			_repo = new G3SystemsRepository();
		}

		private void Admin_Load(object sender, EventArgs e)
		{


		}

		private void Admin_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}

		private void dataGridViewEmployees_KeyDown(object sender, KeyEventArgs e)
		{
			if (e.KeyData == Keys.Enter)
			{
				//e.SuppressKeyPress = true;
				//int row = dataGridViewEmployees.CurrentRow.Index;
				//int col = dataGridViewEmployees.CurrentCell.ColumnIndex;

				MessageBox.Show("Clicked");
			}
		}
	}
}
