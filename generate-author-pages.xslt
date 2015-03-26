<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:x="dblp-excerpt.xml">

  <xsl:template match="/">
      <html>
         <head>
            <title><xsl:value-of select="comment()[1]"/></title>
         </head>
         <body>
            <h1><xsl:value-of select="comment()[1]"/></h1>
            <h2>Books:</h2>
            <ol><xsl:apply-templates select="dblp/book"/></ol>
            <h2>Journal papers:</h2>
            <ol><xsl:apply-templates select="dblp/article"/></ol>
         </body>
      </html>
   </xsl:template>

   <xsl:template match="dblp/book">
      <li><xsl:apply-templates/></li>
   </xsl:template>

   <xsl:template match="dblp/article">
      <li><xsl:apply-templates/></li>
   </xsl:template>
</xsl:stylesheet>
