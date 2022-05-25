<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:key name="vw" match="library/cell/view" use="concat(ancestor::library/@name,'-',ancestor::cell/@name,'-',@name)"/>
    <xsl:template match="/">
        <xsl:text>page,instance,view</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="edif/library/cell/view/contents/page/instance"/>
    </xsl:template>
    <xsl:template match="instance">
        <xsl:variable name="vwid" 
            select="concat(viewref/cellref/libraryref/@name,'-',viewref/cellref/@name,'-',viewref/@name)"/>
        <xsl:value-of select="ancestor::page/@name"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="$vwid"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="key('vw',$vwid)/viewtype"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
