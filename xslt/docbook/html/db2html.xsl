<?xml version='1.0' encoding='UTF-8'?><!-- -*- indent-tabs-mode: nil -*- -->
<!--
This program is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
details.

You should have received a copy of the GNU Lesser General Public License
along with this program; see the file COPYING.LGPL.  If not, write to the
Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://www.gnome.org/~shaunm/xsldoc"
                xmlns:msg="http://www.gnome.org/~shaunm/gnome-doc-utils/l10n"
                xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="doc"
                version="1.0">
<xsl:import href="../../gettext/gettext.xsl"/>

<doc:title>DocBook to HTML conversion</doc:title>

<!-- Setting parameters for included stylesheets -->
<xsl:param name="db.chunk.extension" select="'.xhtml'" doc:private="true"/>

<xsl:include href="../common/db-chunk.xsl"   doc:summary="true"/>
<xsl:include href="../common/db-common.xsl"  doc:summary="true"/>
<xsl:include href="../common/db-label.xsl"   doc:summary="true"/>
<xsl:include href="../common/db-title.xsl"   doc:summary="true"/>
<xsl:include href="../common/db-xref.xsl"    doc:summary="true"/>

<xsl:include href="db2html-admon.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-autotoc.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-block.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-callout.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-classsynopsis.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-cmdsynopsis.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-css.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-division.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-ebnf.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-funcsynopsis.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-info.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-inline.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-media.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-list.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-qanda.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-refentry.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-suppressed.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-table.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-title.xsl"
             doc:summary="true"
             doc:include="true"/>
<xsl:include href="db2html-xref.xsl"
             doc:summary="true"
             doc:include="true"/>

<xsl:template match="*">
  <xsl:message>
    <xsl:text>Unmatched element: </xsl:text>
    <xsl:value-of select="local-name(.)"/>
  </xsl:message>
  <xsl:apply-templates select="node()"/>
</xsl:template>

<!-- == l10n.format.mode == -->

<xsl:template mode="l10n.format.mode" match="msg:i">
  <xsl:param name="node"/>
  <i>
    <xsl:apply-templates mode="l10n.format.mode">
      <xsl:with-param name="node" select="$node"/>
    </xsl:apply-templates>
  </i>
</xsl:template>

<xsl:template mode="l10n.format.mode" match="msg:b">
  <xsl:param name="node"/>
  <b>
    <xsl:apply-templates mode="l10n.format.mode">
      <xsl:with-param name="node" select="$node"/>
    </xsl:apply-templates>
  </b>
</xsl:template>

<xsl:template mode="l10n.format.mode" match="msg:tt">
  <xsl:param name="node"/>
  <tt>
    <xsl:apply-templates mode="l10n.format.mode">
      <xsl:with-param name="node" select="$node"/>
    </xsl:apply-templates>
  </tt>
</xsl:template>

</xsl:stylesheet>
