<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt">
    <xsl:param name="page"/>
    <xsl:output method="text"/>

    <xsl:template match="/">
        <xsl:apply-templates select="edif"/>
    </xsl:template>

    <xsl:template match="edif">
        <xsl:variable name="library" select="design/cellref/libraryref/@name"/>
        <xsl:variable name="cell" select="design/cellref/@name"/>
        <xsl:apply-templates select="library[@name=$library]/cell[@name=$cell]"/>
    </xsl:template>

    <xsl:template match="cell">
        <xsl:apply-templates select="view/contents/page[@name=$page]"/>
    </xsl:template>

    <xsl:template match="page">
        <xsl:variable name="header" select="instance/property[not(@name=preceding::property/@name)]"/>
        <!--header-->
        <xsl:text>id,name,designator</xsl:text>
        <xsl:for-each select="$header">
            <xsl:sort select="@name"/>
            <xsl:text>,</xsl:text>
            <xsl:call-template name="_print">
                <xsl:with-param name="s" select="@name"/>
            </xsl:call-template>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
        <!--data-->
        <xsl:for-each select="instance">
            <xsl:variable name="line" select="."/>
            <xsl:call-template name="_print">
                <xsl:with-param name="s" select="@name"/>
            </xsl:call-template>
            <xsl:text>,</xsl:text>
            <xsl:apply-templates select="rename"/>
            <xsl:text>,</xsl:text>
            <xsl:apply-templates select="designator"/>
            <xsl:for-each select="$header">
                <xsl:sort select="@name"/>
                <xsl:variable name="kw" select="@name"/>
                <xsl:text>,</xsl:text>
                <xsl:for-each select="$line">
                    <xsl:variable name="prop" select="property[@name=$kw]"/>
                    <xsl:text>&quot;</xsl:text>
                    <xsl:call-template name="_print">
                        <xsl:with-param name="s" select="normalize-space($prop/number/text())"/>
                    </xsl:call-template>
                    <xsl:call-template name="_print">
                        <xsl:with-param name="s" select="normalize-space($prop/integer/text())"/>
                    </xsl:call-template>
                    <xsl:call-template name="_print">
                        <xsl:with-param name="s" select="normalize-space($prop/string/text())"/>
                    </xsl:call-template>
                    <xsl:call-template name="_print">
                        <xsl:with-param name="s" select="normalize-space($prop/text())"/>
                    </xsl:call-template>
                    <xsl:text>&quot;</xsl:text>
                </xsl:for-each>
            </xsl:for-each>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <!--common-->
    <xsl:template match="rename">
        <xsl:call-template name="_print">
            <xsl:with-param name="s" select="text()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="designator">
        <xsl:if test="string-length(normalize-space(text()))!=0">
            <xsl:call-template name="_print">
                <xsl:with-param name="s" select="text()"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates select="stringdisplay"/>
    </xsl:template>

    <xsl:template match="stringdisplay">
        <xsl:call-template name="_print">
            <xsl:with-param name="s" select="text()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="property">
        <xsl:text>&#32;</xsl:text>
        <xsl:call-template name="_name"/>
        <xsl:text>=</xsl:text>
        <xsl:call-template name="_value"/>
    </xsl:template>

    <!--common function-->
    <xsl:template name="_name">
        <xsl:call-template name="_print">
            <xsl:with-param name="s">
                <xsl:choose>
                    <xsl:when test="count(rename)!=0">
                        <xsl:value-of select="rename/text()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@name"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_value">
        <xsl:call-template name="_print">
            <xsl:with-param name="s">
                <xsl:value-of select="string/text()"/>
                <xsl:value-of select="integer/text()"/>
                <xsl:value-of select="number/text()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_print">
        <xsl:param name="s"/>
        <xsl:variable name="s2">
            <xsl:if test="not (starts-with($s,'&amp;'))">
                <xsl:value-of select="substring($s,1,1)"/>
            </xsl:if>
            <xsl:value-of select="substring($s,2)"/>
        </xsl:variable>
        <xsl:variable name="s3" select="translate($s2,'&quot;','')"/>
        <xsl:value-of select="$s3" disable-output-escaping="yes"/>
    </xsl:template>

</xsl:stylesheet>
