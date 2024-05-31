using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RFIDSecure
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        SqlConnection connection = new SqlConnection(@"Data Source=DESKTOP-7HET2EC\SQLEXPRESS;Initial Catalog=RFID_Embedded;Integrated Security=True");

        private void button1_Click(object sender, EventArgs e) //Add user activity
        {
            if (isVaild())
            {
                SqlCommand command = new SqlCommand("INSERT INTO Users VALUES (@Rfid,@firstName, @lastName, @department,@contact, @address)", connection);
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@Rfid", txtId.Text);
                command.Parameters.AddWithValue("@firstName", txtFirstName.Text);
                command.Parameters.AddWithValue("@lastName", txtLastName.Text);
                command.Parameters.AddWithValue("@department", txtDepartment.Text);
                command.Parameters.AddWithValue("@contact", txtContact.Text);
                command.Parameters.AddWithValue("@address", txtAddress.Text);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

                GetUsers();
                ResetForm();
            }
        }

        private bool isVaild()
        {
            if (txtFirstName.Text == string.Empty)
            {
                MessageBox.Show("First Name is required", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }else if (txtAddress.Text == string.Empty)
            {
                MessageBox.Show("Address is required", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            else if (txtLastName.Text == string.Empty)
            {
                MessageBox.Show("Last Name is required", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            else if (txtId.Text == string.Empty)
            {
                MessageBox.Show("ID is required", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            else if (txtDepartment.Text == string.Empty)
            {
                MessageBox.Show("Department is required", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            else if (txtContact.Text == string.Empty)
            {
                MessageBox.Show("Contact is required", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }



            return true;
        }

        private void ResetForm()
        {
            txtLastName.Clear();
            txtId.Clear();
            txtFirstName.Clear();
            txtDepartment.Clear();
            txtContact.Clear();
            txtAddress.Clear();
        }


        private void Form2_Load(object sender, EventArgs e)
        {
            GetUsers();
        }

        private void GetUsers()
        {
            SqlCommand command = new SqlCommand("Select * from Users", connection);
            DataTable dataTable = new DataTable();
            connection.Open();

            SqlDataReader reader = command.ExecuteReader();
            dataTable.Load(reader);
            connection.Close();

            UsersGridView.DataSource = dataTable;
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            
            
        }
    }
}
