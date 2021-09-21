<?xml version="1.0" encoding="shift_jis"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:key name="cells" match="//cellRef" use="@name"/>
    <xsl:key name="views" match="//viewRef" use="@name"/>
    <xsl:param name="page"/>

    <xsl:template match="/">
        <xsl:for-each select="edif">
            <xsl:variable name="design_name" select="design/@name"/>
            <xsl:variable name="cell_ref" select="design/cellRef/@name"/>
            <xsl:variable name="library_ref" select="design/cellRef/libraryRef/@name"/>
            <xsl:for-each select="(library|external)[@name=$library_ref]">
                <xsl:for-each select="cell[@name=$cell_ref]/view">
                    <xsl:variable name="view_name" select="@name"/>
                    <xsl:for-each select="contents/page[@name=$page]">
                        <xsl:for-each select="//cellRef[generate-id()=generate-id(key('cells',@name)[1])]">
                            <xsl:sort select="@name"/>
                            <xsl:value-of select="@name"/>
                            <xsl:text>&#10;</xsl:text>
                        </xsl:for-each>
                        <xsl:text>&#10;</xsl:text>
                        <xsl:for-each select="//viewRef[generate-id()=generate-id(key('views',@name)[1])]">
                            <xsl:sort select="@name"/>
                            <xsl:value-of select="@name"/>
                            <xsl:text>&#10;</xsl:text>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
