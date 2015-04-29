<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
	<xsl:template match="/">
        <xsl:variable name="dblp" select="/"/>
        
        <xsl:for-each select="distinct-values(dblp/*/author)">
            <xsl:result-document href="a-tree/{substring(.,1,1)}/{.}.html">
                <html>
                    <head>
                        <title>Publication of <xsl:value-of select="."/></title>
                    </head>
                    <body>
                        <xsl:call-template name="author_header"/>
                        <xsl:value-of select="$dblp/dblp/*[author = string(.)]"/>
                        
                        <!--<xsl:call-template name="author_publication">
                            <xsl:with-param name="publications" select="$dblp/*[author = .]"/>
                        </xsl:call-template>-->
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
        
        <!-- TODO e-tree for editors -->
	</xsl:template>

	<xsl:template name="author_header">
		<h1><xsl:value-of select="."/></h1>
	</xsl:template>

	<xsl:template name="author_publication">
        <xsl:param name="publications"/>
        <p>
            <xsl:value-of select="$publications"/>
            <!--<table border="1">
                <xsl:for-each select="$publications">
                    <tr>
                        <td><xsl:value-of select="//title"/></td>
                    </tr>
                </xsl:for-each>
            </table>-->
        </p>
	</xsl:template>
</xsl:stylesheet>
