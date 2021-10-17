<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:for-each select="//*[@name!='']">
            <xsl:sort select="concat(name(),'-',@name)"/>
            <xsl:value-of select="name()"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="ancestor::library/@name"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="ancestor::cell/@name"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="ancestor::view/@name"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
