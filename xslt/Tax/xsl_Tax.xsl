<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="no"/>

  <xsl:template match="/dList">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_List">
      <thead>
        <tr>
          <th>
            年度
          </th>          
          <th>
            員工編號
          </th>
          <th >
            姓名
          </th>
          <th >
            申報公司
          </th>
          <th >
            部門
          </th>
          <th>
            給付總額
          </th >
          <th>
            扣繳稅額
          </th>
          <th>
            給付淨額
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="dView">
          <tr guid="{iitGuid}">
            <td style="text-align:center;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitYyyy"/>
            </td>
            <td style="text-align:left;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitPerNo"/>
            </td >
            <td style="text-align:center;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitPerName"/>
            </td >
            <td style="text-align:left;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitComName"/>
            </td>
            <td style="text-align:center;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitPerDep"/>
            </td >
            <td style="text-align:right;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitPaySum"/>
            </td>
            <td style="text-align:right;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitPayTax"/>
            </td>
            <td style="text-align:right;width:10%; cursor:pointer" onclick="JsEven.view(this)" guid="{iitGuid}">
              <xsl:value-of select="iitPayAmount"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
