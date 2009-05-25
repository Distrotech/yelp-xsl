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
                xmlns:mal="http://www.gnome.org/~shaunm/mallard"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<!--!!==========================================================================
Mallard to HTML - List Elements

REMARK: Describe this module
-->


<!--**==========================================================================
mal2html.list.css
Outputs CSS that controls the appearance of lists

REMARK: Describe this template
-->
<xsl:template name="mal2html.list.css">
<xsl:text>
div.list-contents { margin: 0; padding: 0; }
div.title-list { margin-bottom: 0.5em; }
ol.list, ul.list { margin: 0; padding: 0; }
li.item-list { margin-left: 1.44em; }

div.steps-contents {
  margin: 0;
  padding: 0.5em 1em 0.5em 1em;
  border-top: solid 2px;
  border-bottom: solid 2px;
  border-color: </xsl:text>
    <xsl:value-of select="$theme.color.blue_border"/><xsl:text>;
  background-color: </xsl:text>
    <xsl:value-of select="$theme.color.yellow_background"/><xsl:text>;
}
div.steps-contents div.steps-contents {
  padding: 0;
  border: none;
  background-color: none;
}
ol.steps, ul.steps { margin: 0; padding: 0; }
li.item-steps { margin-left: 1.44em; }

div.terms-contents { margin: 0; }
dt.item-next { margin-top: 0; }
dd.item-terms {
  margin-top: 0.2em;
  margin-left: 1.44em;
}

ul.tree {
  margin: 0; padding: 0;
  list-style-type: none;
}
li.item-tree { margin: 0; padding: 0; }
div.item-tree { margin: 0; padding: 0; }
ul.tree ul.tree {
  margin-left: 1.44em;
}
div.tree-lines ul.tree ul.tree {
  margin-left: 0.2em;
}
div.tree-lines ul.tree ul.tree ul.tree {
  margin-left: 1.44em;
}
</xsl:text>
</xsl:template>


<!-- = list = -->
<xsl:template mode="mal2html.block.mode" match="mal:list">
  <xsl:param name="first_child" select="not(preceding-sibling::*)"/>
  <xsl:variable name="el">
    <xsl:choose>
      <xsl:when test="not(@type) or (@type = 'none') or (@type = 'box')
                      or (@type = 'check') or (@type = 'circle') or (@type = 'diamond')
                      or (@type = 'disc') or (@type = 'hyphen') or (@type = 'square')">
        <xsl:text>ul</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>ol</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <div>
    <xsl:attribute name="class">
      <xsl:text>list</xsl:text>
      <xsl:if test="$first_child">
        <xsl:text> first-child</xsl:text>
      </xsl:if>
    </xsl:attribute>
    <xsl:apply-templates mode="mal2html.block.mode" select="mal:title"/>
    <div class="list-contents">
      <xsl:element name="{$el}" namespace="{$mal2html.namespace}">
        <xsl:attribute name="class">
          <xsl:text>list</xsl:text>
        </xsl:attribute>
        <xsl:if test="@type">
          <xsl:attribute name="style">
            <xsl:value-of select="concat('list-style-type:', @type)"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates mode="mal2html.list.list.mode" select="mal:item"/>
      </xsl:element>
    </div>
  </div>
</xsl:template>

<!-- = list/item = -->
<xsl:template mode="mal2html.list.list.mode" match="mal:item">
  <li>
    <xsl:attribute name="class">
      <xsl:text>item-list</xsl:text>
      <xsl:if test="not(preceding-sibling::mal:item)">
        <xsl:text> first-child</xsl:text>
      </xsl:if>
    </xsl:attribute>
    <xsl:for-each
     select="mal:*[
             ($mal2html.editor_mode or not(self::mal:comment)
             or processing-instruction('mal2html.show_comment'))]">
      <xsl:apply-templates mode="mal2html.block.mode" select=".">
        <xsl:with-param name="first_child" select="position() = 1"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </li>
</xsl:template>

<!-- = steps = -->
<xsl:template mode="mal2html.block.mode" match="mal:steps">
  <xsl:param name="first_child" select="not(preceding-sibling::*)"/>
  <div>
    <xsl:attribute name="class">
      <xsl:text>steps</xsl:text>
      <xsl:if test="$first_child">
        <xsl:text> first-child</xsl:text>
      </xsl:if>
    </xsl:attribute>
    <xsl:apply-templates mode="mal2html.block.mode" select="mal:title"/>
    <div class="steps-contents">
      <ol class="steps">
        <xsl:apply-templates mode="mal2html.list.steps.mode" select="mal:item"/>
      </ol>
    </div>
  </div>
