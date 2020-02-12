namespace G3Systems
{
	partial class CustomerEnter
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CustomerEnter));
			this.NewOrderBtn = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
			this.SuspendLayout();
			// 
			// NewOrderBtn
			// 
			this.NewOrderBtn.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.NewOrderBtn.Font = new System.Drawing.Font("Consolas", 24F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.NewOrderBtn.Location = new System.Drawing.Point(0, 345);
			this.NewOrderBtn.Name = "NewOrderBtn";
			this.NewOrderBtn.Size = new System.Drawing.Size(800, 203);
			this.NewOrderBtn.TabIndex = 0;
			this.NewOrderBtn.Text = "Starta Beställning";
			this.NewOrderBtn.UseVisualStyleBackColor = true;
			this.NewOrderBtn.Click += new System.EventHandler(this.NewOrderBtn_Click);
			// 
			// label1
			// 
			this.label1.Anchor = System.Windows.Forms.AnchorStyles.Top;
			this.label1.AutoSize = true;
			this.label1.Font = new System.Drawing.Font("Consolas", 36F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.label1.Location = new System.Drawing.Point(57, 197);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(700, 56);
			this.label1.TabIndex = 1;
			this.label1.Text = "Välkommen till Tonys Pizza";
			// 
			// pictureBox1
			// 
			this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
			this.pictureBox1.Location = new System.Drawing.Point(0, 0);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.Size = new System.Drawing.Size(800, 548);
			this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
			this.pictureBox1.TabIndex = 8;
			this.pictureBox1.TabStop = false;
			// 
			// CustomerEnter
			// 
			this.AcceptButton = this.NewOrderBtn;
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.SteelBlue;
			this.ClientSize = new System.Drawing.Size(800, 548);
			this.ControlBox = false;
			this.Controls.Add(this.label1);
			this.Controls.Add(this.NewOrderBtn);
			this.Controls.Add(this.pictureBox1);
			this.ForeColor = System.Drawing.SystemColors.InfoText;
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MinimumSize = new System.Drawing.Size(16, 550);
			this.Name = "CustomerEnter";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "CustomerEnter";
			this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.CustomerEnter_FormClosed);
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Button NewOrderBtn;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.PictureBox pictureBox1;
	}
}