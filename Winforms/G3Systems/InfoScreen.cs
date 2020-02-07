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

		private void listView1_SelectedIndexChanged(object sender, EventArgs e)
		{

		}

		private async void FinishedOrderTiming_Tick(object sender, EventArgs e)
		{
			IEnumerable<Order> orders= await _repo.GetOrdersAsync();
			//ProcessingOrdersGrid.Clear();
			//foreach (Order order in orders)
			//{
			//	ListViewItem columnInList = new ListViewItem();
			//	columnInList.Tag = order.OrderId; //
			//	columnInList.Text = order.OrderId.ToString();
			//	//columnInList.SubItems.Add("second column");
			//	ProcessingOrdersGrid.Items.Add(columnInList);
				
			//}
			
		}

		private void InfoScreen_Load(object sender, EventArgs e)
		{


		}

		private void lstbxFinished_SelectedIndexChanged(object sender, EventArgs e)
		{

		}

		private void InfoScreen_Load_1(object sender, EventArgs e)
		{
			Timer Screentimer = new Timer();
			Screentimer.Interval = (1 * 1000); // 1 secs
			Screentimer.Tick += new EventHandler(Screen_Tick);
			Screentimer.Start();
		}

		private void Screen_Tick(object sender, EventArgs e)
		{
			//Ticklabel.Text = Ticklabel.Text + " o";
		}
	}
}
