<?xml version='1.0' encoding='utf-8'?><!-- -*- indent-tabs-mode: nil -*- -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://www.gnome.org/~shaunm/xsldoc"
		exclude-result-prefixes="doc"
                version="1.0">

<xsl:variable name="l10n" select="document('l10n.xml')"/>
<xsl:key name="msgid" match="msg" use="msgid"/>

<doc:title>Gettext</doc:title>


<!-- == gettext ============================================================ -->

<template xmlns="http://www.gnome.org/~shaunm/xsldoc">
  <name>gettext</name>
  <FIXME/>
</template>

<xsl:template name="gettext">
  <xsl:param name="msgid"/>
  <xsl:param name="lang" select="ancestor-or-self::*[@lang][1]/@lang"/>

  <xsl:for-each select="$l10n">
    <xsl:variable name="msg" select="key('msgid', $msgid)"/>
      <!--
        FIXME!
        Language codes: en_US@Latn.UTF8
        We can ignore the encoding thing, so we have language, dialect, and charset.
        Sort by the following order, and fallback as needed:
        en_US@Latn en@Latn en_US en
      -->
    <xsl:choose>
      <xsl:when test="$msg/msgstr[@xml:lang = $lang]">
	<xsl:value-of select="$msg/msgstr[@xml:lang = $lang]"/>
      </xsl:when>
      <xsl:when test="$msg/msgstr[@xml:lang = 'C']">
	<xsl:value-of select="$msg/msgstr[@xml:lang = 'C']"/>
      </xsl:when>
      <xsl:when test="$msg/msgstr[not(@xml:lang)]">
	<xsl:value-of select="$msg/msgstr[not(@xml:lang)]"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:message>
	  <xsl:text>No translation available for string '</xsl:text>
	  <xsl:value-of select="$msgid"/>
	  <xsl:text>'.</xsl:text>
	</xsl:message>
	<xsl:value-of select="$msgid"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>


<!-- == ngettext =========================================================== -->

<template xmlns="http://www.gnome.org/~shaunm/xsldoc">
  <name>ngettext</name>
  <FIXME/>
</template>

<xsl:template name="ngettext">
  <xsl:param name="msgid"/>
  <xsl:param name="msgid_plural"/>
  <xsl:param name="num" select="1"/>
  <xsl:param name="lang" select="ancestor-or-self::*[@lang][1]/@lang"/>

  <xsl:call-template name="gettext">
    <xsl:with-param name="msgid">
      <xsl:choose>
	<xsl:when test="$num = 1">
	  <xsl:value-of select="$msgid"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$msgid_plural"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="lang" select="$lang"/>
  </xsl:call-template>
</xsl:template>

<!-- ======================================================================= -->


<!-- ======================================================================= -->

<xsl:template name="format.header.prefix.named" doc:private="true">
  <xsl:param name="header"/>
  <xsl:value-of select="concat($header, '&#160;&#160;')"/>
</xsl:template>

<xsl:template name="format.header.prefix.unnamed" doc:private="true">
  <xsl:param name="header"/>
  <xsl:value-of select="concat($header, '&#160;&#160;')"/>
</xsl:template>

<xsl:template name="format.header" doc:private="true">
  <xsl:param name="header"/>
  <xsl:param name="number"/>
  <xsl:choose>
    <xsl:when test="string-length($number) &gt; 0">
      <xsl:value-of select="concat($header, '&#x00A0;', $number)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$header"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- ======================================================================= -->

<xsl:template name="plural" doc:private="true">
  <xsl:param name="num" select="1"/>
  <xsl:param name="lang" select="$lang"/>

  <xsl:choose>
    <!-- cs -->
    <xsl:when test="$lang = 'cs'">
      <xsl:choose>
	<xsl:when test="($num mod 10 = 1) and ($num mod 100 != 11)">
	  <xsl:value-of select="0"/>
	</xsl:when>
	<xsl:when test="
		  ($num mod 10 &gt;= 2) and ($num mod 10 &lt;= 4) and
		  (($num mod 100 &lt; 10) or ($num mod 100 &gt;=20))
		  ">
	  <xsl:value-of select="1"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="2"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- ja -->
    <xsl:when test="$lang = 'ja'">
      <xsl:value-of select="0"/>
    </xsl:when>

    <!-- sr sr@Latn -->
    <xsl:when test="$lang = 'sr' or $lang = 'sr@Latn'">
      <xsl:choose>
	<xsl:when test="($num mod 10 = 1) and ($num mod 100 != 11)">
	  <xsl:value-of select="0"/>
	</xsl:when>
	<xsl:when test="
		  ($num mod 10 &gt;= 2) and ($num mod 10 &lt;= 4) and
		  (($num mod 100 &lt; 10) or ($num mod 100 &gt;=20))
		  ">
	  <xsl:value-of select="1"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="2"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- C -->
    <xsl:otherwise>
      <xsl:choose>
	<xsl:when test="$num = 1">
	  <xsl:value-of select="0"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="1"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
