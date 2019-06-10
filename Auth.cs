using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;


namespace helth
{
    public partial class Auth : Form
    {
        private readonly MainForm mainForm;
        public Auth(MainForm mainForm)
        {
            InitializeComponent();
            this.mainForm = mainForm;
        }


        private void Button1_Click(object sender, EventArgs e)
        {
            this.Enabled = false;
            mainForm.sqlConnection = new MySqlConnection(
                "Data Source="+textBox3.Text
                +";Database="+textBox4.Text
                +";User Id="+textBox1.Text
                +";Password="+textBox2.Text);
            try
            {
                mainForm.sqlConnection.Open();
            } catch
            {
                ;
            }
            if (mainForm.sqlConnection.State.ToString() == "Open")
            {
                mainForm.UI_init();
                this.Close();
            } else
            {
                this.Enabled = true;
                label5.Text = "Не удалось подключиться!";
            }
        }

        private void Auth_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (mainForm.sqlConnection.State.ToString() != "Open")
            {
                mainForm.Close();
            }
        }
    }
}
