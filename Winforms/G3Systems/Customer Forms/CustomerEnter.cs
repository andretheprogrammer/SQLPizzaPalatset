using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace G3Systems
{
	public partial class CustomerEnter : Form
	{
		public CustomerEnter()
		{
			InitializeComponent();
		}

		private void NewOrderBtn_Click(object sender, EventArgs e)
		{
			Random rnd = new Random();
			var terminalID = rnd.Next(1, 4);
			var form = new PickProduct(terminalID);
			form.Show();
			form.Text += $" {terminalID}";
			this.Hide();
		}

		private void CustomerEnter_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
		}
	}
}
