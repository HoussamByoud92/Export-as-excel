using ClosedXML.Excel;
using MySql.Data.MySqlClient;
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

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            LoadRoomsData();
        }

        private void LoadRoomsData()
        {
            string connectionString = "server=localhost;database=HotelManagementSystem;uid=root;pwd=;";
            string query = "SELECT * FROM rooms";

            try
            {
                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        MySqlDataAdapter dataAdapter = new MySqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        dataAdapter.Fill(dataTable);
                        dataGridView1.DataSource = dataTable;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred: {ex.Message}");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {

            using(SaveFileDialog file = new SaveFileDialog() { Filter=" Excel Workbook|*.xlsx" })
            {
                if (file.ShowDialog() == DialogResult.OK)
                {
                    try
                    {
                        string connectionString = "server=localhost;database=HotelManagementSystem;uid=root;pwd=;";
                        string query = "SELECT * FROM rooms";
                        DataTable dataTable = new DataTable();

                        try
                        {
                            using (MySqlConnection connection = new MySqlConnection(connectionString))
                            {
                                connection.Open();
                                using (MySqlCommand command = new MySqlCommand(query, connection))
                                {
                                    MySqlDataAdapter dataAdapter = new MySqlDataAdapter(command);
                                    dataAdapter.Fill(dataTable); 
                                    dataGridView1.DataSource = dataTable; 

                                    if (dataTable.Rows.Count == 0)
                                    {
                                        MessageBox.Show("No data found in the 'rooms' table.");
                                        return;
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show($"An error occurred while fetching data: {ex.Message}");
                            return;
                        }

                        try
                        {
                            using (XLWorkbook xwb = new XLWorkbook())
                            {
                                xwb.Worksheets.Add(dataTable, "Rooms");
                                string desktopPath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
                                string filePath = System.IO.Path.Combine(desktopPath, "RoomsData.xlsx");
                                xwb.SaveAs(filePath);

                                MessageBox.Show($"Data exported successfully to: {filePath}");
                            }
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show($"An error occurred while exporting to Excel: {ex.Message}");
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }


                }
            }
        }
    }
}
