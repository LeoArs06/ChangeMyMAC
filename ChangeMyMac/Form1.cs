using System;
using System.Windows.Forms;
using System.Linq;
using System.Net.NetworkInformation;
using System.Diagnostics;

namespace ChangeMyMac
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            InitializeUI();
        }

        private string[] GetNetworkInterfaces()
        {
            try
            {
                // Esegui il comando PowerShell per ottenere l'elenco delle interfacce di rete
                ProcessStartInfo psi = new ProcessStartInfo
                {
                    FileName = "powershell",
                    Arguments = "Get-NetAdapter | Select-Object -ExpandProperty Name",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true
                };

                using (Process process = new Process())
                {
                    process.StartInfo = psi;
                    process.Start();
                    string output = process.StandardOutput.ReadToEnd();
                    process.WaitForExit();

                    // Estrai i nomi delle interfacce dalla risposta
                    string[] interfaces = output.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);

                    return interfaces;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Errore durante il recupero delle interfacce di rete: {ex.Message}", "Errore", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return new string[0]; // Restituisce un array vuoto in caso di errore
            }
        }
        private string GenerateRandomMacAddress()
        {
            Random rand = new Random();
            byte[] macAddr = new byte[6];
            rand.NextBytes(macAddr);

            // Set first bit as "unicast" address
            macAddr[0] = (byte)(macAddr[0] & (byte)254);

            macAddr[0] = (byte)(macAddr[0] | (byte)2);

            return string.Join(":", macAddr.Select(b => b.ToString("X2")));
        }


        private void RandomizeButton_Click(object sender, EventArgs e)
        {
            string randomMac = GenerateRandomMacAddress();
            macAddressTextBox.Text = randomMac;
        }

        private void UpdateMacButton_Click(object sender, EventArgs e)
        {
            string selectedInterface = networkInterfaceComboBox.SelectedItem as string;
            string newMacAddress = macAddressTextBox.Text.Replace(":", "-");

            if (!string.IsNullOrEmpty(selectedInterface) && !string.IsNullOrEmpty(newMacAddress))
            {
                if (ChangeMacAddress(selectedInterface, newMacAddress) == 0)
                {
                    MessageBox.Show("MAC Address updated successfully", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Can't update current MAC Address", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {
                MessageBox.Show("Please select an interface and provide a valid MAC address.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private int ChangeMacAddress(string interfaceName, string newMacAddress)
        {
            if (string.IsNullOrEmpty(interfaceName) || string.IsNullOrEmpty(newMacAddress))
            {
                MessageBox.Show("Si prega di selezionare un'interfaccia e fornire un indirizzo MAC valido.", "Errore", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return 1;
            }

            newMacAddress = newMacAddress.Replace(":", "-");
            ProcessStartInfo psi = new ProcessStartInfo
            {
                FileName = "powershell",
                Arguments = $"-Command Set-NetAdapter -Name {interfaceName} -MacAddress {newMacAddress} -Confirm:$false",
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = true, // Utilizza ShellExecute per richiedere i privilegi di amministratore quando necessario
                CreateNoWindow = true
            };

            using (Process process = new Process())
            {
                process.StartInfo = psi;
                process.Start();
                process.WaitForExit();

                string output = process.StandardOutput.ReadToEnd();
                string error = process.StandardError.ReadToEnd();

                if (process.ExitCode == 0)
                {
                    MessageBox.Show("Indirizzo MAC aggiornato con successo", "Successo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return 0;
                }
                else
                {
                    MessageBox.Show($"Impossibile aggiornare l'indirizzo MAC corrente: {error}", "Errore", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return 1;
                }
            }
        }
    }
}
