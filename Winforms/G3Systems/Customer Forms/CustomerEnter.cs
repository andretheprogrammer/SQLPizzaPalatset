﻿using System;
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
			var form = new PickProduct();
			form.Show();
			this.Hide();
		}
	}
}
