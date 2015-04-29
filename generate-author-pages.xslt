<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="/">
        <xsl:for-each-group select="/dblp/*/author" group-by=".">
            <xsl:sort select="current-grouping-key()"/>
            <xsl:variable name="author" select="current-grouping-key()"/>

            <xsl:result-document href="a-tree/{substring($author,1,1)}/{$author}.html">
                <html>
                    <head>
                        <title>Publication of <xsl:value-of select="$author"/></title>
                    </head>
                    <body>
                        <xsl:call-template name="author_header"/>
                        <xsl:call-template name="author_publication"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each-group>

        <!-- TODO e-tree for editors -->
	</xsl:template>

	<xsl:template name="author_header">
        <xsl:variable name="author" select="current-grouping-key()"/>
		<h1><xsl:value-of select="$author"/></h1>
	</xsl:template>

	<xsl:template name="author_publication">
        <p>
            <table border="1">
                <xsl:variable name="nbPublications"
                    select="count(/dblp/*[author = current-grouping-key()])" />
                <xsl:for-each select="/dblp/*[author = current-grouping-key()]">
                    <xsl:sort select="year" order="descending" />

                    <xsl:if test="not(preceding-sibling/year = year)">
                        <tr><th colspan="3" bgcolor="#FFFFCC">
                            <xsl:value-of select="year"/></th>
                        </tr>
                    </xsl:if>

                    <xsl:call-template name="publication">
                        <xsl:with-param name="nbPublications"
                            select="$nbPublications" />
                    </xsl:call-template>
                </xsl:for-each>
            </table>
        </p>
	</xsl:template>
    
    <xsl:template name="publication">
        <xsl:param name="nbPublications"/>
        <xsl:variable name="position" select="$nbPublications - position() + 1"/>
        
        <tr>
            <td align="right" valign="top">
                <a name="p{$position}"/>
                <xsl:value-of select="$position"/>
            </td>
            <!-- TODO publication number -->
            <!-- TODO link to ee -->
            <td>
                <xsl:apply-templates select="author"/>
                <xsl:value-of select="title"/>
                <xsl:apply-templates select="journal"/>
                <!-- TODO -->
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="author">
        <xsl:value-of select="."/>
        
        <xsl:choose>
            <xsl:when test="following-sibling::author">, </xsl:when>
            <xsl:otherwise>: </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="journal">
        <xsl:text> </xsl:text>
        <xsl:value-of select="."/>: <xsl:value-of select="../pages"/>
        (<xsl:value-of select="../year"/>)
    </xsl:template>
</xsl:stylesheet>
