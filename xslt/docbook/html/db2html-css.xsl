<?xml version='1.0' encoding='utf-8'?><!-- -*- indent-tabs-mode: nil -*- -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://www.gnome.org/~shaunm/xsldoc"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="doc"
                version="1.0">

<doc:title>CSS</doc:title>


<!-- == db2html.css ======================================================== -->

<template xmlns="http://www.gnome.org/~shaunm/xsldoc">
  <name>db2html.css</name>
</template>

<xsl:template name="db2html.css">
  <style>
    <xsl:call-template name="db2html.admon.css"/>
    <xsl:call-template name="db2html.autotoc.css"/>
    <xsl:call-template name="db2html.block.css"/>
    <xsl:call-template name="db2html.callout.css"/>
    <xsl:call-template name="db2html.cmdsynopsis.css"/>
    <xsl:call-template name="db2html.list.css"/>
    <xsl:call-template name="db2html.qanda.css"/>
    <xsl:call-template name="db2html.refentry.css"/>
    <xsl:call-template name="db2html.table.css"/>
    <xsl:call-template name="db2html.title.css"/>
    body {
      padding-top: 8px;
      padding-left: 8px;
      padding-right: 12px;
    }
    div {
      margin-top: 0em;  margin-bottom: 0em;
      padding-top: 0em; padding-bottom: 0em;
    }
    p {
      margin-top: 0em;  margin-bottom: 0em;
      padding-top: 0em; padding-bottom: 0em;
    }
    div + * { margin-top: 1em; }
    p   + * { margin-top: 1em; }
    p { text-align: justify; }
    <xsl:call-template name="db2html.css.custom"/>
  </style>
</xsl:template>

<xsl:template name="db2html.css.custom"/>

</xsl:stylesheet>
