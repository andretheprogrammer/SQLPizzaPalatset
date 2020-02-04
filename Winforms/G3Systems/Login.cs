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
using PostgreSQL;

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
				_repo = new SQLServer.G3SystemsRepository();
			}
			else
			{
				_repo = new PostgreSQL.G3SystemsRepository();
			}

			cbConnectTo.SelectedIndex = 0;
		}

		public Employee User { get; private set; }

		private async void LoginBtn_Click(object sender, EventArgs e)
		{
			User = await Task.Run(() => _repo.EmployeeLoginAsync(tbUsername.Text, tbPassword.Text));

			if (User is null)
			{
				ShowErrorMessage("Fel login");
				return;
			}

			if (!User.HasAccess(cbConnectTo.SelectedIndex))
			{
				ShowErrorMessage("Access Denied");
				return;
			}


			MessageBox.Show($"Logged in as:\n{User.Username} ID: {User.EmployeeID}\n{User.EmployeeTypeID}");
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
			switch (selected)
			{
				case 0:
					{
						var form = new Admin();
						form.Show();
						break;
					}
				case 1:
					{
						var form = new Cashier();
						form.Show();
						break;
					}
				default:
					return;
			}

			this.Hide();
		}
	}
}
