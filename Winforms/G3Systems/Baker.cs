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
		
		private bool Lockedstate = false;


		//Ska ha som inputs helst: Employee, Building, Station
		public Baker(Employee puser)
		{
			InitializeComponent();
			_repo = new G3SystemsRepository();
			user = puser;
			lbl_username.Text = user.Username;
			lbl_usrPname.Text = user.Username;

			//Todo: hårdkodat här. Fixa så den visar riktigt värde.
			lbl_activated.Text = "True";
			lbl_visible.Text = "True";
			lblPassword.Text = "";

		}

		// TODO Rensa bort all skräp kod här tack. Utan att programmet kraschar
		private void splitContainer4_Panel2_Paint(object sender, PaintEventArgs e)
		{

		}

		private async void btn_Lock_click(object sender, EventArgs e)
		{
			if (noSelections()) { return; }
			
			if (Lockedstate == false) 
			{
				lstbxOpen.Enabled = false; //Nu AV-aktiveras ProductOrders-listan


				int pickedPO = getOpenListChoiceInt();

				//Hårdkodat??
				int pickedStation = 1;

				await _repo.SetLockOnkPOAsync(pickedPO, pickedStation);

				btn_Finished.Enabled = true;
				btn_Refresh.Enabled = false;
				btn_Finished.BackColor = Color.Lime;
				btn_Lock.Text = "Press to UNLOCK";
				btn_Finished.Text = "FINISHED";
				btn_Lock.BackColor = Color.Yellow;
				Lockedstate = true;


				}

			else
			{
				lstbxOpen.Enabled = true;

				int pickedPO = getOpenListChoiceInt();

				//Hårdkodat??
				int pickedStation = 1;

				await _repo.SetLockOnkPOAsync(pickedPO, 0);

				btn_Finished.Enabled = false;
				btn_Refresh.Enabled = true;
				btn_Finished.BackColor = Color.Gray;
				btn_Finished.Text = "";
				btn_Lock.Text = "Press to LOCK";
				btn_Lock.BackColor = Color.Beige;
				Lockedstate = false;
			}
			
		}

		private async void Baker_Load(object sender, EventArgs e)
		{
			//do stuff here when form loads

			lstbxOpen.Items.Clear();
			lstbxStuffings.Items.Clear();

			//Hårdkodat??
			int building = 1;
			repopulate_POList(building);


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

		private bool noSelections(){
			return lstbxOpen.SelectedItem == "" || lstbxOpen.SelectedItem is null;
		}

		private async void btn_Refresh_Click(object sender, EventArgs e)
		{
			if (noSelections() ) { return; } //Knapp kan inte göra något utan valda ProdOrders
			int pickedPO = getOpenListChoiceInt();

			lstbxOpen.Items.Clear();
			lstbxStuffings.Items.Clear();

			//Hårdkodat??
			int building = 1;



			repopulate_POList(building);
			repopulate_StuffingsList(pickedPO);
		}

		private int getOpenListChoiceInt() {
			return Int32.Parse((lstbxOpen.SelectedItems[0]).ToString().Split(':')[0]);
		}

		//TODO Ta bort async här?
		private async void lstbxOpen_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (noSelections()) { return; } //event kan inte göra något utan valda ProdOrders
			int pickedPO = getOpenListChoiceInt();

			lstbxStuffings.Items.Clear();

			//Hårdkodat??
			int building = 1;


			repopulate_StuffingsList(pickedPO);
		}

		private async void repopulate_POList(int building)
		{
			lstbxOpen.Items.Clear();
			List<Workload> openPOrders = (await _repo.GetOpenPOAsync(building)).ToList();
			openPOrders.ForEach(a => lstbxOpen.Items.Add(a.ProductOrderID + ": " + a.ProductName + ", " + a.PrepTime));
		}

		private async void repopulate_StuffingsList(int pickedPO)
		{
			lstbxStuffings.Items.Clear();
			List<Ingredient> stuffings = (await _repo.GetStuffingsAsync(pickedPO)).ToList();
			stuffings.ForEach(a => lstbxStuffings.Items.Add(a.IngredientName));
		}

		private async void btn_Finished_Click(object sender, EventArgs e)
		{

			lstbxOpen.Enabled = true;

			int pickedPO = getOpenListChoiceInt();

			//Hårdkodat??
			int pickedStation = 1;

			await _repo.SetProcessedOnkPOAsync(pickedPO, true);
			await _repo.SetLockOnkPOAsync(pickedPO, 0);

			btn_Finished.Enabled = false;
			btn_Refresh.Enabled = true;
			btn_Finished.BackColor = Color.Gray;
			btn_Finished.Text = "";
			btn_Lock.Text = "Press to LOCK";
			btn_Lock.BackColor = Color.Beige;
			Lockedstate = false;


			int building = 1;

			repopulate_POList(building);
			repopulate_StuffingsList(pickedPO);
		}

		private void lbl_username_Click(object sender, EventArgs e)
		{

		}
	}
}

