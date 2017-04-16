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
          <tr guid="{atGuid}">
            <td style="width:4%" align="center" nowrap="nowrap" class="font-normal">
              <a href="Javascript:void(0)" guid="{atGuid}" onclick="JsEven.DelTemp(this)">刪除</a>
            </td>
            <td style="text-align:left;width:4%" >
              <xsl:value-of select="atPerNo"/>
            </td>
            <td style="text-align:left;width:5%" >
              <xsl:value-of select="perName"/>
            </td >
            <td style="text-align:left;width:5%" >
              <xsl:value-of select="atItem"/>
            </td >
            <td style="text-align:left;width:7%" >
              <xsl:value-of select="siItemName"/>
            </td>
            <td style="text-align:center;width:5%">
              <xsl:value-of select="atCost"/>
            </td >
            <td style="text-align:center;width:6%">
              <xsl:value-of select="atDate"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
