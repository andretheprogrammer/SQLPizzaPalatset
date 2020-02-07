namespace G3Systems
{
	partial class InfoScreen
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
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.splitContainer3 = new System.Windows.Forms.SplitContainer();
            this.flowLayoutPanel3 = new System.Windows.Forms.FlowLayoutPanel();
            this.label1 = new System.Windows.Forms.Label();
            this.flowLayoutPanel4 = new System.Windows.Forms.FlowLayoutPanel();
            this.label2 = new System.Windows.Forms.Label();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.ProcessingOrderGridView = new System.Windows.Forms.DataGridView();
            this.ordersBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.g3SystemsDataSet = new G3Systems.G3SystemsDataSet();
            this.FinishedGridView = new System.Windows.Forms.DataGridView();
            this.ordersBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dataSet1 = new G3Systems.DataSet1();
            this.FinishedOrderTiming = new System.Windows.Forms.Timer(this.components);
            this.ordersTableAdapter = new G3Systems.DataSet1TableAdapters.OrdersTableAdapter();
            this.ordersTableAdapter1 = new G3Systems.G3SystemsDataSetTableAdapters.OrdersTableAdapter();
            this.dataSet1BindingSource = new System.Windows.Forms.BindingSource(this.components);
            //this.viewDatabaseinfoscrn = new G3Systems.ViewDatabaseinfoscrn();
            this.viewInfoScreenLeftColumnBindingSource = new System.Windows.Forms.BindingSource(this.components);
            //this.view_InfoScreenLeftColumnTableAdapter = new G3Systems.ViewDatabaseinfoscrnTableAdapters.View_InfoScreenLeftColumnTableAdapter();
            this.orderIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.viewReadyForPickupOrdersBindingSource = new System.Windows.Forms.BindingSource(this.components);
            //this.view_ReadyForPickupOrdersTableAdapter = new G3Systems.ViewDatabaseinfoscrnTableAdapters.View_ReadyForPickupOrdersTableAdapter();
            this.orderIDDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.button1 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).BeginInit();
            this.splitContainer3.Panel1.SuspendLayout();
            this.splitContainer3.Panel2.SuspendLayout();
            this.splitContainer3.SuspendLayout();
            this.flowLayoutPanel3.SuspendLayout();
            this.flowLayoutPanel4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ProcessingOrderGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.g3SystemsDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.FinishedGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1BindingSource)).BeginInit();
            //((System.ComponentModel.ISupportInitialize)(this.viewDatabaseinfoscrn)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.viewInfoScreenLeftColumnBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.viewReadyForPickupOrdersBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Margin = new System.Windows.Forms.Padding(4);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.splitContainer3);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.splitContainer2);
            this.splitContainer1.Size = new System.Drawing.Size(1067, 554);
            this.splitContainer1.SplitterDistance = 99;
            this.splitContainer1.SplitterWidth = 5;
            this.splitContainer1.TabIndex = 0;
            // 
            // splitContainer3
            // 
            this.splitContainer3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer3.Location = new System.Drawing.Point(0, 0);
            this.splitContainer3.Margin = new System.Windows.Forms.Padding(4);
            this.splitContainer3.Name = "splitContainer3";
            // 
            // splitContainer3.Panel1
            // 
            this.splitContainer3.Panel1.Controls.Add(this.flowLayoutPanel3);
            // 
            // splitContainer3.Panel2
            // 
            this.splitContainer3.Panel2.Controls.Add(this.flowLayoutPanel4);
            this.splitContainer3.Size = new System.Drawing.Size(1067, 99);
            this.splitContainer3.SplitterDistance = 533;
            this.splitContainer3.SplitterWidth = 5;
            this.splitContainer3.TabIndex = 0;
            // 
            // flowLayoutPanel3
            // 
            this.flowLayoutPanel3.Controls.Add(this.label1);
            this.flowLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel3.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanel3.Margin = new System.Windows.Forms.Padding(4);
            this.flowLayoutPanel3.Name = "flowLayoutPanel3";
            this.flowLayoutPanel3.Size = new System.Drawing.Size(533, 99);
            this.flowLayoutPanel3.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Consolas", 26.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(4, 0);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(430, 51);
            this.label1.TabIndex = 0;
            this.label1.Text = "Processing Orders";
            // 
            // flowLayoutPanel4
            // 
            this.flowLayoutPanel4.Controls.Add(this.label2);
            this.flowLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel4.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanel4.Margin = new System.Windows.Forms.Padding(4);
            this.flowLayoutPanel4.Name = "flowLayoutPanel4";
            this.flowLayoutPanel4.Size = new System.Drawing.Size(529, 99);
            this.flowLayoutPanel4.TabIndex = 0;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Consolas", 26.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(4, 0);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(382, 51);
            this.label2.TabIndex = 1;
            this.label2.Text = "Finished Orders";
            // 
            // splitContainer2
            // 
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(0, 0);
            this.splitContainer2.Margin = new System.Windows.Forms.Padding(4);
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.button1);
            this.splitContainer2.Panel1.Controls.Add(this.ProcessingOrderGridView);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.FinishedGridView);
            this.splitContainer2.Size = new System.Drawing.Size(1067, 450);
            this.splitContainer2.SplitterDistance = 534;
            this.splitContainer2.SplitterWidth = 5;
            this.splitContainer2.TabIndex = 0;
            // 
            // ProcessingOrderGridView
            // 
            this.ProcessingOrderGridView.AllowUserToAddRows = false;
            this.ProcessingOrderGridView.AllowUserToDeleteRows = false;
            this.ProcessingOrderGridView.AutoGenerateColumns = false;
            this.ProcessingOrderGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.ProcessingOrderGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.orderIDDataGridViewTextBoxColumn});
            this.ProcessingOrderGridView.DataSource = this.viewInfoScreenLeftColumnBindingSource;
            this.ProcessingOrderGridView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ProcessingOrderGridView.Location = new System.Drawing.Point(0, 0);
            this.ProcessingOrderGridView.Name = "ProcessingOrderGridView";
            this.ProcessingOrderGridView.ReadOnly = true;
            this.ProcessingOrderGridView.RowHeadersWidth = 51;
            this.ProcessingOrderGridView.RowTemplate.Height = 24;
            this.ProcessingOrderGridView.Size = new System.Drawing.Size(534, 450);
            this.ProcessingOrderGridView.TabIndex = 0;
            // 
            // ordersBindingSource1
            // 
            this.ordersBindingSource1.DataMember = "Orders";
            this.ordersBindingSource1.DataSource = this.g3SystemsDataSet;
            // 
            // g3SystemsDataSet
            // 
            this.g3SystemsDataSet.DataSetName = "G3SystemsDataSet";
            this.g3SystemsDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // FinishedGridView
            // 
            this.FinishedGridView.AllowUserToAddRows = false;
            this.FinishedGridView.AllowUserToDeleteRows = false;
            this.FinishedGridView.AutoGenerateColumns = false;
            this.FinishedGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.FinishedGridView.ColumnHeadersVisible = false;
            this.FinishedGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.orderIDDataGridViewTextBoxColumn1});
            this.FinishedGridView.DataSource = this.viewReadyForPickupOrdersBindingSource;
            this.FinishedGridView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.FinishedGridView.Location = new System.Drawing.Point(0, 0);
            this.FinishedGridView.Name = "FinishedGridView";
            this.FinishedGridView.ReadOnly = true;
            this.FinishedGridView.RowHeadersVisible = false;
            this.FinishedGridView.RowHeadersWidth = 51;
            this.FinishedGridView.RowTemplate.Height = 24;
            this.FinishedGridView.Size = new System.Drawing.Size(528, 450);
            this.FinishedGridView.TabIndex = 1;
            // 
            // ordersBindingSource
            // 
            this.ordersBindingSource.DataMember = "Orders";
            this.ordersBindingSource.DataSource = this.dataSet1;
            // 
            // dataSet1
            // 
            this.dataSet1.DataSetName = "DataSet1";
            this.dataSet1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // FinishedOrderTiming
            // 
            this.FinishedOrderTiming.Enabled = true;
            this.FinishedOrderTiming.Interval = 5000;
            this.FinishedOrderTiming.Tick += new System.EventHandler(this.FinishedOrderTiming_Tick);
            // 
            // ordersTableAdapter
            // 
            this.ordersTableAdapter.ClearBeforeFill = true;
            // 
            // ordersTableAdapter1
            // 
            this.ordersTableAdapter1.ClearBeforeFill = true;
            // 
            // dataSet1BindingSource
            // 
            this.dataSet1BindingSource.DataSource = this.dataSet1;
            this.dataSet1BindingSource.Position = 0;
            // 
            // viewDatabaseinfoscrn
            //// 
            //this.viewDatabaseinfoscrn.DataSetName = "ViewDatabaseinfoscrn";
            //this.viewDatabaseinfoscrn.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // viewInfoScreenLeftColumnBindingSource
            // 
            this.viewInfoScreenLeftColumnBindingSource.DataMember = "View_InfoScreenLeftColumn";
            //this.viewInfoScreenLeftColumnBindingSource.DataSource = this.viewDatabaseinfoscrn;
            // 
            // view_InfoScreenLeftColumnTableAdapter
            // 
            //this.view_InfoScreenLeftColumnTableAdapter.ClearBeforeFill = true;
            // 
            // orderIDDataGridViewTextBoxColumn
            // 
            this.orderIDDataGridViewTextBoxColumn.DataPropertyName = "OrderID";
            this.orderIDDataGridViewTextBoxColumn.HeaderText = "OrderID";
            this.orderIDDataGridViewTextBoxColumn.MinimumWidth = 6;
            this.orderIDDataGridViewTextBoxColumn.Name = "orderIDDataGridViewTextBoxColumn";
            this.orderIDDataGridViewTextBoxColumn.ReadOnly = true;
            this.orderIDDataGridViewTextBoxColumn.Width = 125;
            // 
            // viewReadyForPickupOrdersBindingSource
            // 
            this.viewReadyForPickupOrdersBindingSource.DataMember = "View_ReadyForPickupOrders";
            //this.viewReadyForPickupOrdersBindingSource.DataSource = this.viewDatabaseinfoscrn;
            // 
            // view_ReadyForPickupOrdersTableAdapter
            // 
            //this.view_ReadyForPickupOrdersTableAdapter.ClearBeforeFill = true;
            // 
            // orderIDDataGridViewTextBoxColumn1
            // 
            this.orderIDDataGridViewTextBoxColumn1.DataPropertyName = "OrderID";
            this.orderIDDataGridViewTextBoxColumn1.HeaderText = "OrderID";
            this.orderIDDataGridViewTextBoxColumn1.MinimumWidth = 6;
            this.orderIDDataGridViewTextBoxColumn1.Name = "orderIDDataGridViewTextBoxColumn1";
            this.orderIDDataGridViewTextBoxColumn1.ReadOnly = true;
            this.orderIDDataGridViewTextBoxColumn1.Width = 125;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(153, 93);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "button1";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // InfoScreen
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1067, 554);
            this.Controls.Add(this.splitContainer1);
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "InfoScreen";
            this.Text = "InfoScreen";
            this.Load += new System.EventHandler(this.InfoScreen_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.splitContainer3.Panel1.ResumeLayout(false);
            this.splitContainer3.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).EndInit();
            this.splitContainer3.ResumeLayout(false);
            this.flowLayoutPanel3.ResumeLayout(false);
            this.flowLayoutPanel3.PerformLayout();
            this.flowLayoutPanel4.ResumeLayout(false);
            this.flowLayoutPanel4.PerformLayout();
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
            this.splitContainer2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ProcessingOrderGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.g3SystemsDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.FinishedGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ordersBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataSet1BindingSource)).EndInit();
            //((System.ComponentModel.ISupportInitialize)(this.viewDatabaseinfoscrn)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.viewInfoScreenLeftColumnBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.viewReadyForPickupOrdersBindingSource)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.SplitContainer splitContainer1;
		private System.Windows.Forms.SplitContainer splitContainer3;
		private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel3;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel4;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.SplitContainer splitContainer2;
        private System.Windows.Forms.Timer FinishedOrderTiming;
        private DataSet1 dataSet1;
        private System.Windows.Forms.BindingSource ordersBindingSource;
        private DataSet1TableAdapters.OrdersTableAdapter ordersTableAdapter;
        private System.Windows.Forms.DataGridView FinishedGridView;
        private System.Windows.Forms.DataGridView ProcessingOrderGridView;
        private G3SystemsDataSet g3SystemsDataSet;
        private System.Windows.Forms.BindingSource ordersBindingSource1;
        private G3SystemsDataSetTableAdapters.OrdersTableAdapter ordersTableAdapter1;
        private System.Windows.Forms.BindingSource dataSet1BindingSource;
        //private ViewDatabaseinfoscrn viewDatabaseinfoscrn;
        private System.Windows.Forms.BindingSource viewInfoScreenLeftColumnBindingSource;
        //private ViewDatabaseinfoscrnTableAdapters.View_InfoScreenLeftColumnTableAdapter view_InfoScreenLeftColumnTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn orderIDDataGridViewTextBoxColumn;
        private System.Windows.Forms.BindingSource viewReadyForPickupOrdersBindingSource;
        //private ViewDatabaseinfoscrnTableAdapters.View_ReadyForPickupOrdersTableAdapter view_ReadyForPickupOrdersTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn orderIDDataGridViewTextBoxColumn1;
        private System.Windows.Forms.Button button1;
    }
}