using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using TypeLib;
using G3Systems.Extensions;

namespace G3Systems
{
	public partial class Login : Form
	{
		private readonly IG3SystemsRepository _repo;
		private Employee user;

		public Login()
		{
			InitializeComponent();

			try
			{
				// Get key string from App.config appsettings
				string _postgreBackEnd = ConfigurationManager.AppSettings.Keys[0];

				// Check if postgreSQL Back-End is set to true App.Config 
				if (_postgreBackEnd.GetConfigSetting())
				{
					MessageBox.Show("PostgreSQL", "Connected");
					_repo = new PostgreSQL.G3SystemsRepository();
				}
				else
				{
					//MessageBox.Show("MSSQL", "Connected");
					_repo = new SQLServer.G3SystemsRepository();
				}
			}
			catch
			{
				MessageBox.Show("Fel i App.config", "Error");
				throw;
			}

		cbConnectTo.SelectedIndex = 0;
		}


		private async void LoginBtn_Click(object sender, EventArgs e)
		{
			// Gets user if matching username and password exists
			user = await _repo.GetEmployeeLoginAsync(tbUsername.Text, tbPassword.Text);

			if (user is null)
			{
				ShowErrorMessage("Fel login");
				return;
			}

			await _repo.GetEmployeeTypesByIdAsync(user);

			// Block access if user has wrong type for selected form
			if (!user.HasAccess(cbConnectTo.SelectedIndex))
			{
				ShowErrorMessage("Access Denied");
				return;
			}

			//MessageBox.Show($"Logged in as:\n{user.Username} ID: {user.EmployeeID}\n");
			SwitchForm(cbConnectTo.SelectedIndex);
			user.LoggedIn = true;

			await _repo.UpdateEmployeeStatusAsync(user);
		}

		private void ShowErrorMessage(string msg)
		{
			MessageBox.Show(msg);
			tbUsername.Clear();
			tbPassword.Clear();
		}

		private void SwitchForm(int selected)
		{
			this.Hide();

			if (selected == 0)
			{
				var form = new Admin(user);
				form.ShowDialog();
			}
			else if (selected == 1)
			{
				var form = new Cashier(user);
				form.ShowDialog();
			}
			else if (selected == 2)
			{
				var form = new Baker(user);
				form.ShowDialog();
			}
			else if (selected == 3)
			{
				var form = new InfoScreen();
				form.ShowDialog();
			}
			else if (selected >= 4 && selected < 6)
			{
				var form = new CustomerEnter(selected - 3);
				form.ShowDialog();
				form.Text += $" {selected - 3}";
			}
			else
			{
				ShowErrorMessage("Inte implementerat");
				this.Show();
			}
		}

		private async void Login_FormClosing(object sender, FormClosingEventArgs e)
		{
			if (user != null)
			{
				user.LoggedIn = false;
				await _repo.UpdateEmployeeStatusAsync(user);
			}

			Application.Exit();
		}
	}
}
