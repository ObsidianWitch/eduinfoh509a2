<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
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
        <xsl:variable name="sortedYears" as="xs:integer*">
            <xsl:perform-sort select="/dblp/*[author = current-grouping-key()]/year">
                <xsl:sort select="." order="descending"/>
            </xsl:perform-sort>
        </xsl:variable>

        <xsl:variable name="nbPublications"
            select="count(/dblp/*[author = current-grouping-key()])" />

        <p>
            <table border="1">
                <xsl:for-each select="/dblp/*[author = current-grouping-key()]">
                    <xsl:sort select="year" order="descending" />

                    <xsl:variable name="prevPosition" select="position() - 1"/>
                    <xsl:variable name="prevYear" select="$sortedYears[$prevPosition]"/>

                    <xsl:if test="not(year = $prevYear)">
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
            <td valign="top">
                <xsl:apply-templates select="ee"/>
            </td>
            <td>
                <xsl:apply-templates select="author"/>
                <em><xsl:value-of select="title"/></em>
                <xsl:apply-templates select="self::book | self::incollection
                    | self::inproceedings"/> <!-- TODO -->
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="book">
        <xsl:apply-templates select="series"/>
        <xsl:apply-templates select="volume"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="publisher"/><xsl:text> </xsl:text>
        <xsl:value-of select="year"/>
        <xsl:apply-templates select="isbn"/>
    </xsl:template>

    <xsl:template match="incollection | inproceedings">
        <xsl:text> </xsl:text>
        <xsl:value-of select="booktitle"/><xsl:text>: </xsl:text>
        <xsl:value-of select="pages"/>
    </xsl:template>

    <xsl:template match="author">
        <xsl:value-of select="."/>

        <xsl:choose>
            <xsl:when test="following-sibling::author">, </xsl:when>
            <xsl:otherwise>: </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Electronic Edition -->
    <xsl:template match="ee">
        <a href="{.}">
            <img alt="Electronic Edition" title="Electronic Edition"
                src="http://www.informatik.uni-trier.de/~ley/db/ee.gif"
                border="0" height="16" width="16"/>
        </a>
    </xsl:template>

    <xsl:template match="series | volume">
        <xsl:text> </xsl:text><xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="isbn">
        <xsl:text>, ISBN </xsl:text><xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>
