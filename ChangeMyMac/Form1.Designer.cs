namespace ChangeMyMac
{
    partial class Form1 : Form
    {
        private TextBox macAddressTextBox;
        private ComboBox networkInterfaceComboBox;
        private Button randomizeButton;
        private Button updateMacButton;


        private void InitializeComponent()
        {
            macAddressTextBox = new TextBox();
            networkInterfaceComboBox = new ComboBox();
            randomizeButton = new Button();
            updateMacButton = new Button();
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            SuspendLayout();
            // 
            // macAddressTextBox
            // 
            macAddressTextBox.Location = new Point(174, 139);
            macAddressTextBox.Name = "macAddressTextBox";
            macAddressTextBox.Size = new Size(177, 23);
            macAddressTextBox.TabIndex = 0;
            // 
            // networkInterfaceComboBox
            // 
            networkInterfaceComboBox.Location = new Point(174, 81);
            networkInterfaceComboBox.Name = "networkInterfaceComboBox";
            networkInterfaceComboBox.Size = new Size(177, 23);
            networkInterfaceComboBox.TabIndex = 1;
            // 
            // randomizeButton
            // 
            randomizeButton.Location = new Point(62, 195);
            randomizeButton.Name = "randomizeButton";
            randomizeButton.Size = new Size(90, 30);
            randomizeButton.TabIndex = 2;
            randomizeButton.Text = "Random MAC";
            randomizeButton.Click += RandomizeButton_Click;
            // 
            // updateMacButton
            // 
            updateMacButton.Location = new Point(261, 195);
            updateMacButton.Name = "updateMacButton";
            updateMacButton.Size = new Size(90, 30);
            updateMacButton.TabIndex = 3;
            updateMacButton.Text = "Update MAC";
            updateMacButton.Click += UpdateMacButton_Click;
            // 
            // label1
            // 
            label1.AutoSize = false;
            label1.Font = new System.Drawing.Font("Segoe UI", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            label1.Location = new System.Drawing.Point(137, 24);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(178, 30);
            label1.TabIndex = 4;
            label1.Text = "Change My MAC";
            label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(62, 84);
            label2.Name = "label2";
            label2.Size = new Size(104, 15);
            label2.TabIndex = 5;
            label2.Text = "Network Interface:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(62, 147);
            label3.Name = "label3";
            label3.Size = new Size(109, 15);
            label3.TabIndex = 6;
            label3.Text = "New MAC Address:";
            // 
            // Form1
            // 
            ClientSize = new Size(444, 378);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(macAddressTextBox);
            Controls.Add(networkInterfaceComboBox);
            Controls.Add(randomizeButton);
            Controls.Add(updateMacButton);
            Name = "Form1";
            Text = "Change My MAC";
            ResumeLayout(false);
            PerformLayout();
        }

        private void InitializeUI()
        {
            // Populate the network interface ComboBox with available interfaces
            string[] interfaces = GetNetworkInterfaces();
            networkInterfaceComboBox.Items.AddRange(interfaces);

            if (interfaces.Length > 0)
            {
                networkInterfaceComboBox.SelectedIndex = 0;
            }
        }

        private Label label1;
        private Label label2;
        private Label label3;
    }

}