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
	public partial class InfoScreen : Form
	{
		private readonly IG3SystemsRepository _repo;
		public InfoScreen()
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
		}

		private void InfoScreen_Load_1(object sender, EventArgs e)
		{
			Timer Screentimer = new Timer();
			Screentimer.Interval = (2 * 1000); // 1 secs
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