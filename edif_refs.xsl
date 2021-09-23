<?xml version="1.0" encoding="shift_jis"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:param name="page"/>
    <xsl:key name="refs" match="//viewRef" use="concat(@name,'-',cellRef/@name,'-',cellRef/libraryRef/@name)"/>
    <!-- <xsl:key name="refs" match="//viewRef" use="."/> -->

    <xsl:template match="/">
        <xsl:for-each select="edif">
            <xsl:variable name="edif_name" select="@name"/>
            <xsl:variable name="design_name" select="design/@name"/>
            <xsl:variable name="cell_ref" select="design/cellRef/@name"/>
            <xsl:variable name="library_ref" select="design/cellRef/libraryRef/@name"/>
            <xsl:for-each select="(library|external)[@name=$library_ref]">
                <xsl:for-each select="cell[@name=$cell_ref]/view">
                    <xsl:apply-templates select="contents/page[@name=$page]"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="page">
        <xsl:param name="library_name" select="../../@name"/>
        <xsl:param name="cell_name" select="../@name"/>
        <xsl:for-each select=".//viewRef[generate-id()=generate-id(key('refs',concat(@name,'-',cellRef/@name,'-',cellRef/libraryRef/@name))[1])]">
        <!-- <xsl:for-each select=".//viewRef[generate-id()=generate-id(key('refs',.)[1])]"> -->
            <xsl:sort select="@name"/>
            <xsl:variable name="ref" select="concat(@name,'-',cellRef/@name,'-',cellRef/libraryRef/@name)"/>
            <xsl:value-of select="$ref"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
