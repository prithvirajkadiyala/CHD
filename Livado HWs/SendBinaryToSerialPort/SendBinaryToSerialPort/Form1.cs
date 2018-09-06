using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;

namespace SendBinaryToSerialPort
{
    public partial class Form1 : Form
    {
        private SerialPort sp = new SerialPort();
        string dataReceived;

        public Form1()
        {
            InitializeComponent();

            button1.Enabled = false;

            InitializeSerialPortComboBox();
        }

        private void InitializeSerialPortComboBox()
        {
            string[] portNames = SerialPort.GetPortNames();

            foreach(string portName in portNames)
            {
                comboBox1.Items.Add(portName);
            }

            if (comboBox1.Items.Count > 0)
            {
                comboBox1.SelectedValueChanged += ComboBox1_SelectedValueChanged;
            }

        }

        private void ComboBox1_SelectedValueChanged(object sender, EventArgs e)
        {
            if(!string.IsNullOrEmpty(comboBox1.Text) && textBox1.Text.Length > 0)
            {
                button1.Enabled = true;
            }
            else
            {
                button1.Enabled = false;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!sp.IsOpen)
                {
                    sp = new SerialPort(comboBox1.Text, int.Parse(textBox1.Text), Parity.None, 8, StopBits.One);

                    sp.Open();

                    if (sp.IsOpen)
                    {

                        sp.DataReceived += Sp_DataReceived;

                        MessageBox.Show("Serial port successfully open.");
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void Sp_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            SerialPort sp = (SerialPort)sender;

            System.Text.Encoding iso_8859_1 = System.Text.Encoding.GetEncoding("iso-8859-1");
            sp.Encoding = iso_8859_1;

            string s = sp.ReadExisting();

            byte[] receivedBytes = iso_8859_1.GetBytes(s);

            dataReceived = "";
            for(int i = 0; i < receivedBytes.Length; i++)
            {
                if(i == receivedBytes.Length-1)
                {
                    dataReceived += receivedBytes[i].ToString() + "\r\n";
                }
                else
                {
                    dataReceived += receivedBytes[i].ToString() + ", ";
                }
                
            }

            this.Invoke(new EventHandler(updateRichTextBox));
        }

        private void updateRichTextBox(object o, EventArgs e)
        {
            richTextBox1.AppendText(dataReceived);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(textBox2.Text))
            {
                MessageBox.Show("Binary value to send is required.");
                return;
            }

            if (sp == null)
            {
                MessageBox.Show("Serial port must be open.");
                return;
            }
            else
            {
                if(!sp.IsOpen)
                {
                    MessageBox.Show("Serial port must be open.");
                    return;
                }
            }

            try
            {
                int binaryValue = Convert.ToInt32(textBox2.Text, 2);

                Byte b = Convert.ToByte(textBox2.Text, 2);

                var byteArray = new byte[] { b };

                sp.Write(byteArray, 0, 1);
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(comboBox1.Text) && textBox1.Text.Length > 0)
            {
                button1.Enabled = true;
            }
            else
            {
                button1.Enabled = false;
            }
        }
    }
}
