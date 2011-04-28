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
                xmlns:mal="http://projectmallard.org/1.0/"
                xmlns:if="http://projectmallard.org/experimental/if/"
                xmlns:dyn="http://exslt.org/dynamic"
                xmlns:func="http://exslt.org/functions"
                xmlns:str="http://exslt.org/strings"
                exclude-result-prefixes="mal if dyn func str"
                extension-element-prefixes="func"
                version="1.0">

<!--!!==========================================================================
Mallard Conditionals
Support for run-time conditional processing.
:Revision:version="1.0" date="2011-04-28" status="review"

This stylesheet contains utilities for handling conditional processing
in Mallard documents.
-->


<!--@@==========================================================================
mal.if.env
The list of env strings.
:Revision:version="1.0" date="2011-04-28" status="review"

This parameter takes a space-separated list of strings for the #{if:env}
conditional processing function. The #{if:env} function will return #{true}
if its argument is in this list.
-->
<xsl:param name="mal.if.env" select="''"/>
<xsl:variable name="_mal.if.env" select="concat(' ', $mal.if.env, ' ')"/>


<!--**==========================================================================
mal.if.test
Test if a condition is true.
:Revision:version="1.0" date="2011-04-28" status="review"
$node: The element to check the condition for.
$test: The XPath expression to check.

This template tests whether the ${test} is true, evaluating it with
the Mallard conditional functions. The ${test} parameter is expected
to be a valid XPath expression. If not provided, it defaults to the
#{if:test} attribute of ${node}, or the non-namespaced #{test}
attribute if ${node} is a #{if:if} element.

If ${test} evaluates to #{true}, this template outputs the literal
string #{'true'}. Otherwise, it outputs nothing.
-->
<xsl:template name="mal.if.test">
  <xsl:param name="node" select="."/>
  <xsl:param name="test" select="$node/self::if:if/@test | $node[not(self::if:if)]/@if:test"/>
  <xsl:choose>
    <xsl:when test="string($test) = ''">
      <xsl:text>true</xsl:text>
    </xsl:when>
    <xsl:when test="dyn:evaluate($test)">
      <xsl:text>true</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<func:function name="if:env">
  <xsl:param name="env"/>
  <xsl:choose>
    <xsl:when test="contains($_mal.if.env, $env)">
      <func:result select="true()"/>
    </xsl:when>
    <xsl:otherwise>
      <func:result select="false()"/>
    </xsl:otherwise>
  </xsl:choose>
</func:function>

</xsl:stylesheet>
