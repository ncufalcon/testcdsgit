<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="no"/>

    <xsl:template match="/dList">

        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_List">
          <thead>
            <tr>
              <th nowrap="nowrap">操作</th>
              <th nowrap="nowrap">申報公司</th>
              <th nowrap="nowrap">公司名稱</th>
              <th nowrap="nowrap">統一編號</th>
              <th nowrap="nowrap">營業人名稱</th>
              <th nowrap="nowrap">負責人</th>
              <th nowrap="nowrap">電話號碼</th>
              <th nowrap="nowrap">營業地址</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="dView">
            <tr >
              <td align="center" nowrap="nowrap" class="font-normal"><a href="Javascript:void(0)" onclick="JsEven.Del(this)" guid="{comGuid}">刪除</a></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comName"/></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comAbbreviate"/></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comUniform"/></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comBusinessEntity"/></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comResponsible"/></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comTel"/></td>
              <td nowrap="nowrap" guid="{comGuid}" onclick="JsEven.View(this)" style="cursor:pointer"><xsl:value-of select="comAddress1"/></td>
            </tr>
            </xsl:for-each>
          </tbody>
        </table>

      <!-- overwidthblock -->
    </xsl:template>
</xsl:stylesheet>
