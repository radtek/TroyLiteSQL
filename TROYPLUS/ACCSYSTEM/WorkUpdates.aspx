﻿<%@ Page Language="C#" MasterPageFile="~/PageMaster.master" AutoEventWireup="true"
    CodeFile="WorkUpdates.aspx.cs" Inherits="WorkUpdates" Title="Resource > Work Updates" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cplhTab" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplhControlPanel" runat="Server">
    <script language="javascript" type="text/javascript">
        function pageLoad() {
            //  get the behavior associated with the tab control
            var tabContainer = $find('ctl00_cplhControlPanel_tbMain');

            if (tabContainer != null) {
                //  get all of the tabs from the container
                var tabs = tabContainer.get_tabs();

                //  loop through each of the tabs and attach a handler to
                //  the tab header's mouseover event
                for (var i = 0; i < tabs.length; i++) {
                    var tab = tabs[i];

                    $addHandler(
                tab.get_headerTab(),
                'mouseover',
                Function.createDelegate(tab, function () {
                    tabContainer.set_activeTab(this);
                }
            ));
                }
            }
        }


    </script>

        <style id="Style1" runat="server">
        
        
        .fancy-green .ajax__tab_header
        {
	        background: url(App_Themes/NewTheme/Images/green_bg_Tab.gif) repeat-x;
	        cursor:pointer;
        }
        .fancy-green .ajax__tab_hover .ajax__tab_outer, .fancy-green .ajax__tab_active .ajax__tab_outer
        {
	        background: url(App_Themes/NewTheme/Images/green_left_Tab.gif) no-repeat left top;
        }
        .fancy-green .ajax__tab_hover .ajax__tab_inner, .fancy-green .ajax__tab_active .ajax__tab_inner
        {
	        background: url(App_Themes/NewTheme/Images/green_right_Tab.gif) no-repeat right top;
        }
        .fancy .ajax__tab_header
        {
	        font-size: 13px;
	        font-weight: bold;
	        color: #000;
	        font-family: sans-serif;
        }
        .fancy .ajax__tab_active .ajax__tab_outer, .fancy .ajax__tab_header .ajax__tab_outer, .fancy .ajax__tab_hover .ajax__tab_outer
        {
	        height: 46px;
        }
        .fancy .ajax__tab_active .ajax__tab_inner, .fancy .ajax__tab_header .ajax__tab_inner, .fancy .ajax__tab_hover .ajax__tab_inner
        {
	        height: 46px;
	        margin-left: 16px; /* offset the width of the left image */
        }
        .fancy .ajax__tab_active .ajax__tab_tab, .fancy .ajax__tab_hover .ajax__tab_tab, .fancy .ajax__tab_header .ajax__tab_tab
        {
	        margin: 16px 16px 0px 0px;
        }
        .fancy .ajax__tab_hover .ajax__tab_tab, .fancy .ajax__tab_active .ajax__tab_tab
        {
	        color: #fff;
        }
        .fancy .ajax__tab_body
        {
	        font-family: Arial;
	        font-size: 10pt;
	        border-top: 0;
	        border:1px solid #999999;
	        padding: 8px;
	        background-color: #ffffff;
        }
        
    </style>

    <asp:UpdatePanel ID="UpdatePanel16" runat="server" UpdateMode="Always">
        <ContentTemplate>
            
            <table style="width: 100%">
            <tr style="width: 100%">
            <td style="width: 100%">
                     <%--<div class="mainConHd">
                            <table cellspacing="0" cellpadding="0" border="0">
                                <tr style="text-align: center">
                                    <td>
                                        <span>Resource Work Updates</span>
                                    </td>
                                </tr>
                            </table>
                        </div>--%>
                        <%--<table class="mainConHd" style="width: 994px;">
                                <tr valign="middle">
                                    <td style="font-size: 20px;">
                                        Resource Work Updates
                                    </td>
                                </tr>
                            </table>--%>
                        <div class="mainConBody">
                            <div style="text-align: left">
                                <table style="width: 100.3%; margin: -3px 0px 0px 2px;" cellpadding="3" cellspacing="2" class="searchbg">
                                    <tr style=" vertical-align: middle">
                                        <td style="width: 2%;">
                                        
                                        </td>
                                        <td style="width: 32%; font-size: 22px; color: #000000;">
                                            Resource Work Updates
                                        </td>
                                        <td style="width: 15%">
                                            <div style="text-align: right;">
                                                <asp:Panel ID="pnlSearch" Visible="false" runat="server" Width="100px">
                                                    <asp:Button ID="lnkBtnAdd" runat="server" OnClick="lnkBtnAdd_Click" CssClass="ButtonAdd66"
                                                        EnableTheming="false" Width="80px" Text=""></asp:Button>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                        <%--<td style="width: 15%; color: #000080;" align="right">
                                            Executive Name
                                        </td>--%>
                                        <td style="width: 18%" align="left" class="Box1">
                                            <div style="width: 160px; font-family: 'Trebuchet MS';">
                                                <asp:DropDownList ID="drpsIncharge" TabIndex="4" Enabled="True" BackColor="#BBCAFB" CssClass="drpDownListMedium" AppendDataBoundItems="true" Width="155px" Height="23px" style="text-align:center;border:1px solid #BBCAFB "
                                                    runat="server" DataTextField="empFirstName"
                                                    DataValueField="empno">
                                                    <asp:ListItem Text="All Executives" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <td style="width: 7%; color: #000080;" align="right">
                                            Work ID
                                        </td>
                                        <td style="width: 20%" class="Box1">
                                            <asp:TextBox ID="txtSworkId" runat="server" SkinID="skinTxtBoxSearch"></asp:TextBox>
                                        </td>
                                        <td style="width: 22%" class="tblLeftNoPad">
                                            <asp:Button ID="btnSearch" runat="server" Text="" OnClick="btnSearch_Click"
                                                CssClass="ButtonSearch6" EnableTheming="false" />
                                        </td>
                                    </tr>
                                    <tr style="display: none">
                                        <td>
                                        </td>
                                        <td style="width: 25%" class="tblRight">
                                            Expected Work Start Date
                                        </td>
                                        <td style="width: 22%" class="cssTextBoxbgnew2">
                                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                MaxLength="10" />
                                            <script type="text/javascript" language="JavaScript">
                                                new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtStartDate') });</script>
                                        </td>
                                        <td style="width: 15%">
                                            Expected Work End Date
                                        </td>
                                        <td style="width: 22%" class="cssTextBoxbgnew2">
                                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="cssTextBox" Width="100px" MaxLength="10" />
                                            <script type="text/javascript" language="JavaScript">
                                                new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtEndDate') });</script>
                                        </td>
                                        <td style="width: 10%">
                                        </td>
                                    </tr>
                                    <tr style="display: none">
                                        <td>
                                        </td>
                                        <td style="width: 25%" class="tblRight">
                                            Creation Date
                                        </td>
                                        <td style="width: 22%" class="cssTextBoxbgnew2">
                                            <asp:TextBox ID="txtsCreationDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                MaxLength="10" />
                                            <script type="text/javascript" language="JavaScript">
                                                new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtsCreationDate') });</script>
                                        </td>
                                        <td style="width: 15%">
                                            Status
                                        </td>
                                        <td style="width: 22%">
                                            <div style="border-width: 1px; border-color: #bce1fe; border-style: solid; width: 130px;
                                                font-family: 'Trebuchet MS';">
                                                <asp:DropDownList ID="drpsStatus" CssClass="drpDownListMedium" runat="server" Width="100%"
                                                    AppendDataBoundItems="True">
                                                    <asp:ListItem Value="" style="background-color: #bce1fe">All Status</asp:ListItem>
                                                    <asp:ListItem Value="Open">Open</asp:ListItem>
                                                    <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                                                    <asp:ListItem Value="Closed">Closed</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <td style="width: 10%; text-align: left">
                                        </td>
                                    </tr>
                                    <tr style="display: none">
                                        <td align="left" colspan="4">
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtStartDate"
                                                ControlToValidate="txtEndDate" Display="None" ErrorMessage="Start Date Should Be Less Than the End Date"
                                                CssClass="lblFont" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date"></asp:CompareValidator>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    
            <asp:HiddenField ID="hdTse" runat="server" Value="0" />
            <div>
                <asp:Panel ID="Panel1" runat="server">
                    
                </asp:Panel>
                <input id="dummy" type="button" style="display: none" runat="server" />
                <input id="Button1" type="button" style="display: none" runat="server" />
                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                    CancelControlID="Button1" DynamicServicePath="" Enabled="True" PopupControlID="popUp"
                    TargetControlID="dummy">
                </cc1:ModalPopupExtender>
                <div style="text-align: left">
                    <asp:Panel runat="server" ID="popUp" Style="width: 60%; display: none">
                        <div id="contentPopUp">
                            <table class="tblLeft" cellpadding="0" cellspacing="0" style="border: 0px solid #5078B3;
                                background-color: #fff; color: #000;" width="100%">
                                <tr>
                                    <td>
                                        <div class="divArea">
                                            <table class="tblLeft" cellpadding="3" cellspacing="5" style="border: 1px solid #5078B3;"
                                                width="100%">
                                                <tr>
                                                    <td colspan="4">
                                                        <table class="headerPopUp" style="border: 1px solid #86b2d1" width="100%">
                                                            <tr>
                                                                <td>
                                                                    Work Details
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="text-align: left">
                                                            <cc1:TabContainer ID="tbMain" Visible="false" runat="server" Width="100%" CssClass="fancy fancy-green">
                                                                <cc1:TabPanel ID="tabInsRates" runat="server" HeaderText="Work Update">
                                                                    <ContentTemplate>
                                                                        <asp:Panel ID="pnsWMP2" runat="server" Visible="False">
                                                                            <table style="width: 800px;" align="center" cellpadding="1" cellspacing="2">
                                                                                <tr>
                                                                                    <td style="width: 20%" align="right" class="ControlLabel" dir="ltr">
                                                                                        Work Status
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlDrpBorder">
                                                                                         <asp:UpdatePanel ID="UpdatePanel21" runat="server" UpdateMode="Conditional">
                                                                                             <ContentTemplate>
                                                                                                <asp:DropDownList ID="drpWorkStatus" TabIndex="4" Enabled="True"  Width="100%" AppendDataBoundItems="true" CssClass="drpDownListMedium" BackColor = "#90c9fc"
                                                                                                    runat="server" DataTextField="empFirstName" OnSelectedIndexChanged="drpWorkStatus_SelectedIndexChanged" DataValueField="empno" style="border: 1px solid #90c9fc" height="26px" AutoPostBack="True">
                                                                                                    <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                                                                                    <asp:ListItem Text="On Process" Value="On Process"></asp:ListItem>
                                                                                                    <asp:ListItem Text="Resolved" Value="Resolved"></asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </ContentTemplate>
                                                                                        </asp:UpdatePanel>
                                                                                    </td>
                                                                                    <td align="right" class="ControlLabel" style="width: 15%;">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Text="*" runat="server"
                                                                                            ControlToValidate="txtActStartDate" ValidationGroup="Save" ErrorMessage="Actual Start Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        <asp:RangeValidator ID="rvASDate" runat="server" ValidationGroup="Save" ControlToValidate="txtActStartDate"
                                                                                            ErrorMessage="Actual Start Date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>
                                                                                        Actual Start Date
                                                                                    </td>
                                                                                    <td align="left" style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtActStartDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" />
                                                                                        <cc1:CalendarExtender ID="calActStartDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnActStartDate" PopupPosition="BottomLeft" TargetControlID="txtActStartDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="btnActStartDate" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        
                                                                                        <asp:Label runat="server" ID="lblheading" Text="Comments"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtResDet" runat="server" SkinID="skinTxtBox" Height="30px" TextMode="MultiLine"></asp:TextBox>
                                                                                    </td>
                                                                                    <td align="right" class="ControlLabel" style="width: 15%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Text="*" runat="server"
                                                                                            ControlToValidate="txtActEnddate" ValidationGroup="Save" ErrorMessage="Actual End Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToCompare="txtActStartDate"
                                                                                            ControlToValidate="txtActEnddate" Text="*" ErrorMessage="Start Date Should Be Less Than the End Date"
                                                                                            CssClass="lblFont" Operator="GreaterThanEqual" ValidationGroup="Save" SetFocusOnError="True"
                                                                                            Type="Date"></asp:CompareValidator>
                                                                                        <asp:RangeValidator ID="rvAEDate" runat="server" ValidationGroup="Save" ControlToValidate="txtActEnddate"
                                                                                            ErrorMessage="Actual End Date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>
                                                                                        Actual End Date
                                                                                    </td>
                                                                                    <td align="left" style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtActEnddate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" />
                                                                                        <cc1:CalendarExtender ID="CalActEnddate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnActEnddate" PopupPosition="BottomLeft" TargetControlID="txtActEnddate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="btnActEnddate" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </ContentTemplate>
                                                                </cc1:TabPanel>
                                                                <cc1:TabPanel ID="tabMaster" runat="server" HeaderText="Work Details">
                                                                    <ContentTemplate>
                                                                        <asp:Panel ID="pnsWCE" runat="server" Visible="False">
                                                                            <table style="width: 100%;" cellpadding="1" cellspacing="2">
                                                                                <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ValidationGroup="Save" ID="RequiredFieldValidator2" runat="server"
                                                                                            Text="Work ID is mandatory" ControlToValidate="txtWorkID"></asp:RequiredFieldValidator>
                                                                                        Work ID *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtWorkID" Width="158px" MaxLength="10" runat="server" CssClass="cssTextBox" Height="28px"
                                                                                            Enabled="False" />
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 25%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCDate"
                                                                                            ValidationGroup="Save" Text="Creation Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        Creation date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtCDate" Width="100px" MaxLength="10" Height="28px" runat="server" CssClass="cssTextBox" />
                                                                                        <cc1:CalendarExtender ID="calCDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnCDate" PopupPosition="BottomLeft" TargetControlID="txtCDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="btnCDate" ImageUrl="App_Themes/NewTheme/images/cal.gif" CausesValidation="false"
                                                                                            Width="20px" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 20%" class="ControlLabel" dir="ltr">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" InitialValue="0" runat="server"
                                                                                            ControlToValidate="drpIncharge" ValidationGroup="Save">Employee Name is mandatory</asp:RequiredFieldValidator>
                                                                                        Executive Name
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpIncharge" TabIndex="4" Enabled="True"  CssClass="drpDownListMedium" BackColor = "#90c9fc" AppendDataBoundItems="true"
                                                                                            runat="server" Width="100%" DataTextField="empFirstName" DataValueField="empno"  style="border: 1px solid #90c9fc" height="26px">
                                                                                            <asp:ListItem Text="Select Executive" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 25%;">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEWstartDate"
                                                                                            ValidationGroup="Save" Text="Expectd Work Start Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        Expected Start Date
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtEWstartDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" />
                                                                                        <cc1:CalendarExtender ID="CalEWstartDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnEWstartDate" PopupPosition="BottomLeft" TargetControlID="txtEWstartDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="btnEWstartDate" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        Work Details
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtWorkdet" runat="server" SkinID="skinTxtBox" Height="30px" TextMode="MultiLine"></asp:TextBox>
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 25%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEWEndDate"
                                                                                            ValidationGroup="Save" Text="Expectd Work End Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtEWstartDate"
                                                                                            ControlToValidate="txtEWEndDate" Display="None" ErrorMessage="Start Date Should Be Less Than the End Date"
                                                                                            CssClass="lblFont" Operator="GreaterThanEqual" ValidationGroup="Save" SetFocusOnError="True"
                                                                                            Type="Date"></asp:CompareValidator>
                                                                                        Expected End Date
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtEWEndDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" />
                                                                                        <cc1:CalendarExtender ID="CalEWEndDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnEWEndDate" PopupPosition="BottomLeft" TargetControlID="txtEWEndDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="btnEWEndDate" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </ContentTemplate>
                                                                </cc1:TabPanel>
                                                            </cc1:TabContainer>
                                                            <asp:Panel ID="pnsSave" runat="server" Visible="False">
                                                                <table style="width: 100%;" cellpadding="1" cellspacing="2">
                                                                    <tr>
                                                                        <td style="width: 25%;">
                                                                        </td>
                                                                        <td style="width: 25%;" align="right">
                                                                            <asp:Button ID="btnCancel" runat="server" CssClass="cancelbutton6" EnableTheming="false"
                                                                                SkinID="skinBtnCancel" OnClick="btnCancel_Click" Enabled="false" />
                                                                        </td>
                                                                        <td style="width: 25%;" align="left">
                                                                            <asp:Button ID="btnSave" ValidationGroup="Save" runat="server" CssClass="savebutton1231"
                                                                                EnableTheming="false" SkinID="skinBtnSave" Visible="false" OnClick="btnSave_Click" />
                                                                            <asp:Button ID="btnUpdate" runat="server" ValidationGroup="Save" CssClass="Updatebutton1231"
                                                                                EnableTheming="false" SkinID="skinBtnSave" OnClick="btnUpdate_Click" Enabled="false" />
                                                                        </td>
                                                                        <td style="width: 25%;">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                            <asp:ValidationSummary ID="valSum" DisplayMode="BulletList" ShowMessageBox="true"
                                                                ValidationGroup="Save" ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                                                                Font-Size="12" runat="server" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                </div>
                <table width="100%" style="margin: 0px 0px 0px 0px;">
                                <tr style="width: 100%">
                                    <td>

                <div class="alignCenter" style="margin: -2px 0px 0px 0px;">
                    <asp:GridView ID="GrdWME" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        Width="100.8%" AllowPaging="True" OnPageIndexChanging="GrdWME_PageIndexChanging" OnRowDataBound="GrdWME_RowDataBound"
                        OnRowCreated="GrdWME_RowCreated" DataKeyNames="Empno" CssClass="someClass" PageSize="7" EmptyDataText="No Work Mangement Details found."
                        OnSelectedIndexChanged="GrdWME_SelectedIndexChanged" OnRowDeleting="GrdWME_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="WorkId" HeaderText="Work ID"  HeaderStyle-BorderColor="Gray"/>
                            <asp:BoundField DataField="creationDate" HeaderText="Creation Date" DataFormatString="{0:dd/MM/yyyy}"  HeaderStyle-BorderColor="Gray"/>
                            <asp:BoundField DataField="ExpWrkStartDate" HeaderText="Excpected work Start Date" HeaderStyle-BorderColor="Gray"
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="ExpWrkEndDate" HeaderText="Expected work completed date" HeaderStyle-BorderColor="Gray"
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="empno" HeaderText="Emp No"  HeaderStyle-BorderColor="Gray"/>
                            <asp:BoundField DataField="WorkDetails" HeaderText="Work Details"  HeaderStyle-BorderColor="Gray" HeaderStyle-Width="220px" />
                            <asp:BoundField DataField="ActStartDate" HeaderText="Actual Start Date" DataFormatString="{0:dd/MM/yyyy}"  HeaderStyle-BorderColor="Gray"/>
                            <asp:BoundField DataField="ActEndDate" HeaderText="Actual Completed date" DataFormatString="{0:dd/MM/yyyy}"  HeaderStyle-BorderColor="Gray"/>
                            <asp:BoundField DataField="ResolutionDet" HeaderText="Resolution details"  HeaderStyle-BorderColor="Gray"/>
                            <asp:BoundField DataField="workstatus" HeaderText="Work Status" HeaderStyle-BorderColor="Gray" />
                            <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Edit" HeaderStyle-BorderColor="Gray"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEdit" runat="server" SkinID="edit" CommandName="Select" />
                                    <asp:ImageButton ID="btnEditDisabled" Enabled="false" SkinID="editDisable" runat="Server"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="35px" HeaderStyle-BorderColor="Gray">
                                <ItemTemplate>
                                    <cc1:ConfirmButtonExtender ID="CnrfmDel" TargetControlID="lnkB" ConfirmText="Are you sure to Delete this Work Management Entry?"
                                        runat="server">
                                    </cc1:ConfirmButtonExtender>
                                    <asp:ImageButton ID="lnkB" SkinID="delete" runat="Server" CommandName="Delete"></asp:ImageButton>
                                    <asp:ImageButton ID="lnkBDisabled" Enabled="false" SkinID="deleteDisable" runat="Server"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerTemplate>
                            <table style=" border-color:white">
                                <tr style=" border-color:white">
                                    <td style=" border-color:white">
                                        Goto Page
                                    </td>
                                    <td style=" border-color:white">
                                        <asp:DropDownList ID="ddlPageSelector" runat="server" AutoPostBack="true"   Width="65px" style="border:1px solid blue"
                                            OnSelectedIndexChanged="ddlPageSelector_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style=" border-color:white;Width:5px">
                                            
                                    </td>
                                    <td style=" border-color:white">
                                        <asp:Button Text="" CommandName="Page" CommandArgument="First" runat="server" CssClass="NewFirst" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnFirst" />
                                    </td>
                                    <td style=" border-color:white">
                                        <asp:Button Text="" CommandName="Page" CommandArgument="Prev" runat="server" CssClass="NewPrev" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnPrevious" />
                                    </td>
                                    <td style=" border-color:white">
                                        <asp:Button Text="" CommandName="Page" CommandArgument="Next" runat="server" CssClass="NewNext" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnNext" />
                                    </td>
                                    <td style=" border-color:white">
                                        <asp:Button Text="" CommandName="Page" CommandArgument="Last" runat="server" CssClass="NewLast" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnLast" />
                                    </td>
                                </tr>
                            </table>
                            
                            
                            
                            
                            
                            
                        </PagerTemplate>
                    </asp:GridView>
                </div>
                </td>
                </tr>
                </table>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" DisplayMode="BulletList" ShowMessageBox="true"
                ValidationGroup="Save" ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                Font-Size="12" runat="server" />
            </td>
            </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
