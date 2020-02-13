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
	public partial class Cashier : Form
	{
		private Employee user;
		private readonly IG3SystemsRepository _repo;
		public Cashier(Employee puser)
		{
			InitializeComponent();
			user = puser;
			lbl_username.Text = user.Username;

			try
			{
				// Get key string from App.config appsettings
				string _postgreBackEnd = ConfigurationManager.AppSettings.Keys[0];

				// Check if postgreSQL Back-End is set to true App.Config 
				if (_postgreBackEnd.GetConfigSetting())
				{
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
		}

		private void tabPage1_Click(object sender, EventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}


		private void tabPage1_Click_1(object sender, EventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void splitContainer1_Panel2_Paint(object sender, PaintEventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void Cashier_FormClosed(object sender, FormClosedEventArgs e)
		{
			Logout();
		}


		private async void btnPickedUp_Click(object sender, EventArgs e)
		{
			//int selectedindex = lstbxC_Finished.SelectedItems.IndexOf();
			//int val = lstbxC_Finished.Ge

			foreach (int myitem in lstbxC_Finished.SelectedItems)
			{
				//label2.Text = label2.Text + "tea" + myitem;
				await _repo.SetOrderPickedUpToAsync(myitem,true);
			}

			btnRefresh.PerformClick();
		}

		private async void btnRefresh_click(object sender, EventArgs e)
		{
			lstbxC_Processing.Items.Clear();
			lstbxC_Finished.Items.Clear();

			List<Order> InProcessOrders = (await _repo.GetInProcessOrderssAsync(1)).ToList();
			List<Order> finishedOrders = (await _repo.GetFinishedOrdersAsync(1)).ToList();

			InProcessOrders.ForEach(a => lstbxC_Processing.Items.Add(a.OrderID));
			finishedOrders.ForEach(a => lstbxC_Finished.Items.Add(a.OrderID));

		}

		private void btn_LogOut_Click(object sender, EventArgs e)
		{
			Logout();
		}

		private void Logout()
		{
			var form = new Login();
			this.Dispose();
			form.ShowDialog();
		}
	}
}
