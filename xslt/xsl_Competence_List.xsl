<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="html" indent="no"/>

  <xsl:template match="/dList">

    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_List">
      <thead>
        <tr>
          <th width="80" nowrap="nowrap">操作</th>
          <th nowrap="nowrap" width="380">角色名稱</th>
          <th nowrap="nowrap">備註</th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="dView">
          <tr >
            <td align="center" nowrap="nowrap" class="font-normal">
              <a href="Javascript:void(0)" onclick="JsEven.Del(this)" guid="{cmClass}">刪除</a>
            </td>
            <td nowrap="nowrap" guid="{cmClass}" onclick="JsEven.View(this)" style="cursor:pointer">
              <xsl:value-of select="cmName"/>
            </td>
            <td nowrap="nowrap" guid="{cmClass}" onclick="JsEven.View(this)" style="cursor:pointer">
              <xsl:value-of select="cmDesc"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
    </xsl:template>
</xsl:stylesheet>
