<?xml version="1.0" encoding="shift_jis"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="edif"/>
    </xsl:template>
    <xsl:template match="edif">
        <xsl:variable name="design_name" select="design/@name"/>
        <xsl:variable name="cell_ref" select="design/cellRef/@name"/>
        <xsl:variable name="library_ref" select="design/cellRef/libraryRef/@name"/>
        <xsl:for-each select="(library|external)[@name=$library_ref]">
            <xsl:for-each select="cell[@name=$cell_ref]/view">
                <xsl:variable name="view_name" select="@name"/>
                <xsl:for-each select="contents/page">
                    <xsl:value-of select="@name"/>
                    <xsl:text>&#10;</xsl:text>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
