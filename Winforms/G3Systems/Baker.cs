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
	public partial class Baker : Form
	{

		private Employee user;
		private readonly IG3SystemsRepository _repo;
		public Baker(Employee puser)
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
			user = puser;
			lbl_username.Text = user.Username;
			lbl_usrPname.Text = user.Username;

		}

		// TODO Rensa bort all skräp kod här tack. Utan att programmet kraschar
		private void splitContainer4_Panel2_Paint(object sender, PaintEventArgs e)
		{

		}

		private void button1_Click(object sender, EventArgs e)
		{
		}

		private async void Baker_Load(object sender, EventArgs e)
		{
			//do stuff here when form loads

			lstbxOpen.Items.Clear();
			lstbxStuffings.Items.Clear();

			//Hårdkodat??
			int building = 1;

			List<ProductOrder> openPOrders = (await _repo.GetOpenPOAsync(building)).ToList();

			openPOrders.ForEach(a => lstbxOpen.Items.Add(a.ProductOrderID));

		}

		private void splitContainer5_SplitterMoved(object sender, SplitterEventArgs e)
		{

		}

		private void splitContainer3_SplitterMoved(object sender, SplitterEventArgs e)
		{

		}

		private void fillByToolStripButton_Click(object sender, EventArgs e)
		{

		}

		private void fillByToolStripButton1_Click(object sender, EventArgs e)
		{

		}

		private void fillByToolStripButton2_Click(object sender, EventArgs e)
		{

		}

		private void fillByToolStripButton3_Click(object sender, EventArgs e)
		{

		}

		private void fillByToolStripButton_Click_1(object sender, EventArgs e)
		{

		}

		private void btn_Logout_Click(object sender, EventArgs e)
		{
			var form = new Login();
			form.Show();
			this.Hide();
		}

		private async void btn_Refresh_Click(object sender, EventArgs e)
		{
			lstbxOpen.SelectedItems.c
			int pickedPO = (int)lstbxOpen.SelectedItems[0];

			lstbxOpen.Items.Clear();
			lstbxStuffings.Items.Clear();

			//Hårdkodat??
			int building = 1;



			List<ProductOrder> openPOrders = (await _repo.GetOpenPOAsync(building)).ToList();
			List<Ingredient> stuffings = (await _repo.GetStuffingsAsync(pickedPO)).ToList();

			openPOrders.ForEach(a => lstbxOpen.Items.Add(a.ProductOrderID));
			stuffings.ForEach(a => lstbxStuffings.Items.Add(a.IngredientName));

			

		}

		private async void lstbxOpen_SelectedIndexChanged(object sender, EventArgs e)
		{
			
			int pickedPO = (int)lstbxOpen.SelectedItems[0];
			
			lstbxStuffings.Items.Clear();

			//Hårdkodat??
			int building = 1;

			List<Ingredient> stuffings = (await _repo.GetStuffingsAsync(pickedPO)).ToList();
			stuffings.ForEach(a => lstbxStuffings.Items.Add(a.IngredientName));


		}
	}
}
