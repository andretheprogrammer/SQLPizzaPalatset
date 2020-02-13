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
	public partial class InfoScreen : Form
	{
		private readonly IG3SystemsRepository _repo;

		public InfoScreen()
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
		}

		private void InfoScreen_Load_1(object sender, EventArgs e)
		{
			Timer Screentimer = new Timer();
			Screentimer.Interval = (10 * 1000); // 1 secs
			Screentimer.Tick += new EventHandler(Screen_Tick);
			Screentimer.Start();
		}

		private async void Screen_Tick(object sender, EventArgs e)
		{
			lstbxFinished.Items.Clear();
			lstbxProcessing.Items.Clear();

			List<Order> InProcessOrders = (await _repo.GetInProcessOrderssAsync(1)).ToList();
			List<Order> finishedOrders = (await _repo.GetFinishedOrdersAsync(1)).ToList();

			InProcessOrders.ForEach(a => lstbxProcessing.Items.Add(a.OrderID));
			finishedOrders.ForEach(a => lstbxFinished.Items.Add(a.OrderID));
		}

		private void button000_click(object sender, EventArgs e)
		{
			// Skapa ny random terminal
			Random rnd = new Random();
			int terminalID = rnd.Next(1, 50);
			var Form0 = new CustomerEnter(terminalID);
			Form0.Text += $" {terminalID}";
			Form0.ShowDialog();
		}

		private void InfoScreen_FormClosed(object sender, FormClosedEventArgs e)
		{
			var form = new Login();
			this.Dispose();
			form.ShowDialog();
		}
	}
}