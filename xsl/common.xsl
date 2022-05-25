<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--common function-->
    <xsl:template match="*" mode="_designator">
        <xsl:call-template name="_print">
            <xsl:with-param name="s">
                <xsl:value-of select="normalize-space(text())"/>
                <xsl:value-of select="stringdisplay/text()"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="*" mode="_name">
        <xsl:call-template name="_print">
            <xsl:with-param name="s">
                <xsl:if test="rename">
                    <xsl:value-of select="rename/text()"/>
                    <xsl:value-of select="rename/stringdisplay/text()"/>
                </xsl:if>
                <xsl:if test="name">
                    <xsl:value-of select="name/text()"/>
                </xsl:if>
                <xsl:if test="not(rename|name)">
                    <xsl:value-of select="@name"/>
                </xsl:if>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="*" name="_value">
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
        <xsl:text>&quot;</xsl:text>
        <xsl:value-of select="$s3" disable-output-escaping="yes"/>
        <xsl:text>&quot;</xsl:text>
    </xsl:template>

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

<!-- 
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

    <xsl:template name="_print_">
        <xsl:variable name="s" select="."/>
        <xsl:variable name="s2">
            <xsl:if test="not (starts-with($s,'&amp;'))">
                <xsl:value-of select="substring($s,1,1)"/>
            </xsl:if>
            <xsl:value-of select="substring($s,2)"/>
        </xsl:variable>
        <xsl:variable name="s3" select="translate($s2,'&quot;','')"/>
        <xsl:value-of select="$s3" disable-output-escaping="yes"/>
    </xsl:template> -->

</xsl:stylesheet>
