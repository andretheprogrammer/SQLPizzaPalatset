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
	public partial class Cashier : Form
	{
		private Employee user;
		private readonly IG3SystemsRepository _repo;
		public Cashier(Employee puser)
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
			user = puser;
			lbl_username.Text = user.Username;

		}


		private void toolStripComboBox1_Click(object sender, EventArgs e)
		{

		}

		private void toolStripContainer1_LeftToolStripPanel_Click(object sender, EventArgs e)
		{

		}

		private void toolStripStatusLabel1_Click(object sender, EventArgs e)
		{

		}

		private void tabPage1_Click(object sender, EventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void statusStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
		{

		}

		private void tabPage1_Click_1(object sender, EventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void splitContainer1_Panel2_Paint(object sender, PaintEventArgs e)
		{
			this.WindowState = FormWindowState.Maximized;
		}

		private void bindingSource1_CurrentChanged(object sender, EventArgs e)
		{

		}

		private void Form1_Load(object sender, EventArgs e)
		{

		}

		private void dataGridView6_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
		{

		}

		private void splitContainer5_Panel1_Paint(object sender, PaintEventArgs e)
		{

		}

		private void Cashier_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}


		private async void btnPickedUp_Click(object sender, EventArgs e)
		{
			//
			//int selectedindex = lstbxC_Finished.SelectedItems.IndexOf();
			//int val = lstbxC_Finished.Ge

			foreach (int myitem in lstbxC_Finished.SelectedItems)
			{
				//label2.Text = label2.Text + "tea" + myitem;
				await _repo.SetOrderPickedUpToAsync(myitem,true);
			}

			btnRefresh.PerformClick();
			
		}




		private void lstbxProcessing_SelectedIndexChanged(object sender, EventArgs e)
		{

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

		//private void button3_Click(object sender, EventArgs e)
		//{

		//}

		private void btn_LogOut_Click(object sender, EventArgs e)
		{
			var form = new Login();
			form.Show();
			this.Hide();
		}
	}
}
