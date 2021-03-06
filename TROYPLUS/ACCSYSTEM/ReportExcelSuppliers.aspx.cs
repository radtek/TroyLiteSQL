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
using System.IO;
using ClosedXML.Excel;

public partial class Suppliers : System.Web.UI.Page
{
    //DBClass objdb = new DBClass();
    BusinessLogic objBL = new BusinessLogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            objBL = new BusinessLogic(ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString());
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GridSpply_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                PresentationUtils.SetPagerButtonStates(GridSpply, e.Row, this);
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GridSpply_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GridSpply.PageIndex = e.NewPageIndex;

            BindGrid();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    private void BindGrid()
    {
        CreditLimitTotal = 0;
        OpenBalanceCRTotal = 0;
        string txtsearch =  txtSearch.Text;
        string dropdown = ddCriteria.SelectedValue;

        DataSet ds = new DataSet();
        ds = objBL.getSuppliers(txtsearch, dropdown);
        if (ds.Tables[0].Rows.Count > 0)
        {
            GridSpply.DataSource = ds;
            GridSpply.DataBind();

            var lblCredits = GridSpply.FooterRow.FindControl("lblCredit") as Label;
            if (lblCredits != null)
            {
                lblCredits.Text = CreditLimitTotal.ToString();
            }

            var lblBalances = GridSpply.FooterRow.FindControl("OpenBal") as Label;
            if (lblBalances != null)
            {
                lblBalances.Text = OpenBalanceCRTotal.ToString();
            }
        }
    }

    protected void ddlPageSelector_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            GridSpply.PageIndex = ((DropDownList)sender).SelectedIndex;


