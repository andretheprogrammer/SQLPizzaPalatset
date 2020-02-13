namespace G3Systems
{
	partial class Cashier
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
			System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
			System.Windows.Forms.DataVisualization.Charting.Legend legend2 = new System.Windows.Forms.DataVisualization.Charting.Legend();
			System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Cashier));
			this.productOrdersBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.ordersBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
			this.ordersBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.yODataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.chart1 = new System.Windows.Forms.DataVisualization.Charting.Chart();
			this.yODataSet1BindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.orderBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.splitContainer7 = new System.Windows.Forms.SplitContainer();
			this.pictureBox4 = new System.Windows.Forms.PictureBox();
			this.splitContainer8 = new System.Windows.Forms.SplitContainer();
			this.lstbxC_Processing = new System.Windows.Forms.ListBox();
			this.lstbxC_Finished = new System.Windows.Forms.ListBox();
			this.splitContainer6 = new System.Windows.Forms.SplitContainer();
			this.btnRefresh = new System.Windows.Forms.Button();
			this.btnPickedUp = new System.Windows.Forms.Button();
			this.lblProcessing = new System.Windows.Forms.Label();
			this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
			this.lblFinished = new System.Windows.Forms.Label();
			this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
			this.lbl_username = new System.Windows.Forms.Label();
			this.btn_LogOut = new System.Windows.Forms.Button();
			((System.ComponentModel.ISupportInitialize)(this.productOrdersBindingSource)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource1)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.yODataSetBindingSource)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.chart1)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.yODataSet1BindingSource)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.orderBindingSource)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer7)).BeginInit();
			this.splitContainer7.Panel1.SuspendLayout();
			this.splitContainer7.Panel2.SuspendLayout();
			this.splitContainer7.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer8)).BeginInit();
			this.splitContainer8.Panel1.SuspendLayout();
			this.splitContainer8.Panel2.SuspendLayout();
			this.splitContainer8.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer6)).BeginInit();
			this.splitContainer6.Panel1.SuspendLayout();
			this.splitContainer6.Panel2.SuspendLayout();
			this.splitContainer6.SuspendLayout();
			this.tableLayoutPanel1.SuspendLayout();
			this.tableLayoutPanel2.SuspendLayout();
			this.SuspendLayout();
			// 
			// chart1
			// 
			chartArea2.Name = "ChartArea1";
			this.chart1.ChartAreas.Add(chartArea2);
			legend2.Name = "Legend1";
			this.chart1.Legends.Add(legend2);
			this.chart1.Location = new System.Drawing.Point(0, 0);
			this.chart1.Name = "chart1";
			series2.ChartArea = "ChartArea1";
			series2.Legend = "Legend1";
			series2.Name = "Series1";
			this.chart1.Series.Add(series2);
			this.chart1.Size = new System.Drawing.Size(300, 300);
			this.chart1.TabIndex = 0;
			this.chart1.Text = "chart1";
			// 
			// orderBindingSource
			// 
			this.orderBindingSource.DataSource = typeof(TypeLib.Order);
			// 
			// splitContainer7
			// 
			this.splitContainer7.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer7.Location = new System.Drawing.Point(0, 0);
			this.splitContainer7.Name = "splitContainer7";
			this.splitContainer7.Orientation = System.Windows.Forms.Orientation.Horizontal;
			// 
			// splitContainer7.Panel1
			// 
			this.splitContainer7.Panel1.BackColor = System.Drawing.SystemColors.ActiveCaption;
			this.splitContainer7.Panel1.Controls.Add(this.tableLayoutPanel2);
			this.splitContainer7.Panel1.Controls.Add(this.pictureBox4);
			// 
			// splitContainer7.Panel2
			// 
			this.splitContainer7.Panel2.Controls.Add(this.splitContainer8);
			this.splitContainer7.Size = new System.Drawing.Size(1146, 749);
			this.splitContainer7.SplitterDistance = 122;
			this.splitContainer7.TabIndex = 2;
			// 
			// pictureBox4
			// 
			this.pictureBox4.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox4.Image")));
			this.pictureBox4.Location = new System.Drawing.Point(-583, -230);
			this.pictureBox4.Name = "pictureBox4";
			this.pictureBox4.Size = new System.Drawing.Size(1160, 747);
			this.pictureBox4.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
			this.pictureBox4.TabIndex = 5;
			this.pictureBox4.TabStop = false;
			// 
			// splitContainer8
			// 
			this.splitContainer8.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer8.Location = new System.Drawing.Point(0, 0);
			this.splitContainer8.Name = "splitContainer8";
			this.splitContainer8.Orientation = System.Windows.Forms.Orientation.Horizontal;
			// 
			// splitContainer8.Panel1
			// 
			this.splitContainer8.Panel1.Controls.Add(this.tableLayoutPanel1);
			// 
			// splitContainer8.Panel2
			// 
			this.splitContainer8.Panel2.Controls.Add(this.splitContainer6);
			this.splitContainer8.Size = new System.Drawing.Size(1146, 623);
			this.splitContainer8.SplitterDistance = 508;
			this.splitContainer8.TabIndex = 0;
			// 
			// lstbxC_Processing
			// 
			this.lstbxC_Processing.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lstbxC_Processing.Enabled = false;
			this.lstbxC_Processing.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lstbxC_Processing.FormattingEnabled = true;
			this.lstbxC_Processing.ItemHeight = 31;
			this.lstbxC_Processing.Location = new System.Drawing.Point(3, 39);
			this.lstbxC_Processing.Name = "lstbxC_Processing";
			this.lstbxC_Processing.SelectionMode = System.Windows.Forms.SelectionMode.None;
			this.lstbxC_Processing.Size = new System.Drawing.Size(364, 466);
			this.lstbxC_Processing.TabIndex = 1;
			// 
			// lstbxC_Finished
			// 
			this.lstbxC_Finished.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lstbxC_Finished.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lstbxC_Finished.FormattingEnabled = true;
			this.lstbxC_Finished.ItemHeight = 31;
			this.lstbxC_Finished.Location = new System.Drawing.Point(373, 39);
			this.lstbxC_Finished.Name = "lstbxC_Finished";
			this.lstbxC_Finished.Size = new System.Drawing.Size(770, 466);
			this.lstbxC_Finished.TabIndex = 2;
			// 
			// splitContainer6
			// 
			this.splitContainer6.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer6.IsSplitterFixed = true;
			this.splitContainer6.Location = new System.Drawing.Point(0, 0);
			this.splitContainer6.Name = "splitContainer6";
			// 
			// splitContainer6.Panel1
			// 
			this.splitContainer6.Panel1.Controls.Add(this.btnRefresh);
			this.splitContainer6.Panel1.Padding = new System.Windows.Forms.Padding(20);
			// 
			// splitContainer6.Panel2
			// 
			this.splitContainer6.Panel2.Controls.Add(this.btnPickedUp);
			this.splitContainer6.Panel2.Padding = new System.Windows.Forms.Padding(20);
			this.splitContainer6.Size = new System.Drawing.Size(1146, 111);
			this.splitContainer6.SplitterDistance = 413;
			this.splitContainer6.TabIndex = 2;
			// 
			// btnRefresh
			// 
			this.btnRefresh.BackColor = System.Drawing.SystemColors.ActiveCaption;
			this.btnRefresh.Dock = System.Windows.Forms.DockStyle.Fill;
			this.btnRefresh.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.btnRefresh.Location = new System.Drawing.Point(20, 20);
			this.btnRefresh.Name = "btnRefresh";
			this.btnRefresh.Size = new System.Drawing.Size(373, 71);
			this.btnRefresh.TabIndex = 5;
			this.btnRefresh.Text = "Refresh";
			this.btnRefresh.UseVisualStyleBackColor = false;
			this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_click);
			// 
			// btnPickedUp
			// 
			this.btnPickedUp.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
			this.btnPickedUp.Dock = System.Windows.Forms.DockStyle.Fill;
			this.btnPickedUp.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.btnPickedUp.Location = new System.Drawing.Point(20, 20);
			this.btnPickedUp.Name = "btnPickedUp";
			this.btnPickedUp.Size = new System.Drawing.Size(689, 71);
			this.btnPickedUp.TabIndex = 0;
			this.btnPickedUp.Text = "Mark as Picked Up";
			this.btnPickedUp.UseVisualStyleBackColor = false;
			this.btnPickedUp.Click += new System.EventHandler(this.btnPickedUp_Click);
			// 
			// lblProcessing
			// 
			this.lblProcessing.AutoSize = true;
			this.lblProcessing.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblProcessing.Location = new System.Drawing.Point(3, 0);
			this.lblProcessing.Name = "lblProcessing";
			this.lblProcessing.Size = new System.Drawing.Size(168, 31);
			this.lblProcessing.TabIndex = 2;
			this.lblProcessing.Text = "Processing:";
			// 
			// tableLayoutPanel1
			// 
			this.tableLayoutPanel1.ColumnCount = 2;
			this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 32.28621F));
			this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 67.71379F));
			this.tableLayoutPanel1.Controls.Add(this.lblFinished, 1, 0);
			this.tableLayoutPanel1.Controls.Add(this.lstbxC_Finished, 1, 1);
			this.tableLayoutPanel1.Controls.Add(this.lblProcessing, 0, 0);
			this.tableLayoutPanel1.Controls.Add(this.lstbxC_Processing, 0, 1);
			this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
			this.tableLayoutPanel1.Name = "tableLayoutPanel1";
			this.tableLayoutPanel1.RowCount = 2;
			this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 7.129456F));
			this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 92.87054F));
			this.tableLayoutPanel1.Size = new System.Drawing.Size(1146, 508);
			this.tableLayoutPanel1.TabIndex = 3;
			// 
			// lblFinished
			// 
			this.lblFinished.AutoSize = true;
			this.lblFinished.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblFinished.Location = new System.Drawing.Point(373, 0);
			this.lblFinished.Name = "lblFinished";
			this.lblFinished.Size = new System.Drawing.Size(134, 31);
			this.lblFinished.TabIndex = 3;
			this.lblFinished.Text = "Finished:";
			// 
			// tableLayoutPanel2
			// 
			this.tableLayoutPanel2.ColumnCount = 1;
			this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
			this.tableLayoutPanel2.Controls.Add(this.btn_LogOut, 0, 1);
			this.tableLayoutPanel2.Controls.Add(this.lbl_username, 0, 0);
			this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Right;
			this.tableLayoutPanel2.Location = new System.Drawing.Point(946, 0);
			this.tableLayoutPanel2.Name = "tableLayoutPanel2";
			this.tableLayoutPanel2.RowCount = 2;
			this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
			this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
			this.tableLayoutPanel2.Size = new System.Drawing.Size(200, 122);
			this.tableLayoutPanel2.TabIndex = 7;
			// 
			// lbl_username
			// 
			this.lbl_username.AutoSize = true;
			this.lbl_username.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lbl_username.Enabled = false;
			this.lbl_username.Location = new System.Drawing.Point(3, 0);
			this.lbl_username.Name = "lbl_username";
			this.lbl_username.Size = new System.Drawing.Size(194, 61);
			this.lbl_username.TabIndex = 2;
			this.lbl_username.Text = "Sara OConnor In Olearys";
			this.lbl_username.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
			// 
			// btn_LogOut
			// 
			this.btn_LogOut.Dock = System.Windows.Forms.DockStyle.Top;
			this.btn_LogOut.Location = new System.Drawing.Point(3, 64);
			this.btn_LogOut.Name = "btn_LogOut";
			this.btn_LogOut.Size = new System.Drawing.Size(194, 29);
			this.btn_LogOut.TabIndex = 3;
			this.btn_LogOut.Text = "Log Out";
			this.btn_LogOut.UseVisualStyleBackColor = true;
			this.btn_LogOut.Click += new System.EventHandler(this.btn_LogOut_Click);
			// 
			// Cashier
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(1146, 749);
			this.Controls.Add(this.splitContainer7);
			this.Name = "Cashier";
			this.Text = "G3Systems - Cashier";
			this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Cashier_FormClosed);
			((System.ComponentModel.ISupportInitialize)(this.productOrdersBindingSource)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource1)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.yODataSetBindingSource)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.chart1)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.yODataSet1BindingSource)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.orderBindingSource)).EndInit();
			this.splitContainer7.Panel1.ResumeLayout(false);
			this.splitContainer7.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer7)).EndInit();
			this.splitContainer7.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).EndInit();
			this.splitContainer8.Panel1.ResumeLayout(false);
			this.splitContainer8.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer8)).EndInit();
			this.splitContainer8.ResumeLayout(false);
			this.splitContainer6.Panel1.ResumeLayout(false);
			this.splitContainer6.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer6)).EndInit();
			this.splitContainer6.ResumeLayout(false);
			this.tableLayoutPanel1.ResumeLayout(false);
			this.tableLayoutPanel1.PerformLayout();
			this.tableLayoutPanel2.ResumeLayout(false);
			this.tableLayoutPanel2.PerformLayout();
			this.ResumeLayout(false);

		}

		#endregion
		private System.Windows.Forms.DataVisualization.Charting.Chart chart1;
		private System.Windows.Forms.BindingSource yODataSet1BindingSource;
		private System.Windows.Forms.BindingSource ordersBindingSource;
		//private System.Windows.Forms.DataGridViewTextBoxColumn orderIdDataGridViewTextBoxColumn;
		//private System.Windows.Forms.DataGridViewTextBoxColumn byTerminalDataGridViewTextBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn activatedDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn visibleDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn paidDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn canceledDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn pickedUpDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn showOnScreenDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn pausedDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn happyCustomerDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn returnedDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn hasSpitDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn deliveredByCompanyDataGridViewCheckBoxColumn;
		private System.Windows.Forms.BindingSource productOrdersBindingSource;
		private System.Windows.Forms.BindingSource ordersBindingSource1;
		private System.Windows.Forms.BindingSource yODataSetBindingSource;
		//private System.Windows.Forms.DataGridViewTextBoxColumn productOrderDataGridViewTextBoxColumn;
		//private System.Windows.Forms.DataGridViewTextBoxColumn productDataGridViewTextBoxColumn;
		//private System.Windows.Forms.DataGridViewTextBoxColumn orderIdDataGridViewTextBoxColumn1;
		//private System.Windows.Forms.DataGridViewTextBoxColumn lockedByStationDataGridViewTextBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn behandladDataGridViewCheckBoxColumn;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn activatedDataGridViewCheckBoxColumn1;
		//private System.Windows.Forms.DataGridViewTextBoxColumn orderIdDataGridViewTextBoxColumn2;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn pickedUpDataGridViewCheckBoxColumn1;
		//private System.Windows.Forms.DataGridViewCheckBoxColumn showOnScreenDataGridViewCheckBoxColumn1;
        private System.Windows.Forms.BindingSource orderBindingSource;
		private System.Windows.Forms.SplitContainer splitContainer7;
		private System.Windows.Forms.PictureBox pictureBox4;
		private System.Windows.Forms.SplitContainer splitContainer8;
		private System.Windows.Forms.SplitContainer splitContainer6;
		private System.Windows.Forms.Button btnRefresh;
		private System.Windows.Forms.Button btnPickedUp;
		private System.Windows.Forms.ListBox lstbxC_Processing;
		private System.Windows.Forms.ListBox lstbxC_Finished;
		private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
		private System.Windows.Forms.Label lblFinished;
		private System.Windows.Forms.Label lblProcessing;
		private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
		private System.Windows.Forms.Button btn_LogOut;
		private System.Windows.Forms.Label lbl_username;
	}
}