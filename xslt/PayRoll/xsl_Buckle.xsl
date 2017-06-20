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
            債權人
          </th>
          <th >
            移轉比率
          </th>
          <th>
            債權金額
          </th>
          <th >
            手續費
          </th>
          <th >
            分配金額
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="dView">
          <tr guid="{psbGuid}">
            <td style="text-align:center;width:10%" >
              <xsl:value-of select="psbCreditor"/>
            </td>
            <td style="text-align:left;width:10%" >
              <xsl:value-of select="psbRatio"/>
            </td >
            <td style="text-align:center;width:10%">
              <xsl:value-of select="psbCreditorCost"/>
            </td >
            <td style="text-align:left;width:10%" >
              <xsl:value-of select="psbFee"/>
            </td>
            <td style="text-align:center;width:10%" >
              <xsl:value-of select="psbCost"/>
            </td >      
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