</xsl:template>

<!-- = steps/item = -->
<xsl:template mode="mal2html.list.steps.mode" match="mal:item">
  <li>
    <xsl:attribute name="class">
      <xsl:text>item-steps</xsl:text>
      <xsl:if test="not(preceding-sibling::mal:item)">
        <xsl:text> first-child</xsl:text>
      </xsl:if>
    </xsl:attribute>
    <xsl:for-each
     select="mal:*[
             ($mal2html.editor_mode or not(self::mal:comment)
             or processing-instruction('mal2html.show_comment'))]">
      <xsl:apply-templates mode="mal2html.block.mode" select=".">
        <xsl:with-param name="first_child" select="position() = 1"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </li>
</xsl:template>

<!-- = terms = -->
<xsl:template mode="mal2html.block.mode" match="mal:terms">
  <xsl:param name="first_child" select="not(preceding-sibling::*)"/>
  <div>
    <xsl:attribute name="class">
      <xsl:text>terms</xsl:text>
      <xsl:if test="$first_child">
        <xsl:text> first-child</xsl:text>
      </xsl:if>
    </xsl:attribute>
    <xsl:apply-templates mode="mal2html.block.mode" select="mal:title"/>
    <div class="terms-contents">
      <dl class="terms">
        <xsl:apply-templates mode="mal2html.list.terms.mode" select="mal:item"/>
      </dl>
    </div>
  </div>
</xsl:template>

<!-- = list/item = -->
<xsl:template mode="mal2html.list.terms.mode" match="mal:item">
  <xsl:for-each select="mal:title">
    <dt>
      <xsl:attribute name="class">
        <xsl:text>item-terms</xsl:text>
        <xsl:if test="not(../preceding-sibling::mal:item)">
          <xsl:text> first-child</xsl:text>
        </xsl:if>
        <xsl:if test="preceding-sibling::mal:title">
          <xsl:text> item-next</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates mode="mal2html.inline.mode"/>
    </dt>
  </xsl:for-each>
  <dd class="item-terms">
    <xsl:for-each
     select="mal:*[not(self::mal:title)
             and ($mal2html.editor_mode or not(self::mal:comment)
             or processing-instruction('mal2html.show_comment'))]">
      <xsl:apply-templates mode="mal2html.block.mode" select=".">
        <xsl:with-param name="first_child" select="position() = 1"/>
      </xsl:apply-templates>
    </xsl:for-each>
  </dd>
</xsl:template>

<!-- = tree = -->
<xsl:template mode="mal2html.block.mode" match="mal:tree">
  <xsl:param name="first_child" select="not(preceding-sibling::*)"/>
  <xsl:variable name="lines" select="contains(concat(' ', @style, ' '), ' lines ')"/>
  <div>
    <xsl:attribute name="class">
      <xsl:text>tree</xsl:text>
      <xsl:if test="$lines">
        <xsl:text> tree-lines</xsl:text>
      </xsl:if>
      <!-- FIXME -->
      <xsl:if test="$first_child">
        <xsl:text> first-child</xsl:text>
      </xsl:if>
    </xsl:attribute>
    <ul class="tree">
      <xsl:apply-templates mode="mal2html.list.tree.mode" select="mal:item">
        <xsl:with-param name="lines" select="$lines"/>
      </xsl:apply-templates>
    </ul>
  </div>
</xsl:template>

<!-- = tree/item = -->
<xsl:template mode="mal2html.list.tree.mode" match="mal:item">
  <xsl:param name="lines" select="false()"/>
  <li class="item-tree">
    <div class="item-tree">
      <xsl:if test="$lines and not(parent::mal:list)">
        <xsl:choose>
          <xsl:when test="following-sibling::mal:item">
            <xsl:text>&#x251C; </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#x2514; </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:apply-templates mode="mal2html.inline.mode"
                           select="node()[not(self::mal:item)]"/>
    </div>
    <xsl:if test="mal:item">
      <ul class="tree">
        <xsl:apply-templates mode="mal2html.list.tree.mode" select="mal:item">
          <xsl:with-param name="lines" select="$lines"/>
        </xsl:apply-templates>
      </ul>
    </xsl:if>
  </li>
</xsl:template>

</xsl:stylesheet>
