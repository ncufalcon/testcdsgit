<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="no"/>

  <xsl:template match="/dList">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_List">
      <thead>
        <tr>
          <th>
            員工編號
          </th>
          <th >
            姓名
          </th>
          <th>
            發薪日
          </th>
          <th >
            申報公司
          </th>
          <th >
            部門
          </th>
          <th>
            出勤天數
          </th >
          <th>
            出勤時數
          </th>
          <th>
            實付金額
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="dView">
          <tr guid="{pGuid}">
            <td style="text-align:center;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pPerNo"/>
            </td>
            <td style="text-align:left;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pPerName"/>
            </td >
            <td style="text-align:center;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="sr_SalaryDate"/>
            </td >
            <td style="text-align:left;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pPerCompanyName"/>
            </td>
            <td style="text-align:center;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pPerDep"/>
            </td >
            <td style="text-align:right;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pAttendanceDays"/>
            </td>
            <td style="text-align:right;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pAttendanceTimes"/>
            </td>
            <td style="text-align:right;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{pGuid}">
              <xsl:value-of select="pPay"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
