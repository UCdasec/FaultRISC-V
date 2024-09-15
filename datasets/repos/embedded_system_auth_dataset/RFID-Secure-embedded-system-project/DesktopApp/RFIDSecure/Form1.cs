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
using System.IO.Ports;

namespace RFIDSecure
{
    public partial class Form1 : Form
    {

        char Out = 'X';
        string message;
        string RxId;
        int RFID_SIZE = 4;
        public Form1()
        {
            InitializeComponent();
        }

        SqlConnection connection = new SqlConnection(@"Data Source=DESKTOP-7HET2EC\SQLEXPRESS;Initial Catalog=RFID_Embedded;Integrated Security=True");

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            FormLogin fl = new FormLogin();
            fl.ShowDialog();
        }

        private void button1_Click(object sender, EventArgs e) // temp sumbit button
        {
            saveRecord();
        }

        private void saveRecord()
        {
            SqlCommand command = new SqlCommand("select * from Users where RFID = @id", connection);
            command.CommandType = CommandType.Text;
            Console.WriteLine(txtRx.Text);
            command.Parameters.AddWithValue("@id", Int32.Parse(RxId));
            

            try
            {
                connection.Open();

                using (SqlDataReader read = command.ExecuteReader())
                {
                    if (read.Read())
                    {
                        lblId.Text = (read["RFID"].ToString());
                        lblFirstName.Text = (read["FirstName"].ToString());
                        lblLastName.Text = (read["LastName"].ToString());
                        lblDepartment.Text = (read["Department"].ToString());
                        lblContact.Text = (read["Contact"].ToString());
                        lblAddress.Text = (read["Address"].ToString());
                        Out = 'K';
                    }
                    else
                    {
                        lblId.Text = RxId;
                        lblFirstName.Text = "Invaild User";
                        lblLastName.Text = "Invaild User";
                        lblDepartment.Text = "Invaild User";
                        lblContact.Text = "Invaild User";
                        lblAddress.Text = "Invaild User";
                        Out = 'X';
                    }
                }
            }
            finally
            {
                connection.Close();
            }

            SqlCommand command2 = new SqlCommand("INSERT INTO LogTable VALUES (@dateTime,@rfid,@firstName, @lastName, @department, @contact, @address)", connection);
            command2.CommandType = CommandType.Text;
            command2.Parameters.AddWithValue("@dateTime", DateTime.Now);
            command2.Parameters.AddWithValue("@rfid", lblId.Text);
            command2.Parameters.AddWithValue("@firstName", lblFirstName.Text);
            command2.Parameters.AddWithValue("@lastName", lblLastName.Text);
            command2.Parameters.AddWithValue("@department", lblDepartment.Text);
            command2.Parameters.AddWithValue("@contact", lblContact.Text);
            command2.Parameters.AddWithValue("@address", lblAddress.Text);

            connection.Open();
            command2.ExecuteNonQuery();
            connection.Close();

            GetRecords();

            SendData(Out);
        }

        private void GetRecords()
        {
            SqlCommand command = new SqlCommand("Select * from LogTable", connection);
            DataTable dataTable = new DataTable();
            connection.Open();

            SqlDataReader reader = command.ExecuteReader();
            dataTable.Load(reader);
            connection.Close();

            LogsGridView.DataSource = dataTable;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            GetRecords();
            openSerial();
        }

        private void SendData(char x)
        {
            //openSerial();

            if (serialPort1.IsOpen)
            {
                serialPort1.Write(Out.ToString());
              //  serialPort1.Close();
            }
        }

  

        private void serialPort1_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
           
                message = serialPort1.ReadExisting();
                this.Invoke(new EventHandler(showData));
              //  serialPort1.Close();
            

           
        }

        private void showData(object sender, EventArgs e)
        {
            txtRx.Text += message;
            Console.WriteLine(txtRx.Text.Length);
            if (txtRx.Text.Length == RFID_SIZE) // length shoud be RFID size ******
            {
                RxId =  txtRx.Text;
                saveRecord();
                RxId = null;
                txtRx.Clear();
            }
                

        }

        private void button4_Click(object sender, EventArgs e) // open
        {
            openSerial();
        }

        private void openSerial()
        {
            try
            {
                serialPort1.PortName = "COM8";
                serialPort1.BaudRate = 9600;
                serialPort1.DataBits = 8;
                serialPort1.StopBits = (StopBits)Enum.Parse(typeof(StopBits), "One");
                serialPort1.Parity = (Parity)Enum.Parse(typeof(Parity), "None");


                serialPort1.Open();
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
