<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="dblp-excerpt.xml">

  <xsl:template match="x:author">
    <book>
      <xsl:apply-templates select="x:book"/>
    </book>
  </xsl:template>

  <xsl:template match="x:book">
    <dish name="{x:volume}"/>
  </xsl:template>
  </xsl:stylesheet>
