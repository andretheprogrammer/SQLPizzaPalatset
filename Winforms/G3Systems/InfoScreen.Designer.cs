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
			this.ProcessPanel = new System.Windows.Forms.FlowLayoutPanel();
			this.ProcessingOrderText = new System.Windows.Forms.Label();
			this.finishedOrderPanel = new System.Windows.Forms.FlowLayoutPanel();
			this.FinishedOrderText = new System.Windows.Forms.Label();
			this.splitContainer2 = new System.Windows.Forms.SplitContainer();
			this.orderBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.lstbxFinished = new System.Windows.Forms.ListBox();
			this.lstbxProcessing = new System.Windows.Forms.ListBox();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
			this.splitContainer1.Panel1.SuspendLayout();
			this.splitContainer1.Panel2.SuspendLayout();
			this.splitContainer1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).BeginInit();
			this.splitContainer3.Panel1.SuspendLayout();
			this.splitContainer3.Panel2.SuspendLayout();
			this.splitContainer3.SuspendLayout();
			this.ProcessPanel.SuspendLayout();
			this.finishedOrderPanel.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
			this.splitContainer2.Panel1.SuspendLayout();
			this.splitContainer2.Panel2.SuspendLayout();
			this.splitContainer2.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.orderBindingSource)).BeginInit();
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
			this.splitContainer1.Panel1.Controls.Add(this.splitContainer3);
			// 
			// splitContainer1.Panel2
			// 
			this.splitContainer1.Panel2.Controls.Add(this.splitContainer2);
			this.splitContainer1.Size = new System.Drawing.Size(800, 450);
			this.splitContainer1.SplitterDistance = 80;
			this.splitContainer1.TabIndex = 0;
			// 
			// splitContainer3
			// 
			this.splitContainer3.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer3.Location = new System.Drawing.Point(0, 0);
			this.splitContainer3.Name = "splitContainer3";
			// 
			// splitContainer3.Panel1
			// 
			this.splitContainer3.Panel1.Controls.Add(this.ProcessPanel);
			// 
			// splitContainer3.Panel2
			// 
			this.splitContainer3.Panel2.Controls.Add(this.finishedOrderPanel);
			this.splitContainer3.Size = new System.Drawing.Size(800, 80);
			this.splitContainer3.SplitterDistance = 399;
			this.splitContainer3.TabIndex = 0;
			// 
			// ProcessPanel
			// 
			this.ProcessPanel.Controls.Add(this.ProcessingOrderText);
			this.ProcessPanel.Dock = System.Windows.Forms.DockStyle.Fill;
			this.ProcessPanel.Location = new System.Drawing.Point(0, 0);
			this.ProcessPanel.Name = "ProcessPanel";
			this.ProcessPanel.Size = new System.Drawing.Size(399, 80);
			this.ProcessPanel.TabIndex = 0;
			// 
			// ProcessingOrderText
			// 
			this.ProcessingOrderText.AutoSize = true;
			this.ProcessingOrderText.Font = new System.Drawing.Font("Consolas", 26.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.ProcessingOrderText.Location = new System.Drawing.Point(3, 0);
			this.ProcessingOrderText.Name = "ProcessingOrderText";
			this.ProcessingOrderText.Size = new System.Drawing.Size(341, 41);
			this.ProcessingOrderText.TabIndex = 0;
			this.ProcessingOrderText.Text = "Processing Orders";
			// 
			// finishedOrderPanel
			// 
			this.finishedOrderPanel.Controls.Add(this.FinishedOrderText);
			this.finishedOrderPanel.Dock = System.Windows.Forms.DockStyle.Fill;
			this.finishedOrderPanel.Location = new System.Drawing.Point(0, 0);
			this.finishedOrderPanel.Name = "finishedOrderPanel";
			this.finishedOrderPanel.Size = new System.Drawing.Size(397, 80);
			this.finishedOrderPanel.TabIndex = 0;
			// 
			// FinishedOrderText
			// 
			this.FinishedOrderText.AutoSize = true;
			this.FinishedOrderText.Font = new System.Drawing.Font("Consolas", 26.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.FinishedOrderText.Location = new System.Drawing.Point(3, 0);
			this.FinishedOrderText.Name = "FinishedOrderText";
			this.FinishedOrderText.Size = new System.Drawing.Size(303, 41);
			this.FinishedOrderText.TabIndex = 1;
			this.FinishedOrderText.Text = "Finished Orders";
			// 
			// splitContainer2
			// 
			this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer2.Location = new System.Drawing.Point(0, 0);
			this.splitContainer2.Name = "splitContainer2";
			// 
			// splitContainer2.Panel1
			// 
			this.splitContainer2.Panel1.Controls.Add(this.lstbxProcessing);
			// 
			// splitContainer2.Panel2
			// 
			this.splitContainer2.Panel2.Controls.Add(this.lstbxFinished);
			this.splitContainer2.Size = new System.Drawing.Size(800, 366);
			this.splitContainer2.SplitterDistance = 400;
			this.splitContainer2.TabIndex = 0;
			// 
			// orderBindingSource
			// 
			this.orderBindingSource.DataSource = typeof(TypeLib.Order);
			// 
			// lstbxFinished
			// 
			this.lstbxFinished.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lstbxFinished.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lstbxFinished.FormattingEnabled = true;
			this.lstbxFinished.ItemHeight = 31;
			this.lstbxFinished.Location = new System.Drawing.Point(0, 0);
			this.lstbxFinished.Name = "lstbxFinished";
			this.lstbxFinished.Size = new System.Drawing.Size(396, 366);
			this.lstbxFinished.TabIndex = 1;
			this.lstbxFinished.SelectedIndexChanged += new System.EventHandler(this.lstbxFinished_SelectedIndexChanged);
			// 
			// lstbxProcessing
			// 
			this.lstbxProcessing.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lstbxProcessing.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lstbxProcessing.FormattingEnabled = true;
			this.lstbxProcessing.ItemHeight = 31;
			this.lstbxProcessing.Location = new System.Drawing.Point(0, 0);
			this.lstbxProcessing.Name = "lstbxProcessing";
			this.lstbxProcessing.Size = new System.Drawing.Size(400, 366);
			this.lstbxProcessing.TabIndex = 0;
			// 
			// InfoScreen
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(800, 450);
			this.Controls.Add(this.splitContainer1);
			this.Name = "InfoScreen";
			this.Text = "InfoScreen";
			this.Load += new System.EventHandler(this.InfoScreen_Load_1);
			this.splitContainer1.Panel1.ResumeLayout(false);
			this.splitContainer1.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
			this.splitContainer1.ResumeLayout(false);
			this.splitContainer3.Panel1.ResumeLayout(false);
			this.splitContainer3.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).EndInit();
			this.splitContainer3.ResumeLayout(false);
			this.ProcessPanel.ResumeLayout(false);
			this.ProcessPanel.PerformLayout();
			this.finishedOrderPanel.ResumeLayout(false);
			this.finishedOrderPanel.PerformLayout();
			this.splitContainer2.Panel1.ResumeLayout(false);
			this.splitContainer2.Panel2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
			this.splitContainer2.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.orderBindingSource)).EndInit();
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.SplitContainer splitContainer1;
		private System.Windows.Forms.SplitContainer splitContainer3;
		private System.Windows.Forms.FlowLayoutPanel ProcessPanel;
		private System.Windows.Forms.Label ProcessingOrderText;
		private System.Windows.Forms.FlowLayoutPanel finishedOrderPanel;
		private System.Windows.Forms.Label FinishedOrderText;
		private System.Windows.Forms.SplitContainer splitContainer2;
		private System.Windows.Forms.ListBox lstbxFinished;
		private System.Windows.Forms.BindingSource orderBindingSource;
		private System.Windows.Forms.ListBox lstbxProcessing;
	}
}