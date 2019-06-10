using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace helth
{
    public partial class MainForm : Form
    {
        public MySqlConnection sqlConnection = new MySqlConnection();
        public MainForm()
        {
            InitializeComponent();
            Auth auth = new Auth(this);
            auth.Show();
        }
        public void UI_init()
        {
            Enabled = true;
            listBox1.SelectedIndex = 0;
            SqlPatients();
        }
        private void SqlPatients()
        {
            List<string[]> sqlData = new List<string[]>();
            string query = "SELECT * FROM patients";
            MySqlCommand sqlCommand = new MySqlCommand(query, sqlConnection);
            MySqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
            while (sqlDataReader.Read())
            {
                sqlData.Add(new string[7]);
                sqlData[sqlData.Count - 1][0] = sqlDataReader[0].ToString();
                sqlData[sqlData.Count - 1][1] = sqlDataReader[1].ToString();
                sqlData[sqlData.Count - 1][2] = sqlDataReader[2].ToString();
                sqlData[sqlData.Count - 1][3] = sqlDataReader[3].ToString();
                sqlData[sqlData.Count - 1][4] = DateTime.ParseExact(sqlDataReader[4].ToString(), "dd.MM.yyyy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture).ToString("dd.MM.yyyy");
                sqlData[sqlData.Count - 1][5] = sqlDataReader[5].ToString();
                sqlData[sqlData.Count - 1][6] = (sqlDataReader[6].ToString() == "True" ? "Мужской" : "Женский");
            }
            sqlDataReader.Close();
            dataGridView1.Rows.Clear();
            foreach (string[] sqlString in sqlData)
            {
                dataGridView1.Rows.Add(sqlString);
            }

        }
        private void SqlBenefitsDocs()
        {
            List<string[]> sqlData = new List<string[]>();
            string query = "SELECT * FROM benefits_docs";
            MySqlCommand sqlCommand = new MySqlCommand(query, sqlConnection);
            MySqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
            while (sqlDataReader.Read())
            {
                sqlData.Add(new string[5]);
                sqlData[sqlData.Count - 1][0] = sqlDataReader[0].ToString();
                sqlData[sqlData.Count - 1][1] = sqlDataReader[1].ToString();
                sqlData[sqlData.Count - 1][2] = sqlDataReader[2].ToString();
                sqlData[sqlData.Count - 1][3] = sqlDataReader[3].ToString();
                sqlData[sqlData.Count - 1][4] = DateTime.ParseExact(sqlDataReader[4].ToString(), "dd.MM.yyyy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture).ToString("dd.MM.yyyy");
            }
            sqlDataReader.Close();
            dataGridView2.Rows.Clear();
            foreach (string[] sqlString in sqlData)
            {
                dataGridView2.Rows.Add(sqlString);
            }

        }
        private void TabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (tabControl1.SelectedIndex)
            {
                case 0:
                    SqlPatients();
                    break;
                case 1:
                    SqlBenefitsDocs();
                    break;
                case 2:
                    break;
                case 3:
                    break;
                case 4:
                    break;
            }
        }

        private void Button7_Click(object sender, EventArgs e)
        {
            SqlBenefitsDocs();
        }

        private void Button8_Click(object sender, EventArgs e)
        {
            SqlPatients();
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (textBox1.Text != "" && textBox2.Text != "" && maskedTextBox1.Text != "" && textBox5.Text != "")
                {
                    string query = "INSERT INTO `patients` (`surname`, `name`, `patronymic`, `birthdate`, `insurance`, `gender`) VALUES('" 
                        + (textBox1.Text) + "', '" 
                        + (textBox2.Text) + "', '" 
                        + (textBox3.Text) + "', '" 
                        + DateTime.ParseExact(maskedTextBox1.Text, "dd,MM,yyyy", System.Globalization.CultureInfo.InvariantCulture).ToString("yyyy-MM-dd") + "', '" 
                        + (textBox5.Text) + "', " 
                        + listBox1.SelectedIndex + ")";
                    (new MySqlCommand(query, sqlConnection)).ExecuteScalar();
                }
                else
                {
                    label13.Text = "Не все обязательные поля заполнены!";
                }
            } catch
            {
                label13.Text = "Ошибка добавления записи!";
            }
            SqlPatients();
        }
    }
}
