﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class ReportSalesSaleTax1 : System.Web.UI.Page
{
    private string sDataSource = string.Empty;
    private string Connection = string.Empty;
    BusinessLogic objBL = new BusinessLogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
            Connection = Request.Cookies["Company"].Value;
            if (!IsPostBack)
            {

                DataSet companyInfo = new DataSet();
                BusinessLogic bl = new BusinessLogic(sDataSource);
                if (Request.Cookies["Company"] != null)
                {
                    companyInfo = bl.getCompanyInfo(Request.Cookies["Company"].Value);

                    if (companyInfo != null)
                    {
                        if (companyInfo.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in companyInfo.Tables[0].Rows)
                            {
                                lblTNGST.Text = Convert.ToString(dr["TINno"]);
                                lblCompany.Text = Convert.ToString(dr["CompanyName"]);
                                lblPhone.Text = Convert.ToString(dr["Phone"]);
                                lblGSTno.Text = Convert.ToString(dr["GSTno"]);

                                lblAddress.Text = Convert.ToString(dr["Address"]);
                                lblCity.Text = Convert.ToString(dr["city"]);
                                lblPincode.Text = Convert.ToString(dr["Pincode"]);
                                lblState.Text = Convert.ToString(dr["state"]);

                            }
                        }
                    }
                    DataSet ds1 = bl.getImageInfo();
                    if (ds1 != null)
                    {
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                            {
                                Image1.ImageUrl = "App_Themes/NewTheme/images/" + ds1.Tables[0].Rows[i]["img_filename"];
                                Image1.Height = 95;
                                Image1.Width = 95;
                            }
                        }
                        else
                        {
                            Image1.Height = 95;
                            Image1.Width = 95;
                            Image1.ImageUrl = "App_Themes/NewTheme/images/TESTLogo.png";
                        }
                    }
                }
            }

            lblHeading.Text = "Sales Annexure Report";

            lblBillDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            //txtStartDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

            DateTime indianStd = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.Now, "India Standard Time");
            string dtaa = Convert.ToDateTime(indianStd).ToString("dd/MM/yyyy");
            // txtStartDate.Text = dtaa;

            //  lblHeadDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            //string sDataSource = Server.MapPath("App_Data\\Store0910.mdb");
            //string sDataSource = Server.MapPath(ConfigurationSettings.AppSettings["DataSource"].ToString());



            divPrint.Visible = true;
            divPr.Visible = true;
            DataSet dstt = new DataSet();


            string connection = Request.Cookies["Company"].Value;

            string branch = Convert.ToString(Request.QueryString["Branch"].ToString());
            DateTime startDate = Convert.ToDateTime(Request.QueryString["startdate"].ToString());
            DateTime endDate = Convert.ToDateTime(Request.QueryString["enddate"].ToString());

            condi = Request.QueryString["condi"].ToString();
            condi = Server.UrlDecode(condi);
            bindDataSales();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    public void bindDataSales()
    {
       // DateTime startDate, endDate;
        DataSet ds = new DataSet();
        DataSet dstt = new DataSet();
        string intTrans = "";
        double tot = 0;
        double tot1 = 0;
        string salesRet = "";
        string delNote = "";

        string condi = "";

        intTrans = "NO";
        salesRet = "NO";
        delNote = "NO";
        string connection = Request.Cookies["Company"].Value;

        string Branch = Convert.ToString(Request.QueryString["Branch"].ToString());
        DateTime startDate = Convert.ToDateTime(Request.QueryString["startdate"].ToString());
        DateTime endDate = Convert.ToDateTime(Request.QueryString["enddate"].ToString());

        condi = Request.QueryString["condi"].ToString();
        condi = Server.UrlDecode(condi);

        if (condi == "5%")
        {
            condi = " And tblSalesitems.vat = 5";
        }
        else if (condi == "14.5%")
        {
            condi = " And tblSalesitems.vat = 14.5";
        }
        if (condi == "All")
        {
            condi = "";
        }

      //  startDate = Convert.ToDateTime(txtStartDt.Text.Trim());
      //  endDate = Convert.ToDateTime(txtEndDt.Text.Trim());

      //  string Branch = DropDownList1.SelectedValue;

        objBL = new BusinessLogic(ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString());
        ds = objBL.SalesAnnuxere(startDate, endDate, salesRet, intTrans, delNote, condi, Branch);
        Double serialno = 1;

        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("SNo"));
                dt.Columns.Add(new DataColumn("Name of the buyer"));
                dt.Columns.Add(new DataColumn("Buyer Tin"));
                dt.Columns.Add(new DataColumn("Commodity Code"));
                dt.Columns.Add(new DataColumn("Invoice No"));
                dt.Columns.Add(new DataColumn("Invoice Date"));
                dt.Columns.Add(new DataColumn("Sales Value"));
                dt.Columns.Add(new DataColumn("Tax Rate"));
                dt.Columns.Add(new DataColumn("Vat CST Paid"));
                dt.Columns.Add(new DataColumn("Category"));
                dt.Columns.Add(new DataColumn("Branchcode"));

                DataRow dr_export1 = dt.NewRow();
                dt.Rows.Add(dr_export1);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    DataRow dr_export = dt.NewRow();
                    dr_export["SNo"] = serialno;
                    dr_export["Name of the buyer"] = dr["LinkName"];
                    dr_export["Buyer Tin"] = dr["Tinnumber"];
                    dr_export["Commodity Code"] = "";
                    dr_export["Invoice No"] = dr["BillNo"];
                    dr_export["Branchcode"] = dr["Branchcode"];

                    string aa = dr["BillDate"].ToString().ToUpper().Trim();
                    string dtaa = Convert.ToDateTime(aa).ToString("dd/MM/yyyy");
                    dr_export["Invoice Date"] = dtaa;

                    tot = tot + Convert.ToDouble(dr["NetRate"]);

                    tot1 = tot1 + Convert.ToDouble(dr["ActualVAT"]);

                    dr_export["Sales Value"] = dr["NetRate"];
                    dr_export["Tax Rate"] = dr["vat"];
                    dr_export["Vat CST Paid"] = dr["ActualVAT"];
                    dr_export["Category"] = "";
                    dt.Rows.Add(dr_export);

                    serialno = serialno + 1;
                }

                DataRow dr_export2 = dt.NewRow();
                dr_export2["SNo"] = "";
                dr_export2["Name of the buyer"] = "";
                dr_export2["Buyer Tin"] = "";
                dr_export2["Commodity Code"] = "";
                dr_export2["Invoice No"] = "";
                dr_export2["Invoice Date"] = "Total =";
                dr_export2["Sales Value"] =  tot;
                dr_export2["Tax Rate"] = "Total = " ;
                dr_export2["Vat CST Paid"] =   tot1;
                dr_export2["Category"] = "";
                dt.Rows.Add(dr_export2);

               
                  dstt.Tables.Add(dt);
             //   ExportToExcel(dt);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Button), "MyScript", "alert('No Data Found');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Button), "MyScript", "alert('No Data Found');", true);
        }
        ReportsBL.ReportClass rptStock = new ReportsBL.ReportClass();
        // DataSet ds = new DataSet(sDataSource);
        //  DataSet ds = rptStock.getCategory(sDataSource);
        Grdreport.Visible = true;
        Grdreport.DataSource = dstt;
        Grdreport.DataBind();
    }

    protected void btndet_Click(object sender, EventArgs e)
    {
        try
        {
            // div1.Visible = true;
            divPrint.Visible = false;
            divPr.Visible = false;

            //Response.Write("<script language='javascript'> window.open('StockReport.aspx' , 'window','height=700,width=1000,left=172,top=10,toolbar=yes,scrollbars=yes,resizable=yes');</script>");
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void btnxls_Click(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    public void ExportToExcel(DataTable dt)
    {


    }

    protected void btnReport_Click(object sender, EventArgs e)
    {
        try
        {
            divPrint.Visible = true;
            divPr.Visible = true;

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    string condi;
    string cond1;
    string cond2;
    string cond3;
    string cond4;
    string cond5;
    string cond6;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int colCount = e.Row.Cells.Count;

                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[9].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[10].HorizontalAlign = HorizontalAlign.Center;


            }

        }

        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {


            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {

            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
}