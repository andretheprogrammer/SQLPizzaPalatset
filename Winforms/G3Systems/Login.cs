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
		private readonly IG3SystemsRepository _repo;
		private readonly bool _sqlServerBackEnd = true;

		public Login()
		{
			InitializeComponent();

			if (_sqlServerBackEnd)
			{
				_repo = new G3SystemsRepository();
			}
			//else
			//{
			//	_repo = new PostgreSQL.G3SystemsRepository();
			//}

			cbConnectTo.SelectedIndex = 0;
		}

		public Employee User { get; private set; }

		private async void LoginBtn_Click(object sender, EventArgs e)
		{
			// Gets user if matching username and password exists
			User = await _repo.EmployeeLoginAsync(tbUsername.Text, tbPassword.Text);

			if (User is null)
			{
				ShowErrorMessage("Fel login");
				return;
			}

			await Task.Run(() => _repo.GetEmployeeTypesAsync(User));

			// Block access if user has wrong type for selected form
			if (!User.HasAccess(cbConnectTo.SelectedIndex))
			{
				ShowErrorMessage("Access Denied");
				return;
			}


			MessageBox.Show($"Logged in as:\n{User.Username} ID: {User.EmployeeID}\n");
			SwitchForm(cbConnectTo.SelectedIndex);
		}

		private void ShowErrorMessage(string msg)
		{
			MessageBox.Show(msg);
			tbUsername.Clear();
			tbPassword.Clear();
		}

		private void SwitchForm(int selected)
		{
			if (selected == 0)
			{
				var form = new Admin();
				form.Show();
			}
			else if (selected == 1)
			{
				var form = new Cashier(User);
				form.Show();
			}
			else if (selected == 2)
			{
				var form = new Baker(User);
				form.Show();
			}
			else if (selected == 3)
			{
				var form = new InfoScreen();
				form.Show();
			}
			else if (selected >= 4 && selected < 6)
			{
				var form = new CustomerEnter(selected - 3);
				form.Show();
				form.Text += $" {selected - 3}";
			}
			else
			{
				ShowErrorMessage("Inte implementerat");
			}

			this.Hide();
		}
	}
}
