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
			this.ordersTableAdapter1.Fill(this.g3SystemsDataSet.Orders);
			this.ordersTableAdapter.Fill(this.dataSet1.Orders);

		}

		private void lstbxFinished_SelectedIndexChanged(object sender, EventArgs e)
		{

		}
	}
}
