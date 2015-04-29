<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">



	<xsl:template match="/">

				<xsl:for-each select="dblp/article">

					<xsl:sort select="author"></xsl:sort>
					<xsl:result-document href="{author}.html">
						<html>
								<body>

						<xsl:if test="author!=preceding-sibling::article[1]/author"> <!--This condition is not correct-->
							<xsl:call-template name="author_header"></xsl:call-template>
						</xsl:if>
							</body>
					</html>
					</xsl:result-document>
				</xsl:for-each>


	</xsl:template>
	<xsl:template name="author_header">
		<h1><xsl:value-of select="author"/></h1>
			<p>
     			<table border="1">
     				<xsl:call-template name="author_publication"></xsl:call-template>
     			</table>
     		</p>
	</xsl:template>

	<xsl:template name="author_publication">
	<tr><th colspan="3" bgcolor="#FFFFCC"><xsl:value-of select="year"/></th></tr>
     		<tr>
     			<td align="right" valign="top"><a name="p5"/><xsl:value-of select="number"/></td>
     			<td valign="top">
     				<a>
     				<xsl:attribute name="href"><xsl:value-of select="ee"/></xsl:attribute>
     				<img  border="0" height="16" width="16"  src="http://www.informatik.uni-trier.de/~ley/db/ee.gif"><!--Where are the gifs addresses??-->
     				<xsl:attribute name="title">
     					<xsl:value-of select="title"/>
     				</xsl:attribute>
     				</img>
     				</a>
     			</td>
     			<td>
     					<xsl:for-each select="author">
								<a href="{.}.html">

     					<xsl:value-of select="."/>
						</a>,
     					</xsl:for-each>
     					<xsl:value-of select="title"/>
     					<!--With the same method (value-of) you can insert other required informations-->
     			</td>
     		</tr>
	</xsl:template>
</xsl:stylesheet>