            BindGrid();

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void btnData_Click(object sender, EventArgs e)
    {
        try
        {
            BindGrid();
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
            //decimal GtotalOpenDR = 0;
            //decimal GtotalOpenCR = 0;
            //decimal GtotalExecute = 0;
            decimal GtotalCreditlimit = 0;
            //int GtotalCreditdays = 0;
            DateTime date = Convert.ToDateTime("01-01-1900");
            //ds = objBL.getSuppliers();

            string txtsearch = txtSearch.Text;
            string dropdown = ddCriteria.SelectedValue;

            DataSet ds = new DataSet();
            ds = objBL.getSuppliers(txtsearch, dropdown);

            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataTable dt = new DataTable();
                DataTable dt = new DataTable("Suppliers");


                dt.Columns.Add(new DataColumn("LedgerName"));
                dt.Columns.Add(new DataColumn("AliasName"));
                dt.Columns.Add(new DataColumn("Address"));
                dt.Columns.Add(new DataColumn("Address2"));
                dt.Columns.Add(new DataColumn("Address3"));
                dt.Columns.Add(new DataColumn("TINnumber"));
                dt.Columns.Add(new DataColumn("CreditLimit"));
                //dt.Columns.Add(new DataColumn("OpenBalanceDR"));
                dt.Columns.Add(new DataColumn("OpenBal"));
                dt.Columns.Add(new DataColumn("Phone"));
                dt.Columns.Add(new DataColumn("LedgerCategory"));
                //dt.Columns.Add(new DataColumn("ExecutiveIncharge"));
                dt.Columns.Add(new DataColumn("Mobile"));
                dt.Columns.Add(new DataColumn("CreditDays"));
                dt.Columns.Add(new DataColumn("BranchCode"));
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    DataRow dr_final1 = dt.NewRow();
                    dr_final1["LedgerName"] = dr["LedgerName"];
                    dr_final1["AliasName"] = dr["AliasName"];
                    dr_final1["Address"] = dr["Address"];
                    dr_final1["Address2"] = dr["Address2"];
                    dr_final1["Address3"] = dr["Address3"];
                    dr_final1["TINnumber"] = dr["TINnumber"];
                    dr_final1["CreditLimit"] = dr["CreditLimit"];
                    //dr_final1["OpenBalanceDR"] = dr["OpenBalanceDR"];
                    dr_final1["OpenBal"] = dr["OpenBal"];
                    dr_final1["Phone"] = dr["Phone"];
                    dr_final1["LedgerCategory"] = dr["LedgerCategory"];
                    //dr_final1["ExecutiveIncharge"] = dr["ExecutiveIncharge"];
                    dr_final1["CreditDays"] = dr["CreditDays"];
                    dr_final1["BranchCode"] = dr["BranchCode"];
                    dt.Rows.Add(dr_final1);

                    //GtotalOpenDR = GtotalOpenDR + Convert.ToDecimal(dr["OpenBalanceDR"]);
                    //GtotalOpenCR = GtotalOpenCR + Convert.ToDecimal(dr["OpenBal"]);
                    //GtotalOpenDR = GtotalExecute + Convert.ToDecimal(dr["ExecutiveIncharge"]);
                    if (!DBNull.Value.Equals(dr["CreditLimit"]))
                    {
                        GtotalCreditlimit = GtotalCreditlimit + Convert.ToDecimal(dr["CreditLimit"]);
                    }

                    //if(!DBNull.Value.Equals(dr["CreditDays"]))
                    //{
                    //    GtotalCreditdays = GtotalCreditdays + Convert.ToInt32(dr["CreditDays"]);
                    //} 
                }
                DataRow dr_final2 = dt.NewRow();
                dr_final2["LedgerName"] = "";
                dr_final2["AliasName"] = "";
                dr_final2["Address"] = "";
                dr_final2["Address2"] = "";
                dr_final2["Address3"] = "";
                dr_final2["TINnumber"] = "Grand Total:";
                dr_final2["CreditLimit"] = Convert.ToDecimal(GtotalCreditlimit);
                //dr_final2["OpenBalanceDR"] = Convert.ToDecimal(GtotalOpenDR);
                //dr_final2["OpenBal"] = Convert.ToDecimal(GtotalOpenCR);
                dr_final2["OpenBal"] = "";
                dr_final2["Phone"] = "";
                dr_final2["LedgerCategory"] = "";
                //dr_final2["ExecutiveIncharge"] = "";
                dr_final2["CreditDays"] = "";
                dr_final2["BranchCode"] = "";
                dt.Rows.Add(dr_final2);
                ExportToExcel(dt);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Button), "MyScript", "alert('No Data Found');", true);
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    public void ExportToExcel(DataTable dt)
    {

        if (dt.Rows.Count > 0)
        {
            //string filename = "SuppliersDownloadExcel.xls";
            //System.IO.StringWriter tw = new System.IO.StringWriter();
            //System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            //DataGrid dgGrid = new DataGrid();
            //dgGrid.DataSource = dt;
            //dgGrid.DataBind();
            //dgGrid.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            //dgGrid.HeaderStyle.BackColor = System.Drawing.Color.LightSkyBlue;
            //dgGrid.HeaderStyle.BorderColor = System.Drawing.Color.RoyalBlue;
            //dgGrid.HeaderStyle.Font.Bold = true;
            ////Get the HTML for the control.
            //dgGrid.RenderControl(hw);
            ////Write the HTML back to the browser.
            //Response.ContentType = "application/vnd.ms-excel";
            //Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            //this.EnableViewState = false;
            //Response.Write(tw.ToString());
            //Response.End();

            using (XLWorkbook wb = new XLWorkbook())
            {
                string filename = "SuppliersDownloadExcel.xlsx";
                wb.Worksheets.Add(dt);
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=" + filename + "");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }

    decimal CreditLimitTotal;
    decimal OpenBalanceCRTotal;
    protected void GridSpply_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblCredit = e.Row.FindControl("lblCreditLimit") as Label;
                if (lblCredit == null)
                    if (lblCredit != null || !DBNull.Value.Equals("lblCreditLimit"))
                    {
                        CreditLimitTotal += decimal.Parse(lblCredit.Text);
                    }
                    else
                    {
                        CreditLimitTotal = 0;
                    }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblBalanceCR = e.Row.FindControl("lblBalance") as Label;
                if (lblBalanceCR != null)
                {
                    OpenBalanceCRTotal += decimal.Parse(lblBalanceCR.Text);
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
}
