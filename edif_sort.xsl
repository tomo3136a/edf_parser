<?xml version="1.0" encoding="shift_jis"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:key name="nodes" match="*" use="translate(name(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;?xml version="1.0"?&gt;
&lt;xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"&gt;
    &lt;xsl:output method="xml" media-type="text/xsl" indent="yes"/&gt;

    &lt;xsl:template match="/"&gt;
        &lt;xsl:apply-templates /&gt;
    &lt;/xsl:template&gt;

    &lt;xsl:template name="_copy"&gt;
        &lt;xsl:if test="not (count(@name)=0)"&gt;
            &lt;xsl:attribute name="name"&gt;
                &lt;xsl:value-of select="@name"/&gt;
            &lt;/xsl:attribute&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="not (count(@id)=0)"&gt;
            &lt;xsl:attribute name="id"&gt;
                &lt;xsl:value-of select="@id"/&gt;
            &lt;/xsl:attribute&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="not (count(text())=0)"&gt;
            &lt;xsl:value-of select="text()"/&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:for-each select="*"&gt;
            &lt;xsl:copy-of select="."/&gt;
        &lt;/xsl:for-each&gt;
    &lt;/xsl:template&gt;

    &lt;xsl:template name="_no_sort"&gt;
        &lt;xsl:if test="not (count(@name)=0)"&gt;
            &lt;xsl:attribute name="name"&gt;
                &lt;xsl:value-of select="@name"/&gt;
            &lt;/xsl:attribute&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="not (count(@id)=0)"&gt;
            &lt;xsl:attribute name="id"&gt;
                &lt;xsl:value-of select="@id"/&gt;
            &lt;/xsl:attribute&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="not (count(text())=0)"&gt;
            &lt;xsl:value-of select="text()"/&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:for-each select="*"&gt;
            &lt;xsl:apply-templates select="."/&gt;
        &lt;/xsl:for-each&gt;
    &lt;/xsl:template&gt;

    &lt;xsl:template name="_sort"&gt;
        &lt;xsl:if test="not (count(@name)=0)"&gt;
            &lt;xsl:attribute name="name"&gt;
                &lt;xsl:value-of select="@name"/&gt;
            &lt;/xsl:attribute&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="not (count(@id)=0)"&gt;
            &lt;xsl:attribute name="id"&gt;
                &lt;xsl:value-of select="@id"/&gt;
            &lt;/xsl:attribute&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:if test="not (count(text())=0)"&gt;
            &lt;xsl:value-of select="text()"/&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:for-each select="*"&gt;
            &lt;xsl:sort select="name(.)" data-type="text"/&gt;
            &lt;xsl:sort select="@id" data-type="text"/&gt;
            &lt;xsl:sort select="@name" data-type="text"/&gt;
            &lt;xsl:sort select="text()" data-type="text"/&gt;
            &lt;xsl:apply-templates select="."/&gt;
        &lt;/xsl:for-each&gt;
    &lt;/xsl:template&gt;&#10;</xsl:text>

        <xsl:for-each select="//*[generate-id()=generate-id(key('nodes',translate(name(),$lowercase,$uppercase))[1])]">
            <xsl:text disable-output-escaping="yes">
    &lt;xsl:template match="</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text disable-output-escaping="yes">"&gt;
        &lt;xsl:element name="</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text disable-output-escaping="yes">"&gt;
            &lt;xsl:call-template name="</xsl:text>
            <xsl:choose>
                <xsl:when test="name()='figure'">
                    <xsl:text>_copy</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>_sort</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text disable-output-escaping="yes">"/&gt;
        &lt;/xsl:element&gt;
    &lt;/xsl:template&gt;&#10;</xsl:text>
        </xsl:for-each>

        <xsl:text disable-output-escaping="yes">
&lt;/xsl:stylesheet&gt;
        </xsl:text>
    </xsl:template>

</xsl:stylesheet>
