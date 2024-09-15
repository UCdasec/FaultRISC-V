using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RFIDSecure
{
    public partial class FormLogin : Form
    {
        public FormLogin()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (txtUsername.Text=="admin" && txtPassword.Text == "admin")
            {
                this.Hide();
                Form2 f2 = new Form2();
                f2.ShowDialog();
                
            }
            else
            {
                MessageBox.Show("Invaild username or password", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            
        }
    }
}
