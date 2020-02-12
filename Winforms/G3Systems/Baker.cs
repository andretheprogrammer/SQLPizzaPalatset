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
	public partial class Baker : Form
	{

		private readonly IG3SystemsRepository _repo;
		private Employee user;
		
		private bool Lockedstate = false;
		private Station _station;

		//Ska ha som inputs helst: Employee, Building, Station
		public Baker(Employee puser)
		{
			InitializeComponent();

			user = puser;
			lbl_username.Text = user.Username;
			lbl_usrPname.Text = user.Username;

			try
			{
				// Get key string from App.config appsettings
				string _postgreBackEnd = ConfigurationManager.AppSettings.Keys[0];

				// Check if postgreSQL Back-End is set to true App.Config 
				if (_postgreBackEnd.GetConfigSetting())
				{
					MessageBox.Show("PostgreSQL", "Connected");
					//_repo = new PostgreSQL.G3SystemsRepository();
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

		private async void btn_Lock_click(object sender, EventArgs e)
		{
			Station currentstation = (await _repo.GetAssignedStation(user.EmployeeID));

			if (noSelections()) { return; }
			
			if (this.Lockedstate == false)  
			{
				//Tillstånd i Locked state

				lstbxOpen.Enabled = false; //Nu AV-aktiveras ProductOrders-listan
				int pickedPO = getOpenListChoiceInt();


				//Hårdkodat??
				await _repo.SetLockOnkPOAsync(pickedPO, currentstation.StationID);

				btn_Finished.Enabled = true;
				btn_Refresh.Enabled = false;
				btn_Refresh.Text = "";
				btn_Finished.BackColor = Color.Lime;
				btn_Lock.Text = "Press to UNLOCK";
				btn_Finished.Text = "FINISHED";
				btn_Lock.BackColor = Color.Yellow;
				this.Lockedstate = true;
				btnUnlocker.Enabled = true;
				btnUnlocker.Text = "UNLOCK STATION - RELEASE PO";


			}

			else
			{

				//STATES FÖR UPPLÅST LÄGE


				//btnUnlocker.PerformClick();

				btn_Finished.Enabled = false;
				btn_Refresh.Enabled = true;
				btn_Refresh.Text = "Refresh";
				btn_Finished.BackColor = Color.Gray;
				btn_Lock.Text = "Lock";
				btn_Finished.Text = "";
				btn_Lock.BackColor = Color.Beige;
				this.Lockedstate = false;
				lstbxOpen.Enabled = true;
				
				//disables the "first unlocker button"
				btnUnlocker.Enabled = false;


				//Unlocks the PO
				ProductOrder PO = await _repo.GetLockedPOByStation(currentstation.StationID);
				await _repo.SetLockOnkPOAsync(PO.ProductOrderID, 0);


			}

			ProductOrder lockedPOs = await _repo.GetLockedPOByStation(currentstation.StationID);
			if (lockedPOs is ProductOrder)
			{
				Product lockedProduct = await _repo.GetProductInfoFromPO(lockedPOs.ProductOrderID);
				lblLockedPO.Text = "Order:" + lockedPOs.OrderID + ", PO:" + lockedPOs.ProductOrderID + ", " + lockedProduct.ProductName;
			}
			else { lblLockedPO.Text = ""; }
			//RefreshLockStatus(currentstation);

		}

		//do stuff here when form loads
		private async void Baker_Load(object sender, EventArgs e)
		{

			Station currentstation = (await _repo.GetAssignedStation(user.EmployeeID));

			lblStationName.Text = currentstation.StationName;
			//Refresh
			
			RefreshLockStatus(currentstation);

			lstbxPossibleStations.Items.Clear();
			List<Station> poissibleStations = (await _repo.GetPossibleStationsForEmployee(user.EmployeeID)).ToList();
			poissibleStations.ForEach(a => lstbxPossibleStations.Items.Add(a.StationID + ": " + a.StationName));
			lblAssignment.Text = currentstation.StationName;

			lblEmployee.Text = "";
			//user.Types.ForEach(a => lblEmployee.Text += " | " + a);
			lblEmployee.Text = string.Join(" | ", user.Types);
		}

		private async void RefreshLockStatus(Station pStation){

			ProductOrder lockedPOs = await _repo.GetLockedPOByStation(pStation.StationID);

			if (lockedPOs is ProductOrder)
			//If there is a locked PO, then do the following.
			{

				Product lockedProduct = await _repo.GetProductInfoFromPO(lockedPOs.ProductOrderID);
				lblLockedPO.Text = "Order:" + lockedPOs.OrderID + ", PO:" + lockedPOs.ProductOrderID + ", " + lockedProduct.ProductName;

				//If PO is found, then enable the unlock button.
				btnUnlocker.Enabled = true;
				btnUnlocker.Text = "UNLOCK STATION - RELEASE PO";

				btn_Finished.Enabled = true;
				btn_Refresh.Enabled = false;
				btn_Finished.BackColor = Color.Lime;
				btn_Lock.Text = "Press to UNLOCK";
				btn_Finished.Text = "FINISHED";
				btn_Refresh.Text = "";

				btn_Lock.BackColor = Color.Yellow;
				btn_Lock.Enabled = false;

				repopulate_POList(pStation.InBuilding);
				repopulate_StuffingsList(pStation.InBuilding);
				lstbxOpen.Enabled = false;
				this.Lockedstate = true;

			}
			else
			{
				lblLockedPO.Text = "";
				//Otherwise keep grey...
				btnUnlocker.Enabled = false;
				btnUnlocker.Text = "Station is AVAILABLE";
				btn_Refresh.Text = "Refresh";
				btn_Finished.Enabled = false;
				btn_Refresh.Enabled = true;
				btn_Finished.BackColor = Color.Gray;
				btn_Finished.Text = "";
				btn_Lock.Text = "LOCK";
				btn_Lock.BackColor = Color.Beige;
				btn_Lock.Enabled = true;
				lstbxOpen.Enabled = true;
			
				repopulate_POList(pStation.InBuilding);
				this.Lockedstate = false;
			}


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

			Station currentstation = (await _repo.GetAssignedStation(user.EmployeeID));

			//Inkapsla
			ProductOrder lockedPOs = await _repo.GetLockedPOByStation(currentstation.StationID);
			if (lockedPOs is ProductOrder)
			{
				Product lockedProduct = await _repo.GetProductInfoFromPO(lockedPOs.ProductOrderID);
				lblLockedPO.Text = "Order:" + lockedPOs.OrderID + ", PO:" + lockedPOs.ProductOrderID + ", " + lockedProduct.ProductName;
			}
			else { lblLockedPO.Text = ""; }
			//


			repopulate_POList(currentstation.InBuilding);
			repopulate_StuffingsList(pickedPO);
		}

		private int getOpenListChoiceInt() {
			
			return Int32.Parse((lstbxOpen.SelectedItems[0]).ToString().Split(':')[0]);
		}

		private void lstbxOpen_SelectedIndexChanged(object sender, EventArgs e)
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

			Station currentstation = (await _repo.GetAssignedStation(user.EmployeeID));


			lstbxOpen.Enabled = true;
			try
			{
			//If it gets locked by choosing a PO
				int pickedPO = getOpenListChoiceInt();
				await _repo.SetProcessedOnkPOAsync(pickedPO, true);
				await _repo.SetLockOnkPOAsync(pickedPO, 0);
			}
			catch(IndexOutOfRangeException) {

				int pickedPO = currentstation.StationID;
				ProductOrder PO = await _repo.GetLockedPOByStation(currentstation.StationID);

				await _repo.SetProcessedOnkPOAsync(PO.ProductOrderID, true);
				await _repo.SetLockOnkPOAsync(PO.ProductOrderID, 0);

				//RefreshLockStatus(currentstation);
			}


			int pickedStation = currentstation.StationID;

			//inkapsla
			lstbxOpen.Enabled = true;
			btn_Finished.Enabled = false;
			btn_Refresh.Enabled = true;
			btn_Finished.BackColor = Color.Gray;
			btn_Finished.Text = "";
			btn_Lock.Text = "Press to LOCK";
			btn_Lock.BackColor = Color.Beige;
			btn_Lock.Enabled = true;
			this.Lockedstate = false;
			btnUnlocker.Enabled = false;
			btnUnlocker.Text = "Station is AVAILABLE";
			btn_Refresh.Text = "Refresh";
			//


			//inkapsla
			ProductOrder lockedPOs = await _repo.GetLockedPOByStation(currentstation.StationID);

			if (lockedPOs is ProductOrder)
			{
				Product lockedProduct = await _repo.GetProductInfoFromPO(lockedPOs.ProductOrderID);
				lblLockedPO.Text = "Order:" + lockedPOs.OrderID + ", PO:" + lockedPOs.ProductOrderID + ", " + lockedProduct.ProductName;
			}
			else { lblLockedPO.Text = ""; }
			//

			repopulate_POList(currentstation.InBuilding);
			repopulate_StuffingsList(currentstation.StationID);
		}

		private async void btnUnlocker_Click(object sender, EventArgs e)
		{

			//This unlocks the station! 

			Station currentstation = (await _repo.GetAssignedStation(user.EmployeeID));

			ProductOrder PO = await _repo.GetLockedPOByStation(currentstation.StationID);
			await _repo.SetLockOnkPOAsync(PO.ProductOrderID, 0);
			
			RefreshLockStatus(currentstation);




			lstbxOpen.Enabled = true;
		}

		private async void btnSwitcher_Click(object sender, EventArgs e)
		{

			string[] station = (lstbxPossibleStations.SelectedItems[0]).ToString().Split(':');
			int stationChoice = Int32.Parse(station[0]);
			await _repo.AssignStationAsync(user.EmployeeID, stationChoice);
			lblAssignment.Text = station[1];
			lblStationName.Text = station[1];

			Station currentstation = (await _repo.GetAssignedStation(user.EmployeeID));
			RefreshLockStatus(currentstation);

		}

		private void Baker_FormClosed(object sender, FormClosedEventArgs e)
		{
			var form = new Login();
			this.Dispose();
			form.ShowDialog();
		}
	}
}

