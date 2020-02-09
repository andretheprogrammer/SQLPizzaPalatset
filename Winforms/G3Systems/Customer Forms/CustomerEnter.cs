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
		private readonly int _terminalID;

		public CustomerEnter(int terminalID)
		{
			InitializeComponent();
			_terminalID = terminalID;
		}

		private void NewOrderBtn_Click(object sender, EventArgs e)
		{
			var form = new PickProduct(_terminalID);
			form.Show();
			form.Text += $" {_terminalID}";
			this.Hide();


		}

		private void CustomerEnter_FormClosed(object sender, FormClosedEventArgs e)
		{
			Application.Exit();
			
		}
	}
}
