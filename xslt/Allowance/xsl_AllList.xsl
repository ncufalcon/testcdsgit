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
            操作
          </th>
          <th >
            員工編號
          </th>
          <th>
            員工姓名
          </th>
          <th >
            津貼扣款代號
          </th>
          <th >
            津貼名稱
          </th>
          <th >
            加/扣別
          </th>
          <th>
            金額
          </th >
          <th>
            日期
          </th>

        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="dView">
          <tr guid="{paGuid}">
            <td style="width:5%" align="center" nowrap="nowrap" class="font-normal">
              <a href="Javascript:void(0)" guid="{paGuid}" onclick="JsEven.SelView(this)">刪除</a>
            </td>
            <td style="text-align:left;width:5%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="perNo"/>
            </td>
            <td style="text-align:left;width:5%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="perName"/>
            </td >
            <td style="text-align:left;width:5%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="siItemCode"/>
            </td >
            <td style="text-align:left;width:5%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="siItemName"/>
            </td>
            <td style="text-align:left;width:5%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="siAddChi"/>
            </td >
            <td style="text-align:left;width:4%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="paCost"/>
            </td>
            <td style="text-align:left;width:4%" onclick="JsEven.SelView(this)">
              <xsl:value-of select="paDate"/>
            </td>      
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
