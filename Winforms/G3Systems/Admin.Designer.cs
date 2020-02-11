namespace G3Systems
{
	partial class Admin
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Admin));
            System.Windows.Forms.ListViewGroup listViewGroup1 = new System.Windows.Forms.ListViewGroup("ListViewGroup", System.Windows.Forms.HorizontalAlignment.Left);
            System.Windows.Forms.ListViewGroup listViewGroup2 = new System.Windows.Forms.ListViewGroup("ListViewGroup", System.Windows.Forms.HorizontalAlignment.Right);
            System.Windows.Forms.ListViewItem listViewItem1 = new System.Windows.Forms.ListViewItem("Employee 1");
            System.Windows.Forms.ListViewItem listViewItem2 = new System.Windows.Forms.ListViewItem("Employee 2");
            System.Windows.Forms.ListViewItem listViewItem3 = new System.Windows.Forms.ListViewItem("Employee3");
            System.Windows.Forms.ListViewItem listViewItem4 = new System.Windows.Forms.ListViewItem("Cashier1");
            System.Windows.Forms.ListViewItem listViewItem5 = new System.Windows.Forms.ListViewItem("CAsheier2");
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.splitContainer4 = new System.Windows.Forms.SplitContainer();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.usrnLabel = new System.Windows.Forms.Label();
            this.LogoutButton = new System.Windows.Forms.Button();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.splitContainer3 = new System.Windows.Forms.SplitContainer();
            this.tabControl2 = new System.Windows.Forms.TabControl();
            this.tabPage8 = new System.Windows.Forms.TabPage();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.listViewLoggedInEmployees = new System.Windows.Forms.ListView();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.TabEmployees = new System.Windows.Forms.TabPage();
            this.tabControl3 = new System.Windows.Forms.TabControl();
            this.tabEditEmployees = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridViewEmployees = new System.Windows.Forms.DataGridView();
            this.employeeIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Username = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Password = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Selected = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewTextBoxColumn3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.employeeBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label8 = new System.Windows.Forms.Label();
            this.chkListBoxEmployeeType = new System.Windows.Forms.CheckedListBox();
            this.tbUsername = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tbPassword = new System.Windows.Forms.TextBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.AddNewEmployeeBtn = new System.Windows.Forms.Button();
            this.panel3 = new System.Windows.Forms.Panel();
            this.DeleteEmployeeBtn = new System.Windows.Forms.Button();
            this.GetEmployeesBtn = new System.Windows.Forms.Button();
            this.TabProducts = new System.Windows.Forms.TabPage();
            this.tabControl4 = new System.Windows.Forms.TabControl();
            this.tabProducts2 = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridViewProducts = new System.Windows.Forms.DataGridView();
            this.productIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productTypeIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.descriptionDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.prepTimeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.basePriceDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewCheckBoxColumn1 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn2 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.productBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.label9 = new System.Windows.Forms.Label();
            this.checkedListBox1 = new System.Windows.Forms.CheckedListBox();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.panel4 = new System.Windows.Forms.Panel();
            this.button1 = new System.Windows.Forms.Button();
            this.panel5 = new System.Windows.Forms.Panel();
            this.GetAllProductsBtn = new System.Windows.Forms.Button();
            this.tabIngredients = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridViewIngredients = new System.Windows.Forms.DataGridView();
            this.IngredientID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.IngredientName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Price = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Activated = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn4 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.ingredientBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.label12 = new System.Windows.Forms.Label();
            this.checkedListBox2 = new System.Windows.Forms.CheckedListBox();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.label13 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.panel6 = new System.Windows.Forms.Panel();
            this.button2 = new System.Windows.Forms.Button();
            this.panel7 = new System.Windows.Forms.Panel();
            this.GetAllIngredientsBtn = new System.Windows.Forms.Button();
            this.tabOrders = new System.Windows.Forms.TabPage();
            this.tabControl8 = new System.Windows.Forms.TabControl();
            this.tabPage11 = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridViewOrders = new System.Windows.Forms.DataGridView();
            this.OrderID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ByTerminal = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Paid = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.Canceled = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.PickedUp = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.ShowOnScreen = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.HappyCustomer = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.Returned = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn3 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn5 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.orderBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.panel9 = new System.Windows.Forms.Panel();
            this.GetAllOrdersBtn = new System.Windows.Forms.Button();
            this.tabPage12 = new System.Windows.Forms.TabPage();
            this.tableLayoutPanel5 = new System.Windows.Forms.TableLayoutPanel();
            this.dataGridViewPOrders = new System.Windows.Forms.DataGridView();
            this.ProductOrderID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ProductID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.LockedByStation = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Processed = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn6 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.Visible = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.productOrderIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.productIDDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.processedDataGridViewCheckBoxColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn7 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dataGridViewCheckBoxColumn8 = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.productOrderBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.panel8 = new System.Windows.Forms.Panel();
            this.GetAllProductOrdersBtn = new System.Windows.Forms.Button();
            this.tabBuildings = new System.Windows.Forms.TabPage();
            this.tabControl5 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.tabControl6 = new System.Windows.Forms.TabControl();
            this.tabPage5 = new System.Windows.Forms.TabPage();
            this.tabPage6 = new System.Windows.Forms.TabPage();
            this.productOrdersBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.productOrderBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer4)).BeginInit();
            this.splitContainer4.Panel1.SuspendLayout();
            this.splitContainer4.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).BeginInit();
            this.splitContainer3.Panel1.SuspendLayout();
            this.splitContainer3.Panel2.SuspendLayout();
            this.splitContainer3.SuspendLayout();
            this.tabControl2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tabControl1.SuspendLayout();
            this.TabEmployees.SuspendLayout();
            this.tabControl3.SuspendLayout();
            this.tabEditEmployees.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewEmployees)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeBindingSource)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel3.SuspendLayout();
            this.TabProducts.SuspendLayout();
            this.tabControl4.SuspendLayout();
            this.tabProducts2.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewProducts)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.productBindingSource)).BeginInit();
            this.groupBox3.SuspendLayout();
            this.panel4.SuspendLayout();
            this.panel5.SuspendLayout();
            this.tabIngredients.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewIngredients)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ingredientBindingSource)).BeginInit();
            this.groupBox4.SuspendLayout();
            this.panel6.SuspendLayout();
            this.panel7.SuspendLayout();
            this.tabOrders.SuspendLayout();
            this.tabControl8.SuspendLayout();
            this.tabPage11.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewOrders)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.orderBindingSource)).BeginInit();
            this.panel9.SuspendLayout();
            this.tabPage12.SuspendLayout();
            this.tableLayoutPanel5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewPOrders)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.productOrderBindingSource1)).BeginInit();
            this.panel8.SuspendLayout();
            this.tabBuildings.SuspendLayout();
            this.tabControl5.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabControl6.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.productOrdersBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.productOrderBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.pictureBox1);
            this.splitContainer1.Panel1.Controls.Add(this.panel1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.splitContainer2);
            this.splitContainer1.Size = new System.Drawing.Size(984, 614);
            this.splitContainer1.SplitterDistance = 115;
            this.splitContainer1.TabIndex = 0;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(-104, -217);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(648, 651);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.splitContainer4);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel1.Location = new System.Drawing.Point(784, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(200, 115);
            this.panel1.TabIndex = 4;
            // 
            // splitContainer4
            // 
            this.splitContainer4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer4.Location = new System.Drawing.Point(0, 0);
            this.splitContainer4.Name = "splitContainer4";
            this.splitContainer4.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer4.Panel1
            // 
            this.splitContainer4.Panel1.Controls.Add(this.flowLayoutPanel1);
            this.splitContainer4.Panel1.Enabled = false;
            this.splitContainer4.Panel1.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.splitContainer4.Size = new System.Drawing.Size(200, 115);
            this.splitContainer4.SplitterDistance = 55;
            this.splitContainer4.TabIndex = 0;
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.usrnLabel);
            this.flowLayoutPanel1.Controls.Add(this.LogoutButton);
            this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel1.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.flowLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(200, 55);
            this.flowLayoutPanel1.TabIndex = 0;
            // 
            // usrnLabel
            // 
            this.usrnLabel.AutoSize = true;
            this.usrnLabel.Location = new System.Drawing.Point(101, 0);
            this.usrnLabel.Name = "usrnLabel";
            this.usrnLabel.Padding = new System.Windows.Forms.Padding(0, 10, 20, 0);
            this.usrnLabel.Size = new System.Drawing.Size(96, 23);
            this.usrnLabel.TabIndex = 1;
            this.usrnLabel.Text = "AdamTheBoss";
            // 
            // LogoutButton
            // 
            this.LogoutButton.Location = new System.Drawing.Point(67, 26);
            this.LogoutButton.Name = "LogoutButton";
            this.LogoutButton.Size = new System.Drawing.Size(130, 23);
            this.LogoutButton.TabIndex = 3;
            this.LogoutButton.Text = "LogOut";
            this.LogoutButton.UseVisualStyleBackColor = true;
            // 
            // splitContainer2
            // 
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(0, 0);
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.splitContainer3);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.tabControl1);
            this.splitContainer2.Size = new System.Drawing.Size(984, 495);
            this.splitContainer2.SplitterDistance = 232;
            this.splitContainer2.TabIndex = 0;
            // 
            // splitContainer3
            // 
            this.splitContainer3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer3.Location = new System.Drawing.Point(0, 0);
            this.splitContainer3.Name = "splitContainer3";
            this.splitContainer3.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer3.Panel1
            // 
            this.splitContainer3.Panel1.Controls.Add(this.tabControl2);
            // 
            // splitContainer3.Panel2
            // 
            this.splitContainer3.Panel2.Controls.Add(this.groupBox1);
            this.splitContainer3.Size = new System.Drawing.Size(232, 495);
            this.splitContainer3.SplitterDistance = 334;
            this.splitContainer3.TabIndex = 0;
            // 
            // tabControl2
            // 
            this.tabControl2.Controls.Add(this.tabPage8);
            this.tabControl2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl2.Location = new System.Drawing.Point(0, 0);
            this.tabControl2.Name = "tabControl2";
            this.tabControl2.SelectedIndex = 0;
            this.tabControl2.Size = new System.Drawing.Size(232, 334);
            this.tabControl2.TabIndex = 0;
            // 
            // tabPage8
            // 
            this.tabPage8.Location = new System.Drawing.Point(4, 22);
            this.tabPage8.Name = "tabPage8";
            this.tabPage8.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage8.Size = new System.Drawing.Size(224, 308);
            this.tabPage8.TabIndex = 0;
            this.tabPage8.Text = "tabPage8";
            this.tabPage8.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.listViewLoggedInEmployees);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(0, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(232, 157);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Logged In Users";
            // 
            // listViewLoggedInEmployees
            // 
            this.listViewLoggedInEmployees.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2});
            this.listViewLoggedInEmployees.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.listViewLoggedInEmployees.Dock = System.Windows.Forms.DockStyle.Fill;
            listViewGroup1.Header = "ListViewGroup";
            listViewGroup1.Name = "listViewGroup1";
            listViewGroup2.Header = "ListViewGroup";
            listViewGroup2.HeaderAlignment = System.Windows.Forms.HorizontalAlignment.Right;
            listViewGroup2.Name = "listViewGroup2";
            this.listViewLoggedInEmployees.Groups.AddRange(new System.Windows.Forms.ListViewGroup[] {
            listViewGroup1,
            listViewGroup2});
            this.listViewLoggedInEmployees.HideSelection = false;
            this.listViewLoggedInEmployees.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
            listViewItem1,
            listViewItem2,
            listViewItem3,
            listViewItem4,
            listViewItem5});
            this.listViewLoggedInEmployees.Location = new System.Drawing.Point(3, 16);
            this.listViewLoggedInEmployees.Name = "listViewLoggedInEmployees";
            this.listViewLoggedInEmployees.ShowGroups = false;
            this.listViewLoggedInEmployees.Size = new System.Drawing.Size(226, 138);
            this.listViewLoggedInEmployees.TabIndex = 3;
            this.listViewLoggedInEmployees.UseCompatibleStateImageBehavior = false;
            this.listViewLoggedInEmployees.View = System.Windows.Forms.View.SmallIcon;
            // 
            // columnHeader1
            // 
            this.columnHeader1.Tag = "wa";
            this.columnHeader1.Text = "Logged in";
            this.columnHeader1.Width = 94;
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Station";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(19, 55);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(35, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "label3";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(19, 68);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(35, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "label2";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(19, 42);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "label1";
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.TabEmployees);
            this.tabControl1.Controls.Add(this.TabProducts);
            this.tabControl1.Controls.Add(this.tabOrders);
            this.tabControl1.Controls.Add(this.tabBuildings);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Multiline = true;
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(748, 495);
            this.tabControl1.TabIndex = 0;
            // 
            // TabEmployees
            // 
            this.TabEmployees.Controls.Add(this.tabControl3);
            this.TabEmployees.Location = new System.Drawing.Point(4, 22);
            this.TabEmployees.Name = "TabEmployees";
            this.TabEmployees.Padding = new System.Windows.Forms.Padding(3);
            this.TabEmployees.Size = new System.Drawing.Size(740, 469);
            this.TabEmployees.TabIndex = 0;
            this.TabEmployees.Text = "Employees";
            this.TabEmployees.UseVisualStyleBackColor = true;
            // 
            // tabControl3
            // 
            this.tabControl3.Controls.Add(this.tabEditEmployees);
            this.tabControl3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl3.Location = new System.Drawing.Point(3, 3);
            this.tabControl3.Name = "tabControl3";
            this.tabControl3.SelectedIndex = 0;
            this.tabControl3.Size = new System.Drawing.Size(734, 463);
            this.tabControl3.TabIndex = 0;
            // 
            // tabEditEmployees
            // 
            this.tabEditEmployees.Controls.Add(this.tableLayoutPanel2);
            this.tabEditEmployees.Location = new System.Drawing.Point(4, 22);
            this.tabEditEmployees.Name = "tabEditEmployees";
            this.tabEditEmployees.Padding = new System.Windows.Forms.Padding(3);
            this.tabEditEmployees.Size = new System.Drawing.Size(726, 437);
            this.tabEditEmployees.TabIndex = 0;
            this.tabEditEmployees.Text = "Edit Employees";
            this.tabEditEmployees.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 2;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 57.63889F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 42.36111F));
            this.tableLayoutPanel2.Controls.Add(this.dataGridViewEmployees, 0, 0);
            this.tableLayoutPanel2.Controls.Add(this.groupBox2, 1, 0);
            this.tableLayoutPanel2.Controls.Add(this.panel2, 1, 1);
            this.tableLayoutPanel2.Controls.Add(this.panel3, 0, 1);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 2;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 64.96519F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 35.0348F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(720, 431);
            this.tableLayoutPanel2.TabIndex = 8;
            // 
            // dataGridViewEmployees
            // 
            this.dataGridViewEmployees.AllowUserToAddRows = false;
            this.dataGridViewEmployees.AllowUserToDeleteRows = false;
            this.dataGridViewEmployees.AllowUserToResizeColumns = false;
            this.dataGridViewEmployees.AllowUserToResizeRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.WhiteSmoke;
            this.dataGridViewEmployees.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dataGridViewEmployees.AutoGenerateColumns = false;
            this.dataGridViewEmployees.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewEmployees.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.employeeIDDataGridViewTextBoxColumn,
            this.Username,
            this.Password,
            this.Selected,
            this.dataGridViewTextBoxColumn3});
            this.dataGridViewEmployees.DataSource = this.employeeBindingSource;
            this.dataGridViewEmployees.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridViewEmployees.Location = new System.Drawing.Point(3, 3);
            this.dataGridViewEmployees.MultiSelect = false;
            this.dataGridViewEmployees.Name = "dataGridViewEmployees";
            this.dataGridViewEmployees.RowHeadersVisible = false;
            this.dataGridViewEmployees.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridViewEmployees.Size = new System.Drawing.Size(409, 273);
            this.dataGridViewEmployees.TabIndex = 0;
            this.dataGridViewEmployees.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridViewEmployees_CellEndEdit);
            this.dataGridViewEmployees.SelectionChanged += new System.EventHandler(this.dataGridViewEmployees_SelectionChanged);
            // 
            // employeeIDDataGridViewTextBoxColumn
            // 
            this.employeeIDDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.employeeIDDataGridViewTextBoxColumn.DataPropertyName = "EmployeeID";
            this.employeeIDDataGridViewTextBoxColumn.HeaderText = "ID";
            this.employeeIDDataGridViewTextBoxColumn.Name = "employeeIDDataGridViewTextBoxColumn";
            this.employeeIDDataGridViewTextBoxColumn.ReadOnly = true;
            this.employeeIDDataGridViewTextBoxColumn.Width = 43;
            // 
            // Username
            // 
            this.Username.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Username.DataPropertyName = "Username";
            this.Username.HeaderText = "Username";
            this.Username.Name = "Username";
            // 
            // Password
            // 
            this.Password.DataPropertyName = "Password";
            this.Password.HeaderText = "Password";
            this.Password.Name = "Password";
            // 
            // Selected
            // 
            this.Selected.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.Selected.DataPropertyName = "LoggedIn";
            this.Selected.HeaderText = "LoggedIn";
            this.Selected.Name = "Selected";
            this.Selected.ReadOnly = true;
            this.Selected.Width = 58;
            // 
            // dataGridViewTextBoxColumn3
            // 
            this.dataGridViewTextBoxColumn3.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.dataGridViewTextBoxColumn3.DataPropertyName = "AssignedToStation";
            this.dataGridViewTextBoxColumn3.HeaderText = "Station";
            this.dataGridViewTextBoxColumn3.Name = "dataGridViewTextBoxColumn3";
            this.dataGridViewTextBoxColumn3.ReadOnly = true;
            this.dataGridViewTextBoxColumn3.Width = 65;
            // 
            // employeeBindingSource
            // 
            this.employeeBindingSource.DataSource = typeof(TypeLib.Employee);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label8);
            this.groupBox2.Controls.Add(this.chkListBoxEmployeeType);
            this.groupBox2.Controls.Add(this.tbUsername);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.tbPassword);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(418, 3);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(299, 273);
            this.groupBox2.TabIndex = 7;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "New user";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(40, 129);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(39, 13);
            this.label8.TabIndex = 7;
            this.label8.Text = "Types:";
            // 
            // chkListBoxEmployeeType
            // 
            this.chkListBoxEmployeeType.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.chkListBoxEmployeeType.CheckOnClick = true;
            this.chkListBoxEmployeeType.FormattingEnabled = true;
            this.chkListBoxEmployeeType.Location = new System.Drawing.Point(97, 129);
            this.chkListBoxEmployeeType.Name = "chkListBoxEmployeeType";
            this.chkListBoxEmployeeType.Size = new System.Drawing.Size(148, 105);
            this.chkListBoxEmployeeType.TabIndex = 6;
            // 
            // tbUsername
            // 
            this.tbUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbUsername.Location = new System.Drawing.Point(97, 43);
            this.tbUsername.Name = "tbUsername";
            this.tbUsername.Size = new System.Drawing.Size(148, 20);
            this.tbUsername.TabIndex = 2;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(23, 89);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(56, 13);
            this.label5.TabIndex = 5;
            this.label5.Text = "Password:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(21, 48);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(58, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "Username:";
            // 
            // tbPassword
            // 
            this.tbPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbPassword.Location = new System.Drawing.Point(97, 84);
            this.tbPassword.Name = "tbPassword";
            this.tbPassword.Size = new System.Drawing.Size(148, 20);
            this.tbPassword.TabIndex = 4;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.AddNewEmployeeBtn);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(418, 282);
            this.panel2.Name = "panel2";
            this.panel2.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel2.Size = new System.Drawing.Size(299, 146);
            this.panel2.TabIndex = 8;
            // 
            // AddNewEmployeeBtn
            // 
            this.AddNewEmployeeBtn.Dock = System.Windows.Forms.DockStyle.Right;
            this.AddNewEmployeeBtn.Location = new System.Drawing.Point(199, 0);
            this.AddNewEmployeeBtn.Name = "AddNewEmployeeBtn";
            this.AddNewEmployeeBtn.Size = new System.Drawing.Size(100, 46);
            this.AddNewEmployeeBtn.TabIndex = 6;
            this.AddNewEmployeeBtn.Text = "Save";
            this.AddNewEmployeeBtn.UseVisualStyleBackColor = true;
            this.AddNewEmployeeBtn.Click += new System.EventHandler(this.AddNewEmployeeBtn_Click);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.DeleteEmployeeBtn);
            this.panel3.Controls.Add(this.GetEmployeesBtn);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel3.Location = new System.Drawing.Point(3, 282);
            this.panel3.Name = "panel3";
            this.panel3.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel3.Size = new System.Drawing.Size(409, 146);
            this.panel3.TabIndex = 9;
            // 
            // DeleteEmployeeBtn
            // 
            this.DeleteEmployeeBtn.Dock = System.Windows.Forms.DockStyle.Right;
            this.DeleteEmployeeBtn.Location = new System.Drawing.Point(309, 0);
            this.DeleteEmployeeBtn.Name = "DeleteEmployeeBtn";
            this.DeleteEmployeeBtn.Size = new System.Drawing.Size(100, 46);
            this.DeleteEmployeeBtn.TabIndex = 7;
            this.DeleteEmployeeBtn.Text = "Delete";
            this.DeleteEmployeeBtn.UseVisualStyleBackColor = true;
            this.DeleteEmployeeBtn.Click += new System.EventHandler(this.DeleteEmployeeBtn_Click);
            // 
            // GetEmployeesBtn
            // 
            this.GetEmployeesBtn.Dock = System.Windows.Forms.DockStyle.Left;
            this.GetEmployeesBtn.Location = new System.Drawing.Point(0, 0);
            this.GetEmployeesBtn.Name = "GetEmployeesBtn";
            this.GetEmployeesBtn.Size = new System.Drawing.Size(100, 46);
            this.GetEmployeesBtn.TabIndex = 1;
            this.GetEmployeesBtn.Text = "Get All";
            this.GetEmployeesBtn.UseVisualStyleBackColor = true;
            this.GetEmployeesBtn.Click += new System.EventHandler(this.GetEmployeesBtn_Click);
            // 
            // TabProducts
            // 
            this.TabProducts.Controls.Add(this.tabControl4);
            this.TabProducts.Location = new System.Drawing.Point(4, 22);
            this.TabProducts.Name = "TabProducts";
            this.TabProducts.Padding = new System.Windows.Forms.Padding(3);
            this.TabProducts.Size = new System.Drawing.Size(740, 469);
            this.TabProducts.TabIndex = 1;
            this.TabProducts.Text = "Products";
            this.TabProducts.UseVisualStyleBackColor = true;
            // 
            // tabControl4
            // 
            this.tabControl4.Controls.Add(this.tabProducts2);
            this.tabControl4.Controls.Add(this.tabIngredients);
            this.tabControl4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl4.Location = new System.Drawing.Point(3, 3);
            this.tabControl4.Name = "tabControl4";
            this.tabControl4.SelectedIndex = 0;
            this.tabControl4.Size = new System.Drawing.Size(734, 463);
            this.tabControl4.TabIndex = 0;
            // 
            // tabProducts2
            // 
            this.tabProducts2.Controls.Add(this.tableLayoutPanel3);
            this.tabProducts2.Location = new System.Drawing.Point(4, 22);
            this.tabProducts2.Name = "tabProducts2";
            this.tabProducts2.Padding = new System.Windows.Forms.Padding(3);
            this.tabProducts2.Size = new System.Drawing.Size(726, 437);
            this.tabProducts2.TabIndex = 0;
            this.tabProducts2.Text = "Products";
            this.tabProducts2.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.ColumnCount = 2;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 61.80556F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 38.19444F));
            this.tableLayoutPanel3.Controls.Add(this.dataGridViewProducts, 0, 0);
            this.tableLayoutPanel3.Controls.Add(this.groupBox3, 1, 0);
            this.tableLayoutPanel3.Controls.Add(this.panel4, 1, 1);
            this.tableLayoutPanel3.Controls.Add(this.panel5, 0, 1);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 2;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 64.96519F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 35.0348F));
            this.tableLayoutPanel3.Size = new System.Drawing.Size(720, 431);
            this.tableLayoutPanel3.TabIndex = 9;
            // 
            // dataGridViewProducts
            // 
            this.dataGridViewProducts.AllowUserToResizeColumns = false;
            this.dataGridViewProducts.AllowUserToResizeRows = false;
            this.dataGridViewProducts.AutoGenerateColumns = false;
            this.dataGridViewProducts.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewProducts.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.productIDDataGridViewTextBoxColumn,
            this.productTypeIDDataGridViewTextBoxColumn,
            this.productNameDataGridViewTextBoxColumn,
            this.descriptionDataGridViewTextBoxColumn,
            this.prepTimeDataGridViewTextBoxColumn,
            this.basePriceDataGridViewTextBoxColumn,
            this.dataGridViewCheckBoxColumn1,
            this.dataGridViewCheckBoxColumn2});
            this.dataGridViewProducts.DataSource = this.productBindingSource;
            this.dataGridViewProducts.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridViewProducts.Location = new System.Drawing.Point(3, 3);
            this.dataGridViewProducts.MultiSelect = false;
            this.dataGridViewProducts.Name = "dataGridViewProducts";
            this.dataGridViewProducts.RowHeadersVisible = false;
            this.dataGridViewProducts.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridViewProducts.Size = new System.Drawing.Size(439, 273);
            this.dataGridViewProducts.TabIndex = 0;
            this.dataGridViewProducts.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridViewProducts_CellEndEdit);
            this.dataGridViewProducts.SelectionChanged += new System.EventHandler(this.dataGridViewProducts_SelectionChangedAsync);
            // 
            // productIDDataGridViewTextBoxColumn
            // 
            this.productIDDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.productIDDataGridViewTextBoxColumn.DataPropertyName = "ProductID";
            this.productIDDataGridViewTextBoxColumn.HeaderText = "ProductID";
            this.productIDDataGridViewTextBoxColumn.Name = "productIDDataGridViewTextBoxColumn";
            this.productIDDataGridViewTextBoxColumn.ReadOnly = true;
            this.productIDDataGridViewTextBoxColumn.Width = 80;
            // 
            // productTypeIDDataGridViewTextBoxColumn
            // 
            this.productTypeIDDataGridViewTextBoxColumn.DataPropertyName = "ProductTypeID";
            this.productTypeIDDataGridViewTextBoxColumn.HeaderText = "ProductTypeID";
            this.productTypeIDDataGridViewTextBoxColumn.Name = "productTypeIDDataGridViewTextBoxColumn";
            // 
            // productNameDataGridViewTextBoxColumn
            // 
            this.productNameDataGridViewTextBoxColumn.DataPropertyName = "ProductName";
            this.productNameDataGridViewTextBoxColumn.HeaderText = "ProductName";
            this.productNameDataGridViewTextBoxColumn.Name = "productNameDataGridViewTextBoxColumn";
            // 
            // descriptionDataGridViewTextBoxColumn
            // 
            this.descriptionDataGridViewTextBoxColumn.DataPropertyName = "Description";
            this.descriptionDataGridViewTextBoxColumn.HeaderText = "Description";
            this.descriptionDataGridViewTextBoxColumn.Name = "descriptionDataGridViewTextBoxColumn";
            // 
            // prepTimeDataGridViewTextBoxColumn
            // 
            this.prepTimeDataGridViewTextBoxColumn.DataPropertyName = "PrepTime";
            this.prepTimeDataGridViewTextBoxColumn.HeaderText = "PrepTime";
            this.prepTimeDataGridViewTextBoxColumn.Name = "prepTimeDataGridViewTextBoxColumn";
            // 
            // basePriceDataGridViewTextBoxColumn
            // 
            this.basePriceDataGridViewTextBoxColumn.DataPropertyName = "BasePrice";
            this.basePriceDataGridViewTextBoxColumn.HeaderText = "BasePrice";
            this.basePriceDataGridViewTextBoxColumn.Name = "basePriceDataGridViewTextBoxColumn";
            // 
            // dataGridViewCheckBoxColumn1
            // 
            this.dataGridViewCheckBoxColumn1.DataPropertyName = "Activated";
            this.dataGridViewCheckBoxColumn1.HeaderText = "Activated";
            this.dataGridViewCheckBoxColumn1.Name = "dataGridViewCheckBoxColumn1";
            // 
            // dataGridViewCheckBoxColumn2
            // 
            this.dataGridViewCheckBoxColumn2.DataPropertyName = "Visible";
            this.dataGridViewCheckBoxColumn2.HeaderText = "Visible";
            this.dataGridViewCheckBoxColumn2.Name = "dataGridViewCheckBoxColumn2";
            // 
            // productBindingSource
            // 
            this.productBindingSource.DataSource = typeof(TypeLib.Product);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.label9);
            this.groupBox3.Controls.Add(this.checkedListBox1);
            this.groupBox3.Controls.Add(this.textBox1);
            this.groupBox3.Controls.Add(this.label10);
            this.groupBox3.Controls.Add(this.label11);
            this.groupBox3.Controls.Add(this.textBox2);
            this.groupBox3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox3.Location = new System.Drawing.Point(448, 3);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(269, 273);
            this.groupBox3.TabIndex = 7;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "New user";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(40, 129);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(39, 13);
            this.label9.TabIndex = 7;
            this.label9.Text = "Types:";
            // 
            // checkedListBox1
            // 
            this.checkedListBox1.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.checkedListBox1.CheckOnClick = true;
            this.checkedListBox1.FormattingEnabled = true;
            this.checkedListBox1.Location = new System.Drawing.Point(97, 129);
            this.checkedListBox1.Name = "checkedListBox1";
            this.checkedListBox1.Size = new System.Drawing.Size(148, 105);
            this.checkedListBox1.TabIndex = 6;
            // 
            // textBox1
            // 
            this.textBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox1.Location = new System.Drawing.Point(97, 43);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(148, 22);
            this.textBox1.TabIndex = 2;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(23, 89);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(56, 13);
            this.label10.TabIndex = 5;
            this.label10.Text = "Password:";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(21, 48);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(58, 13);
            this.label11.TabIndex = 3;
            this.label11.Text = "Username:";
            // 
            // textBox2
            // 
            this.textBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox2.Location = new System.Drawing.Point(97, 84);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(148, 22);
            this.textBox2.TabIndex = 4;
            // 
            // panel4
            // 
            this.panel4.Controls.Add(this.button1);
            this.panel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel4.Location = new System.Drawing.Point(448, 282);
            this.panel4.Name = "panel4";
            this.panel4.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel4.Size = new System.Drawing.Size(269, 146);
            this.panel4.TabIndex = 8;
            // 
            // button1
            // 
            this.button1.Dock = System.Windows.Forms.DockStyle.Right;
            this.button1.Location = new System.Drawing.Point(169, 0);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(100, 46);
            this.button1.TabIndex = 6;
            this.button1.Text = "Save";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // panel5
            // 
            this.panel5.Controls.Add(this.GetAllProductsBtn);
            this.panel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel5.Location = new System.Drawing.Point(3, 282);
            this.panel5.Name = "panel5";
            this.panel5.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel5.Size = new System.Drawing.Size(439, 146);
            this.panel5.TabIndex = 9;
            // 
            // GetAllProductsBtn
            // 
            this.GetAllProductsBtn.Dock = System.Windows.Forms.DockStyle.Left;
            this.GetAllProductsBtn.Location = new System.Drawing.Point(0, 0);
            this.GetAllProductsBtn.Name = "GetAllProductsBtn";
            this.GetAllProductsBtn.Size = new System.Drawing.Size(100, 46);
            this.GetAllProductsBtn.TabIndex = 1;
            this.GetAllProductsBtn.Text = "Get All";
            this.GetAllProductsBtn.UseVisualStyleBackColor = true;
            this.GetAllProductsBtn.Click += new System.EventHandler(this.GetAllProductsBtn_Click);
            // 
            // tabIngredients
            // 
            this.tabIngredients.Controls.Add(this.tableLayoutPanel4);
            this.tabIngredients.Location = new System.Drawing.Point(4, 22);
            this.tabIngredients.Name = "tabIngredients";
            this.tabIngredients.Padding = new System.Windows.Forms.Padding(3);
            this.tabIngredients.Size = new System.Drawing.Size(726, 437);
            this.tabIngredients.TabIndex = 1;
            this.tabIngredients.Text = "Ingredients";
            this.tabIngredients.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel4
            // 
            this.tableLayoutPanel4.ColumnCount = 2;
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 61.80556F));
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 38.19444F));
            this.tableLayoutPanel4.Controls.Add(this.dataGridViewIngredients, 0, 0);
            this.tableLayoutPanel4.Controls.Add(this.groupBox4, 1, 0);
            this.tableLayoutPanel4.Controls.Add(this.panel6, 1, 1);
            this.tableLayoutPanel4.Controls.Add(this.panel7, 0, 1);
            this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel4.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel4.Name = "tableLayoutPanel4";
            this.tableLayoutPanel4.RowCount = 2;
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 64.96519F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 35.0348F));
            this.tableLayoutPanel4.Size = new System.Drawing.Size(720, 431);
            this.tableLayoutPanel4.TabIndex = 10;
            // 
            // dataGridViewIngredients
            // 
            this.dataGridViewIngredients.AllowUserToResizeColumns = false;
            this.dataGridViewIngredients.AllowUserToResizeRows = false;
            this.dataGridViewIngredients.AutoGenerateColumns = false;
            this.dataGridViewIngredients.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewIngredients.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.IngredientID,
            this.IngredientName,
            this.Price,
            this.Activated,
            this.dataGridViewCheckBoxColumn4});
            this.dataGridViewIngredients.DataSource = this.ingredientBindingSource;
            this.dataGridViewIngredients.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridViewIngredients.Location = new System.Drawing.Point(3, 3);
            this.dataGridViewIngredients.MultiSelect = false;
            this.dataGridViewIngredients.Name = "dataGridViewIngredients";
            this.dataGridViewIngredients.RowHeadersVisible = false;
            this.dataGridViewIngredients.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridViewIngredients.Size = new System.Drawing.Size(439, 273);
            this.dataGridViewIngredients.TabIndex = 0;
            this.dataGridViewIngredients.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridViewIngredients_CellEndEdit);
            this.dataGridViewIngredients.SelectionChanged += new System.EventHandler(this.dataGridViewIngredients_SelectionChanged);
            // 
            // IngredientID
            // 
            this.IngredientID.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.IngredientID.DataPropertyName = "IngredientID";
            this.IngredientID.HeaderText = "IngredientID";
            this.IngredientID.Name = "IngredientID";
            this.IngredientID.ReadOnly = true;
            this.IngredientID.Width = 90;
            // 
            // IngredientName
            // 
            this.IngredientName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.IngredientName.DataPropertyName = "IngredientName";
            this.IngredientName.HeaderText = "IngredientName";
            this.IngredientName.Name = "IngredientName";
            // 
            // Price
            // 
            this.Price.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.Price.DataPropertyName = "Price";
            this.Price.HeaderText = "Price";
            this.Price.Name = "Price";
            this.Price.Width = 56;
            // 
            // Activated
            // 
            this.Activated.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.Activated.DataPropertyName = "Activated";
            this.Activated.HeaderText = "Activated";
            this.Activated.Name = "Activated";
            this.Activated.Width = 58;
            // 
            // dataGridViewCheckBoxColumn4
            // 
            this.dataGridViewCheckBoxColumn4.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.ColumnHeader;
            this.dataGridViewCheckBoxColumn4.DataPropertyName = "Visible";
            this.dataGridViewCheckBoxColumn4.HeaderText = "Visible";
            this.dataGridViewCheckBoxColumn4.Name = "dataGridViewCheckBoxColumn4";
            this.dataGridViewCheckBoxColumn4.Width = 43;
            // 
            // ingredientBindingSource
            // 
            this.ingredientBindingSource.DataSource = typeof(TypeLib.Ingredient);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.label12);
            this.groupBox4.Controls.Add(this.checkedListBox2);
            this.groupBox4.Controls.Add(this.textBox3);
            this.groupBox4.Controls.Add(this.label13);
            this.groupBox4.Controls.Add(this.label14);
            this.groupBox4.Controls.Add(this.textBox4);
            this.groupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox4.Location = new System.Drawing.Point(448, 3);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(269, 273);
            this.groupBox4.TabIndex = 7;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "New user";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label12.Location = new System.Drawing.Point(40, 129);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(39, 13);
            this.label12.TabIndex = 7;
            this.label12.Text = "Types:";
            // 
            // checkedListBox2
            // 
            this.checkedListBox2.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.checkedListBox2.CheckOnClick = true;
            this.checkedListBox2.FormattingEnabled = true;
            this.checkedListBox2.Location = new System.Drawing.Point(97, 129);
            this.checkedListBox2.Name = "checkedListBox2";
            this.checkedListBox2.Size = new System.Drawing.Size(148, 105);
            this.checkedListBox2.TabIndex = 6;
            // 
            // textBox3
            // 
            this.textBox3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox3.Location = new System.Drawing.Point(97, 43);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(148, 22);
            this.textBox3.TabIndex = 2;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label13.Location = new System.Drawing.Point(23, 89);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(56, 13);
            this.label13.TabIndex = 5;
            this.label13.Text = "Password:";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label14.Location = new System.Drawing.Point(21, 48);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(58, 13);
            this.label14.TabIndex = 3;
            this.label14.Text = "Username:";
            // 
            // textBox4
            // 
            this.textBox4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox4.Location = new System.Drawing.Point(97, 84);
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new System.Drawing.Size(148, 22);
            this.textBox4.TabIndex = 4;
            // 
            // panel6
            // 
            this.panel6.Controls.Add(this.button2);
            this.panel6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel6.Location = new System.Drawing.Point(448, 282);
            this.panel6.Name = "panel6";
            this.panel6.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel6.Size = new System.Drawing.Size(269, 146);
            this.panel6.TabIndex = 8;
            // 
            // button2
            // 
            this.button2.Dock = System.Windows.Forms.DockStyle.Right;
            this.button2.Location = new System.Drawing.Point(169, 0);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(100, 46);
            this.button2.TabIndex = 6;
            this.button2.Text = "Save";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // panel7
            // 
            this.panel7.Controls.Add(this.GetAllIngredientsBtn);
            this.panel7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel7.Location = new System.Drawing.Point(3, 282);
            this.panel7.Name = "panel7";
            this.panel7.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel7.Size = new System.Drawing.Size(439, 146);
            this.panel7.TabIndex = 9;
            // 
            // GetAllIngredientsBtn
            // 
            this.GetAllIngredientsBtn.Dock = System.Windows.Forms.DockStyle.Left;
            this.GetAllIngredientsBtn.Location = new System.Drawing.Point(0, 0);
            this.GetAllIngredientsBtn.Name = "GetAllIngredientsBtn";
            this.GetAllIngredientsBtn.Size = new System.Drawing.Size(100, 46);
            this.GetAllIngredientsBtn.TabIndex = 1;
            this.GetAllIngredientsBtn.Text = "Get All";
            this.GetAllIngredientsBtn.UseVisualStyleBackColor = true;
            this.GetAllIngredientsBtn.Click += new System.EventHandler(this.GetAllIngredientsBtn_Click);
            // 
            // tabOrders
            // 
            this.tabOrders.Controls.Add(this.tabControl8);
            this.tabOrders.Location = new System.Drawing.Point(4, 22);
            this.tabOrders.Name = "tabOrders";
            this.tabOrders.Size = new System.Drawing.Size(740, 469);
            this.tabOrders.TabIndex = 5;
            this.tabOrders.Text = "Orders";
            this.tabOrders.UseVisualStyleBackColor = true;
            // 
            // tabControl8
            // 
            this.tabControl8.Controls.Add(this.tabPage11);
            this.tabControl8.Controls.Add(this.tabPage12);
            this.tabControl8.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl8.Location = new System.Drawing.Point(0, 0);
            this.tabControl8.Name = "tabControl8";
            this.tabControl8.SelectedIndex = 0;
            this.tabControl8.Size = new System.Drawing.Size(740, 469);
            this.tabControl8.TabIndex = 3;
            // 
            // tabPage11
            // 
            this.tabPage11.Controls.Add(this.tableLayoutPanel1);
            this.tabPage11.Location = new System.Drawing.Point(4, 22);
            this.tabPage11.Name = "tabPage11";
            this.tabPage11.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage11.Size = new System.Drawing.Size(732, 443);
            this.tabPage11.TabIndex = 0;
            this.tabPage11.Text = "Orders";
            this.tabPage11.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 61.80556F));
            this.tableLayoutPanel1.Controls.Add(this.dataGridViewOrders, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.panel9, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 64.96519F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 35.0348F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(726, 437);
            this.tableLayoutPanel1.TabIndex = 10;
            // 
            // dataGridViewOrders
            // 
            this.dataGridViewOrders.AllowUserToResizeColumns = false;
            this.dataGridViewOrders.AllowUserToResizeRows = false;
            this.dataGridViewOrders.AutoGenerateColumns = false;
            this.dataGridViewOrders.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewOrders.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.OrderID,
            this.ByTerminal,
            this.Paid,
            this.Canceled,
            this.PickedUp,
            this.ShowOnScreen,
            this.HappyCustomer,
            this.Returned,
            this.dataGridViewCheckBoxColumn3,
            this.dataGridViewCheckBoxColumn5});
            this.dataGridViewOrders.DataSource = this.orderBindingSource;
            this.dataGridViewOrders.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridViewOrders.Location = new System.Drawing.Point(3, 3);
            this.dataGridViewOrders.MultiSelect = false;
            this.dataGridViewOrders.Name = "dataGridViewOrders";
            this.dataGridViewOrders.RowHeadersVisible = false;
            this.dataGridViewOrders.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridViewOrders.Size = new System.Drawing.Size(720, 277);
            this.dataGridViewOrders.TabIndex = 0;
            // 
            // OrderID
            // 
            this.OrderID.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.OrderID.DataPropertyName = "OrderID";
            this.OrderID.HeaderText = "OrderID";
            this.OrderID.Name = "OrderID";
            this.OrderID.ReadOnly = true;
            // 
            // ByTerminal
            // 
            this.ByTerminal.DataPropertyName = "ByTerminal";
            this.ByTerminal.HeaderText = "ByTerminal";
            this.ByTerminal.Name = "ByTerminal";
            this.ByTerminal.ReadOnly = true;
            // 
            // Paid
            // 
            this.Paid.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Paid.DataPropertyName = "Paid";
            this.Paid.HeaderText = "Paid";
            this.Paid.Name = "Paid";
            // 
            // Canceled
            // 
            this.Canceled.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Canceled.DataPropertyName = "Canceled";
            this.Canceled.HeaderText = "Canceled";
            this.Canceled.Name = "Canceled";
            // 
            // PickedUp
            // 
            this.PickedUp.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.PickedUp.DataPropertyName = "PickedUp";
            this.PickedUp.HeaderText = "PickedUp";
            this.PickedUp.Name = "PickedUp";
            // 
            // ShowOnScreen
            // 
            this.ShowOnScreen.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.ShowOnScreen.DataPropertyName = "ShowOnScreen";
            this.ShowOnScreen.HeaderText = "ShowOnScreen";
            this.ShowOnScreen.Name = "ShowOnScreen";
            // 
            // HappyCustomer
            // 
            this.HappyCustomer.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.HappyCustomer.DataPropertyName = "HappyCustomer";
            this.HappyCustomer.HeaderText = "HappyCustomer";
            this.HappyCustomer.Name = "HappyCustomer";
            // 
            // Returned
            // 
            this.Returned.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Returned.DataPropertyName = "Returned";
            this.Returned.HeaderText = "Returned";
            this.Returned.Name = "Returned";
            // 
            // dataGridViewCheckBoxColumn3
            // 
            this.dataGridViewCheckBoxColumn3.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.dataGridViewCheckBoxColumn3.DataPropertyName = "Activated";
            this.dataGridViewCheckBoxColumn3.HeaderText = "Activated";
            this.dataGridViewCheckBoxColumn3.Name = "dataGridViewCheckBoxColumn3";
            // 
            // dataGridViewCheckBoxColumn5
            // 
            this.dataGridViewCheckBoxColumn5.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.dataGridViewCheckBoxColumn5.DataPropertyName = "Visible";
            this.dataGridViewCheckBoxColumn5.HeaderText = "Visible";
            this.dataGridViewCheckBoxColumn5.Name = "dataGridViewCheckBoxColumn5";
            // 
            // orderBindingSource
            // 
            this.orderBindingSource.DataSource = typeof(TypeLib.Order);
            // 
            // panel9
            // 
            this.panel9.Controls.Add(this.GetAllOrdersBtn);
            this.panel9.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel9.Location = new System.Drawing.Point(3, 286);
            this.panel9.Name = "panel9";
            this.panel9.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel9.Size = new System.Drawing.Size(720, 148);
            this.panel9.TabIndex = 9;
            // 
            // GetAllOrdersBtn
            // 
            this.GetAllOrdersBtn.Dock = System.Windows.Forms.DockStyle.Left;
            this.GetAllOrdersBtn.Location = new System.Drawing.Point(0, 0);
            this.GetAllOrdersBtn.Name = "GetAllOrdersBtn";
            this.GetAllOrdersBtn.Size = new System.Drawing.Size(100, 48);
            this.GetAllOrdersBtn.TabIndex = 1;
            this.GetAllOrdersBtn.Text = "Get All";
            this.GetAllOrdersBtn.UseVisualStyleBackColor = true;
            this.GetAllOrdersBtn.Click += new System.EventHandler(this.GetAllOrdersBtn_Click);
            // 
            // tabPage12
            // 
            this.tabPage12.Controls.Add(this.tableLayoutPanel5);
            this.tabPage12.Location = new System.Drawing.Point(4, 22);
            this.tabPage12.Name = "tabPage12";
            this.tabPage12.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage12.Size = new System.Drawing.Size(732, 443);
            this.tabPage12.TabIndex = 1;
            this.tabPage12.Text = "ProductOrders";
            this.tabPage12.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel5
            // 
            this.tableLayoutPanel5.ColumnCount = 1;
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 61.80556F));
            this.tableLayoutPanel5.Controls.Add(this.dataGridViewPOrders, 0, 0);
            this.tableLayoutPanel5.Controls.Add(this.panel8, 0, 1);
            this.tableLayoutPanel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel5.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel5.Name = "tableLayoutPanel5";
            this.tableLayoutPanel5.RowCount = 2;
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 64.96519F));
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 35.0348F));
            this.tableLayoutPanel5.Size = new System.Drawing.Size(726, 437);
            this.tableLayoutPanel5.TabIndex = 11;
            // 
            // dataGridViewPOrders
            // 
            this.dataGridViewPOrders.AllowUserToResizeColumns = false;
            this.dataGridViewPOrders.AllowUserToResizeRows = false;
            this.dataGridViewPOrders.AutoGenerateColumns = false;
            this.dataGridViewPOrders.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridViewPOrders.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ProductOrderID,
            this.ProductID,
            this.dataGridViewTextBoxColumn1,
            this.LockedByStation,
            this.Processed,
            this.dataGridViewCheckBoxColumn6,
            this.Visible,
            this.productOrderIDDataGridViewTextBoxColumn,
            this.productIDDataGridViewTextBoxColumn1,
            this.dataGridViewTextBoxColumn2,
            this.processedDataGridViewCheckBoxColumn,
            this.dataGridViewCheckBoxColumn7,
            this.dataGridViewCheckBoxColumn8});
            this.dataGridViewPOrders.DataSource = this.productOrderBindingSource1;
            this.dataGridViewPOrders.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridViewPOrders.Location = new System.Drawing.Point(3, 3);
            this.dataGridViewPOrders.MultiSelect = false;
            this.dataGridViewPOrders.Name = "dataGridViewPOrders";
            this.dataGridViewPOrders.RowHeadersVisible = false;
            this.dataGridViewPOrders.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridViewPOrders.Size = new System.Drawing.Size(720, 277);
            this.dataGridViewPOrders.TabIndex = 0;
            // 
            // ProductOrderID
            // 
            this.ProductOrderID.DataPropertyName = "ProductOrderID";
            this.ProductOrderID.HeaderText = "ProductOrderID";
            this.ProductOrderID.Name = "ProductOrderID";
            this.ProductOrderID.ReadOnly = true;
            // 
            // ProductID
            // 
            this.ProductID.DataPropertyName = "ProductID";
            this.ProductID.HeaderText = "ProductID";
            this.ProductID.Name = "ProductID";
            this.ProductID.ReadOnly = true;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.DataPropertyName = "OrderID";
            this.dataGridViewTextBoxColumn1.HeaderText = "OrderID";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            this.dataGridViewTextBoxColumn1.ReadOnly = true;
            // 
            // LockedByStation
            // 
            this.LockedByStation.DataPropertyName = "LockedByStation";
            this.LockedByStation.HeaderText = "LockedByStation";
            this.LockedByStation.Name = "LockedByStation";
            this.LockedByStation.ReadOnly = true;
            // 
            // Processed
            // 
            this.Processed.DataPropertyName = "Processed";
            this.Processed.HeaderText = "Processed";
            this.Processed.Name = "Processed";
            this.Processed.ReadOnly = true;
            // 
            // dataGridViewCheckBoxColumn6
            // 
            this.dataGridViewCheckBoxColumn6.DataPropertyName = "Activated";
            this.dataGridViewCheckBoxColumn6.HeaderText = "Activated";
            this.dataGridViewCheckBoxColumn6.Name = "dataGridViewCheckBoxColumn6";
            this.dataGridViewCheckBoxColumn6.ReadOnly = true;
            // 
            // Visible
            // 
            this.Visible.DataPropertyName = "Visible";
            this.Visible.HeaderText = "Visible";
            this.Visible.Name = "Visible";
            this.Visible.ReadOnly = true;
            // 
            // productOrderIDDataGridViewTextBoxColumn
            // 
            this.productOrderIDDataGridViewTextBoxColumn.DataPropertyName = "ProductOrderID";
            this.productOrderIDDataGridViewTextBoxColumn.HeaderText = "ProductOrderID";
            this.productOrderIDDataGridViewTextBoxColumn.Name = "productOrderIDDataGridViewTextBoxColumn";
            // 
            // productIDDataGridViewTextBoxColumn1
            // 
            this.productIDDataGridViewTextBoxColumn1.DataPropertyName = "ProductID";
            this.productIDDataGridViewTextBoxColumn1.HeaderText = "ProductID";
            this.productIDDataGridViewTextBoxColumn1.Name = "productIDDataGridViewTextBoxColumn1";
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.DataPropertyName = "OrderID";
            this.dataGridViewTextBoxColumn2.HeaderText = "OrderID";
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            // 
            // processedDataGridViewCheckBoxColumn
            // 
            this.processedDataGridViewCheckBoxColumn.DataPropertyName = "Processed";
            this.processedDataGridViewCheckBoxColumn.HeaderText = "Processed";
            this.processedDataGridViewCheckBoxColumn.Name = "processedDataGridViewCheckBoxColumn";
            // 
            // dataGridViewCheckBoxColumn7
            // 
            this.dataGridViewCheckBoxColumn7.DataPropertyName = "Activated";
            this.dataGridViewCheckBoxColumn7.HeaderText = "Activated";
            this.dataGridViewCheckBoxColumn7.Name = "dataGridViewCheckBoxColumn7";
            // 
            // dataGridViewCheckBoxColumn8
            // 
            this.dataGridViewCheckBoxColumn8.DataPropertyName = "Visible";
            this.dataGridViewCheckBoxColumn8.HeaderText = "Visible";
            this.dataGridViewCheckBoxColumn8.Name = "dataGridViewCheckBoxColumn8";
            // 
            // productOrderBindingSource1
            // 
            this.productOrderBindingSource1.DataSource = typeof(TypeLib.ProductOrder);
            // 
            // panel8
            // 
            this.panel8.Controls.Add(this.GetAllProductOrdersBtn);
            this.panel8.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel8.Location = new System.Drawing.Point(3, 286);
            this.panel8.Name = "panel8";
            this.panel8.Padding = new System.Windows.Forms.Padding(0, 0, 0, 100);
            this.panel8.Size = new System.Drawing.Size(720, 148);
            this.panel8.TabIndex = 9;
            // 
            // GetAllProductOrdersBtn
            // 
            this.GetAllProductOrdersBtn.Dock = System.Windows.Forms.DockStyle.Left;
            this.GetAllProductOrdersBtn.Location = new System.Drawing.Point(0, 0);
            this.GetAllProductOrdersBtn.Name = "GetAllProductOrdersBtn";
            this.GetAllProductOrdersBtn.Size = new System.Drawing.Size(100, 48);
            this.GetAllProductOrdersBtn.TabIndex = 1;
            this.GetAllProductOrdersBtn.Text = "Get All";
            this.GetAllProductOrdersBtn.UseVisualStyleBackColor = true;
            this.GetAllProductOrdersBtn.Click += new System.EventHandler(this.GetAllProductOrdersBtn_Click);
            // 
            // tabBuildings
            // 
            this.tabBuildings.Controls.Add(this.tabControl5);
            this.tabBuildings.Location = new System.Drawing.Point(4, 22);
            this.tabBuildings.Name = "tabBuildings";
            this.tabBuildings.Padding = new System.Windows.Forms.Padding(3);
            this.tabBuildings.Size = new System.Drawing.Size(740, 469);
            this.tabBuildings.TabIndex = 4;
            this.tabBuildings.Text = "Buildings";
            this.tabBuildings.UseVisualStyleBackColor = true;
            // 
            // tabControl5
            // 
            this.tabControl5.Controls.Add(this.tabPage1);
            this.tabControl5.Controls.Add(this.tabPage2);
            this.tabControl5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl5.Location = new System.Drawing.Point(3, 3);
            this.tabControl5.Name = "tabControl5";
            this.tabControl5.SelectedIndex = 0;
            this.tabControl5.Size = new System.Drawing.Size(734, 463);
            this.tabControl5.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(726, 437);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Edit Buildings";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.tabControl6);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(726, 437);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Edit Stations";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // tabControl6
            // 
            this.tabControl6.Controls.Add(this.tabPage5);
            this.tabControl6.Controls.Add(this.tabPage6);
            this.tabControl6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl6.Location = new System.Drawing.Point(3, 3);
            this.tabControl6.Name = "tabControl6";
            this.tabControl6.SelectedIndex = 0;
            this.tabControl6.Size = new System.Drawing.Size(720, 431);
            this.tabControl6.TabIndex = 0;
            // 
            // tabPage5
            // 
            this.tabPage5.Location = new System.Drawing.Point(4, 22);
            this.tabPage5.Name = "tabPage5";
            this.tabPage5.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage5.Size = new System.Drawing.Size(712, 405);
            this.tabPage5.TabIndex = 0;
            this.tabPage5.Text = "Stations";
            this.tabPage5.UseVisualStyleBackColor = true;
            // 
            // tabPage6
            // 
            this.tabPage6.Location = new System.Drawing.Point(4, 22);
            this.tabPage6.Name = "tabPage6";
            this.tabPage6.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage6.Size = new System.Drawing.Size(712, 405);
            this.tabPage6.TabIndex = 1;
            this.tabPage6.Text = "StationTypes";
            this.tabPage6.UseVisualStyleBackColor = true;
            // 
            // productOrderBindingSource
            // 
            this.productOrderBindingSource.DataSource = typeof(TypeLib.ProductOrder);
            // 
            // Admin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(984, 614);
            this.Controls.Add(this.splitContainer1);
            this.MinimumSize = new System.Drawing.Size(699, 398);
            this.Name = "Admin";
            this.Text = "G3Systems Administrator";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Admin_FormClosed);
            this.Load += new System.EventHandler(this.Admin_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel1.ResumeLayout(false);
            this.splitContainer4.Panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer4)).EndInit();
            this.splitContainer4.ResumeLayout(false);
            this.flowLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.PerformLayout();
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
            this.splitContainer2.ResumeLayout(false);
            this.splitContainer3.Panel1.ResumeLayout(false);
            this.splitContainer3.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).EndInit();
            this.splitContainer3.ResumeLayout(false);
            this.tabControl2.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.tabControl1.ResumeLayout(false);
            this.TabEmployees.ResumeLayout(false);
            this.tabControl3.ResumeLayout(false);
            this.tabEditEmployees.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewEmployees)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.employeeBindingSource)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel3.ResumeLayout(false);
            this.TabProducts.ResumeLayout(false);
            this.tabControl4.ResumeLayout(false);
            this.tabProducts2.ResumeLayout(false);
            this.tableLayoutPanel3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewProducts)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.productBindingSource)).EndInit();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.panel4.ResumeLayout(false);
            this.panel5.ResumeLayout(false);
            this.tabIngredients.ResumeLayout(false);
            this.tableLayoutPanel4.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewIngredients)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ingredientBindingSource)).EndInit();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.panel6.ResumeLayout(false);
            this.panel7.ResumeLayout(false);
            this.tabOrders.ResumeLayout(false);
            this.tabControl8.ResumeLayout(false);
            this.tabPage11.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewOrders)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.orderBindingSource)).EndInit();
            this.panel9.ResumeLayout(false);
            this.tabPage12.ResumeLayout(false);
            this.tableLayoutPanel5.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridViewPOrders)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.productOrderBindingSource1)).EndInit();
            this.panel8.ResumeLayout(false);
            this.tabBuildings.ResumeLayout(false);
            this.tabControl5.ResumeLayout(false);
            this.tabPage2.ResumeLayout(false);
            this.tabControl6.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.productOrdersBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.productOrderBindingSource)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.SplitContainer splitContainer1;
		private System.Windows.Forms.SplitContainer splitContainer2;
		private System.Windows.Forms.TabControl tabControl1;
		private System.Windows.Forms.TabPage TabEmployees;
		private System.Windows.Forms.TabPage TabProducts;
		private System.Windows.Forms.PictureBox pictureBox1;
		private System.Windows.Forms.Label usrnLabel;
		private System.Windows.Forms.SplitContainer splitContainer3;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.TabPage tabBuildings;
		private System.Windows.Forms.ListView listViewLoggedInEmployees;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TabControl tabControl2;
		private System.Windows.Forms.TabPage tabPage8;
		private System.Windows.Forms.Panel panel1;
		private System.Windows.Forms.SplitContainer splitContainer4;
		private System.Windows.Forms.Button LogoutButton;
		private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
		private System.Windows.Forms.DataGridViewTextBoxColumn employeeDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewTextBoxColumn usernameDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewTextBoxColumn passwordDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn loggedInDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn activatedDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn visibleDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewTextBoxColumn assignedToStationDataGridViewTextBoxColumn;
		private System.Windows.Forms.TabControl tabControl4;
		private System.Windows.Forms.TabPage tabProducts2;
		private System.Windows.Forms.TabPage tabIngredients;
		private System.Windows.Forms.TabControl tabControl5;
		private System.Windows.Forms.TabPage tabPage1;
		private System.Windows.Forms.TabPage tabPage2;
		private System.Windows.Forms.TabControl tabControl6;
		private System.Windows.Forms.TabPage tabPage5;
		private System.Windows.Forms.TabPage tabPage6;
		private System.Windows.Forms.TabPage tabOrders;
		private System.Windows.Forms.DataGridViewTextBoxColumn orderIdDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewTextBoxColumn byTerminalDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn activatedDataGridViewCheckBoxColumn1;
		private System.Windows.Forms.DataGridViewCheckBoxColumn visibleDataGridViewCheckBoxColumn1;
		private System.Windows.Forms.DataGridViewCheckBoxColumn paidDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn canceledDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn pickedUpDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn showOnScreenDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn pausedDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn happyCustomerDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn returnedDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn hasSpitDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn deliveredByCompanyDataGridViewCheckBoxColumn;
		private System.Windows.Forms.BindingSource productOrdersBindingSource;
		private System.Windows.Forms.DataGridViewTextBoxColumn productOrderDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewTextBoxColumn productDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewTextBoxColumn orderIdDataGridViewTextBoxColumn1;
		private System.Windows.Forms.DataGridViewTextBoxColumn lockedByStationDataGridViewTextBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn behandladDataGridViewCheckBoxColumn;
		private System.Windows.Forms.DataGridViewCheckBoxColumn activatedDataGridViewCheckBoxColumn2;
		private System.Windows.Forms.DataGridViewCheckBoxColumn visibleDataGridViewCheckBoxColumn2;
		private System.Windows.Forms.DataGridViewCheckBoxColumn betaldDataGridViewCheckBoxColumn;
        private System.Windows.Forms.TabControl tabControl3;
        private System.Windows.Forms.TabPage tabEditEmployees;
        private System.Windows.Forms.Button GetEmployeesBtn;
        private System.Windows.Forms.DataGridView dataGridViewEmployees;
        private System.Windows.Forms.BindingSource employeeBindingSource;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tbPassword;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tbUsername;
        private System.Windows.Forms.Button AddNewEmployeeBtn;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.CheckedListBox chkListBoxEmployeeType;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.DataGridView dataGridViewProducts;
        private System.Windows.Forms.BindingSource productBindingSource;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.CheckedListBox checkedListBox1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Panel panel5;
        private System.Windows.Forms.Button GetAllProductsBtn;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel4;
        private System.Windows.Forms.DataGridView dataGridViewIngredients;
        private System.Windows.Forms.DataGridViewTextBoxColumn IngredientID;
        private System.Windows.Forms.DataGridViewTextBoxColumn IngredientName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Price;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Activated;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn4;
        private System.Windows.Forms.BindingSource ingredientBindingSource;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.CheckedListBox checkedListBox2;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.TextBox textBox4;
        private System.Windows.Forms.Panel panel6;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Panel panel7;
        private System.Windows.Forms.Button GetAllIngredientsBtn;
        private System.Windows.Forms.DataGridViewTextBoxColumn productIDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn productTypeIDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn productNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn descriptionDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn prepTimeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn basePriceDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn1;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn2;
        private System.Windows.Forms.TabControl tabControl8;
        private System.Windows.Forms.TabPage tabPage11;
        private System.Windows.Forms.TabPage tabPage12;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.DataGridView dataGridViewOrders;
        private System.Windows.Forms.DataGridViewTextBoxColumn OrderID;
        private System.Windows.Forms.DataGridViewTextBoxColumn ByTerminal;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Paid;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Canceled;
        private System.Windows.Forms.DataGridViewCheckBoxColumn PickedUp;
        private System.Windows.Forms.DataGridViewCheckBoxColumn ShowOnScreen;
        private System.Windows.Forms.DataGridViewCheckBoxColumn HappyCustomer;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Returned;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn3;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn5;
        private System.Windows.Forms.BindingSource orderBindingSource;
        private System.Windows.Forms.Panel panel9;
        private System.Windows.Forms.Button GetAllOrdersBtn;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel5;
        private System.Windows.Forms.DataGridView dataGridViewPOrders;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductOrderID;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductID;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn LockedByStation;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Processed;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn6;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Visible;
        private System.Windows.Forms.BindingSource productOrderBindingSource1;
        private System.Windows.Forms.Panel panel8;
        private System.Windows.Forms.Button GetAllProductOrdersBtn;
        private System.Windows.Forms.BindingSource productOrderBindingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn productOrderIDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn productIDDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn4;
        private System.Windows.Forms.DataGridViewCheckBoxColumn processedDataGridViewCheckBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn7;
        private System.Windows.Forms.DataGridViewCheckBoxColumn dataGridViewCheckBoxColumn8;
        private System.Windows.Forms.Button DeleteEmployeeBtn;
        private System.Windows.Forms.DataGridViewTextBoxColumn employeeIDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn Username;
        private System.Windows.Forms.DataGridViewTextBoxColumn Password;
        private System.Windows.Forms.DataGridViewCheckBoxColumn Selected;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn3;
    }
}