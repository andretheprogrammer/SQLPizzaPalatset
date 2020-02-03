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
	public partial class Login : Form
	{
		private readonly IDataConnection _conn;

		public Login()
		{
			InitializeComponent();
			_conn = new G3SystemsRepository();
			cbConnectTo.SelectedIndex = 0;
		}

		public Employee User { get; private set; }

		private async void LoginBtn_Click(object sender, EventArgs e)
		{
			User = await Task.Run(() => _conn.LogInAsync(tbUsername.Text, tbPassword.Text));

			if (User != null)
			{
				MessageBox.Show($"Logged in as:\n{User.Username} ID: {User.EmployeeID}\n{cbConnectTo.SelectedItem.ToString()}");
				return;
			}

			MessageBox.Show("Fel login");
			tbUsername.Clear();
			tbPassword.Clear();
		}
	}
}
