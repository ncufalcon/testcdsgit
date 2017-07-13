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
            津貼扣款代號
          </th>
          <th >
            津貼扣款名稱
          </th>
          <th>
            加扣別
          </th>
          <th >
            金額
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="dView">
          <tr guid="{pGuid}">
            <td style="text-align:center;width:10%" >
              <xsl:value-of select="siItemCode"/>
            </td>
            <td style="text-align:left;width:10%" >
              <xsl:value-of select="siItemName"/>
            </td >
            <td style="text-align:center;width:10%" >
              <xsl:value-of select="siAddstr"/>
            </td >
            <td style="text-align:right;width:10%" >
              <xsl:value-of select="psaCost"/>
            </td>

          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
