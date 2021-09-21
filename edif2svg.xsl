<?xml version="1.0" encoding="shift_jis"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" media-type="text/xsl" indent="yes"/>

    <!--root-->
    <xsl:template match="/">
        <xsl:apply-templates select="edif"/>
    </xsl:template>
    <xsl:template match="edif">
        <xsl:variable name="x" select="0-10"/>
        <xsl:variable name="y" select="0-10"/>
        <xsl:variable name="dx" select="2359+10"/>
        <xsl:variable name="dy" select="1674+10"/>
        <svg xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:ev="http://www.w3.org/2001/xml-events">
            <xsl:attribute name="style">
                <xsl:text>background: #0ee</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="viewBox">
                <xsl:value-of select="concat($x,' ',$y,' ',$dx,' ',$dy)"/>
            </xsl:attribute>
            <xsl:apply-templates select="external"/>
            <xsl:apply-templates select="library"/>
            <xsl:apply-templates select="design"/>
        </svg>
    </xsl:template>

    <!--design-->
    <xsl:template match="design">
        <g transform="scale(1,-1)">
            <xsl:apply-templates select="cellRef"/>
        </g>
    </xsl:template>
    <xsl:template match="cellRef">
        <xsl:apply-templates select="libraryRef" mode="design">
            <xsl:with-param name="ref_cell" select="@name"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="libraryRef" mode="design">
        <xsl:param name="ref_cell"/>
        <use>
            <xsl:attribute namespace="http://www.w3.org/1999/xlink" name="href">
                <xsl:value-of select="concat('#',$ref_cell)"/>
            </xsl:attribute>
        </use>
    </xsl:template>

    <!--library/external-->
    <xsl:template match="library|external">
        <defs>
            <xsl:apply-templates select="technorogy"/>
            <xsl:apply-templates select="cell"/>
        </defs>
    </xsl:template>
    <xsl:template match="technorogy">
        <xsl:apply-templates select="numberDefinition"/>
        <xsl:apply-templates select="figureGroup"/>
    </xsl:template>
    <xsl:template match="numberDefinition">
        <xsl:apply-templates select="scale"/>
        <xsl:apply-templates select="gridMap"/>
    </xsl:template>
    <xsl:template match="scale"/>
    <xsl:template match="gridMap"/>

    <!--cell-->
    <xsl:template match="cell">
        <g stroke="black" stroke-width="1">
            <xsl:attribute name="id">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:apply-templates select="view"/>
        </g>
    </xsl:template>
    <xsl:template match="view">
        <xsl:apply-templates select="interface"/>
        <xsl:apply-templates select="contents"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>

    <!--interface-->
    <xsl:template match="interface">
        <xsl:apply-templates select="port"/>
        <xsl:apply-templates select="symbol"/>
        <xsl:apply-templates select="designator"/>
        <xsl:apply-templates select="protectionFrame"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>
    <xsl:template match="protectionFrame">
        <xsl:apply-templates select="portImplementation"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="commentGraphics"/>
        <xsl:apply-templates select="boundingBox"/>
        <xsl:apply-templates select="propertyDisplay"/>
        <xsl:apply-templates select="keywordDisplay"/>
        <xsl:apply-templates select="parameterDisplay"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>
    <xsl:template match="port">
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="designator"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>

    <!--symbol-->
    <xsl:template match="symbol">
        <xsl:apply-templates select="portImplementation"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="commentGraphics"/>
        <xsl:apply-templates select="annotate"/>
        <xsl:apply-templates select="pageSize"/>
        <xsl:apply-templates select="boundingBox"/>
        <xsl:apply-templates select="propertyDisplay"/>
        <xsl:apply-templates select="keywordDisplay"/>
        <xsl:apply-templates select="parameterDisplay"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>

    <!--portImplementation-->
    <xsl:template match="portImplementation">
        <xsl:apply-templates select="name"/>
        <xsl:apply-templates select="keywordDisplay"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="connectLocation">
            <xsl:with-param name="name" select="name/text()"/>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="connectLocation">
        <xsl:apply-templates select="figure"/>
    </xsl:template>

    <!--contents-->
    <xsl:template match="contents">
        <!--offPageConnector-->
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="page"/>
        <xsl:apply-templates select="commentGraphics"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="net"/>
        <xsl:apply-templates select="portImplementation"/>
        <xsl:apply-templates select="boundingBox"/>
    </xsl:template>
    <xsl:template match="page">
        <xsl:apply-templates select="pageSize"/>
        <xsl:apply-templates select="commentGraphics"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="net"/>
        <xsl:apply-templates select="portImplementation"/>
        <xsl:apply-templates select="boundingBox"/>
    </xsl:template>
    <xsl:template match="commentGraphics">
        <xsl:apply-templates select="annotate"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="boundingBox"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>
    <xsl:template match="annotate">
        <xsl:apply-templates select="stringDisplay"/>
    </xsl:template>
    <xsl:template match="designator">
        <xsl:apply-templates select="stringDisplay"/>
    </xsl:template>
    <xsl:template match="property">
        <xsl:apply-templates select="string"/>
    </xsl:template>
    <xsl:template match="string">
        <xsl:apply-templates select="stringDisplay"/>
    </xsl:template>

    <!--instance-->
    <xsl:template match="instance">
        <xsl:param name="x" select="number(substring-before(transform/origin/pt,' '))"/>
        <xsl:param name="y" select="number(substring-after(transform/origin/pt,' '))"/>
        <xsl:param name="a" select="transform/orientation/text()"/>
        <g fill="#fff" stroke="black" stroke-width="2">
            <xsl:for-each select="transform">
                <xsl:call-template name="transform"/>
            </xsl:for-each>
            <rect fill="black" x="-3" y="-3" width="6" height="6" stroke="black" stroke-width="1"/>
            <text x="5" y="0" font-famiry="sans-serif" font-size="50%" stroke="black" stroke-width="1" text-anchor="start" dominant-baseline="central" transform="scale(-1,1)">
                <xsl:value-of select="$a"/>
            </text>
            <use fill="#fff" stroke="black" stroke-width="2">
                <xsl:attribute namespace="http://www.w3.org/1999/xlink" name="href">
                    <xsl:value-of select="concat('#',viewRef/cellRef/@name)"/>
                </xsl:attribute>
            </use>
        </g>
        <xsl:apply-templates select="portInstance"/>
        <xsl:apply-templates select="designator"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>

    <xsl:template match="portInstance">
        <xsl:apply-templates select="name"/>
        <xsl:apply-templates select="designator"/>
    </xsl:template>

    <xsl:template match="viewRef">
        <xsl:apply-templates select="cellRef"/>
    </xsl:template>

    <!--net-->
    <xsl:template match="net">
        <!--joined-->
        <g stroke="black" stroke-width="1">
            <xsl:attribute name="id">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:apply-templates select="figure"/>
        </g>
    </xsl:template>

    <!--common-->
    <xsl:template match="keywordDisplay">
        <xsl:param name="name" select="../name/text()"/>
        <xsl:param name="kw" select="text()"/>
        <xsl:for-each select="../../../port[@name=$name]/*">
            <xsl:if test="name()=$kw">
                <text>
                    <xsl:value-of select="text()"/>
                </text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="transform">
        <xsl:param name="x" select="number(substring-before(origin/pt,' '))"/>
        <xsl:param name="y" select="number(substring-after(origin/pt,' '))"/>
        <xsl:param name="a" select="orientation/text()"/>
        <xsl:if test="not (count(origin)=0)">
            <xsl:attribute name="transform">
                <xsl:text> translate(</xsl:text>
                <xsl:value-of select="$x"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y"/>
                <xsl:text>)</xsl:text>
                <xsl:if test="not (count(orientation)=0)">
                    <xsl:if test="$a='R0'">
                        <xsl:text>rotate(0)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R90'">
                        <xsl:text>rotate(90)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R180'">
                        <xsl:text>rotate(180)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R270'">
                        <xsl:text>rotate(270)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MY'">
                        <xsl:text>scale(-1,1)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MX'">
                        <xsl:text>scale(1,-1)</xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <xsl:template name="text-anchor">
        <xsl:param name="j1" select="substring-before(justify/text(),'ER')"/>
        <xsl:param name="j2" select="substring-after(justify/text(),'ER')"/>
        <xsl:if test="not (count(justify)=0)">
            <xsl:attribute name="dominant-baseline">
                <xsl:choose>
                    <xsl:when test="$j1='CENT'">
                        <xsl:text>central</xsl:text>
                    </xsl:when>
                    <xsl:when test="$j1='LOW'">
                        <xsl:text>auto</xsl:text>
                    </xsl:when>
                    <xsl:when test="$j1='UPP'">
                        <xsl:text>hanging</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="text-anchor">
                <xsl:choose>
                    <xsl:when test="$j2='CENTER'">
                        <xsl:text>middle</xsl:text>
                    </xsl:when>
                    <xsl:when test="$j2='LEFT'">
                        <xsl:text>start</xsl:text>
                    </xsl:when>
                    <xsl:when test="$j2='RIGHT'">
                        <xsl:text>end</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!--string-->
    <xsl:template match="stringDisplay|name">
        <xsl:param name="s" select="text()"/>
        <xsl:if test="count(display/figureGroupOverride/visible/false)=0">
            <g>
                <xsl:if test="not (count(display/origin)=0)">
                    <xsl:for-each select="display">
                        <xsl:call-template name="transform"/>
                    </xsl:for-each>
                </xsl:if>
                <g transform="scale(1,-1)">
                    <text stroke-width="0.5" font-famiry="sans-serif" font-size="50%">
                        <xsl:for-each select="display">
                            <xsl:call-template name="text-anchor"/>
                        </xsl:for-each>
                        <xsl:apply-templates select="$s"/>
                    </text>
                    <circle r="1" fill="#0" stroke="red" stroke-width="1" cx="0" cy="0"/>
                </g>
            </g>
        </xsl:if>
    </xsl:template>

    <!-- <xsl:template match="keywordDisplay">
        <xsl:param name="s" select="text()"/>
        <xsl:if test="count(display/figureGroupOverride/visible/false)=0">
            <g>
                <xsl:if test="not (count(display/origin)=0)">
                    <xsl:for-each select="display">
                        <xsl:call-template name="transform"/>
                    </xsl:for-each>
                </xsl:if>
                <g transform="scale(1,-1)">
                    <text stroke-width="0.5" font-famiry="sans-serif" font-size="50%">
                        <xsl:for-each select="display">
                            <xsl:call-template name="text-anchor"/>
                        </xsl:for-each>
                        <xsl:text>[</xsl:text>
                        <xsl:value-of select="translate($s,'&quot;','')"/>
                        <xsl:text>]</xsl:text>
                    </text>
                    <circle r="1" fill="#0" stroke="red" stroke-width="1" cx="0" cy="0"/>
                </g>
            </g>
            </xsl:if>
    </xsl:template> -->

    <!--figure-->
    <xsl:template match="figure">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:template match="figureGroupOverride"/>
    <!--circle-->
    <xsl:template match="circle">
        <!--TODO-->
        <xsl:param name="x1" select='number(substring-before(pt[1]," "))'/>
        <xsl:param name="y1" select='number(substring-after(pt[1]," "))'/>
        <xsl:param name="x2" select='number(substring-before(pt[2]," "))'/>
        <xsl:param name="y2" select='number(substring-after(pt[2]," "))'/>

        <circle r="2" fill="#0" stroke="green" stroke-width="1">
            <xsl:attribute name="cx">
                <xsl:value-of select="$x1"/>
            </xsl:attribute>
            <xsl:attribute name="cy">
                <xsl:value-of select="$y1"/>
            </xsl:attribute>
        </circle>
        <circle r="2" fill="#0" stroke="green" stroke-width="1">
            <xsl:attribute name="cx">
                <xsl:value-of select="$x2"/>
            </xsl:attribute>
            <xsl:attribute name="cy">
                <xsl:value-of select="$y2"/>
            </xsl:attribute>
        </circle>

        <circle fill="none" stroke="#0">
            <xsl:attribute name="cx">
                <xsl:value-of select="(number($x2)+number($x1))*0.5"/>
            </xsl:attribute>
            <xsl:attribute name="cy">
                <xsl:value-of select="(number($y2)+number($y1))*0.5"/>
            </xsl:attribute>
            <xsl:attribute name="r">
                <xsl:value-of select="(number($x2)-number($x1))*0.5"/>
            </xsl:attribute>
            <!-- <xsl:attribute name="height">
                <xsl:value-of select="number($y2)-number($y1)"/>
            </xsl:attribute> -->
        </circle>
    </xsl:template>
    <!--dot-->
    <xsl:template match="dot">
        <xsl:param name="x" select='number(substring-before(pt[1]," "))'/>
        <xsl:param name="y" select='number(substring-after(pt[1]," "))'/>
        <circle r="4" fill="#0" stroke="orange" stroke-width="2">
            <xsl:attribute name="cx">
                <xsl:value-of select="$x"/>
            </xsl:attribute>
            <xsl:attribute name="cy">
                <xsl:value-of select="$y"/>
            </xsl:attribute>
        </circle>
    </xsl:template>
    <!--path-->
    <xsl:template match="path">
        <path fill="none">
            <xsl:attribute name="d">
                <xsl:text>M</xsl:text>
                <xsl:apply-templates select="pointList/pt"/>
            </xsl:attribute>
        </path>
    </xsl:template>
    <!--polygon-->
    <xsl:template match="polygon">
        <xsl:param name="fill" select="'none'"/>
        <path>
            <xsl:attribute name="fill">
                <xsl:value-of select="$fill"/>
            </xsl:attribute>
            <xsl:attribute name="d">
                <xsl:text>M</xsl:text>
                <xsl:apply-templates select="pointList/pt"/>
                <xsl:text>Z</xsl:text>
            </xsl:attribute>
        </path>
    </xsl:template>
    <!--rectangle-->
    <xsl:template match="rectangle">
        <xsl:param name="x1" select='number(substring-before(pt[1]," "))'/>
        <xsl:param name="y1" select='number(substring-after(pt[1]," "))'/>
        <xsl:param name="x2" select='number(substring-before(pt[2]," "))'/>
        <xsl:param name="y2" select='number(substring-after(pt[2]," "))'/>
        <rect fill="none">
            <xsl:attribute name="x">
                <xsl:value-of select="$x1"/>
            </xsl:attribute>
            <xsl:attribute name="y">
                <xsl:value-of select="$y1"/>
            </xsl:attribute>
            <xsl:attribute name="width">
                <xsl:value-of select="number($x2)-number($x1)"/>
            </xsl:attribute>
            <xsl:attribute name="height">
                <xsl:value-of select="number($y2)-number($y1)"/>
            </xsl:attribute>
        </rect>
    </xsl:template>
    <xsl:template match="pointList/pt">
        <xsl:param name="x" select='number(substring-before(text()," "))'/>
        <xsl:param name="y" select='number(substring-after(text()," "))'/>
        <xsl:text>&#32;</xsl:text>
        <xsl:value-of select="$x"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="$y"/>
    </xsl:template>
    <!--shape-->
    <xsl:template match="sharpe|openShape">
        <xsl:apply-templates select="curve"/>
    </xsl:template>
    <xsl:template match="curve">
        <xsl:apply-templates select="arc"/>
    </xsl:template>
    <xsl:template match="arc">
        <path fill="none">
            <xsl:attribute name="d">
                <xsl:text>M</xsl:text>
                <xsl:value-of select='number(substring-before(pt[1]/text()," "))'/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select='number(substring-after(pt[1]/text()," "))'/>
                <xsl:text>Q</xsl:text>
                <xsl:value-of select='number(substring-before(pt[2]/text()," "))'/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select='number(substring-after(pt[2]/text()," "))'/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select='number(substring-before(pt[3]/text()," "))'/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select='number(substring-after(pt[3]/text()," "))'/>
            </xsl:attribute>
        </path>
    </xsl:template>

    <!--text()-->
    <xsl:template match="text()">
        <xsl:param name="s" select="translate(.,'&quot;&#13;','')"/>
        <xsl:choose>
            <xsl:when test="contains($s,'&#10;')">
                <xsl:call-template name="text-area">
                    <xsl:with-param name="s" select="$s"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$s"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="text-area">
        <xsl:param name="s" select="."/>
        <xsl:param name="y" select="0"/>
        <xsl:if test="string-length($s)">
            <tspan x="0">
                <xsl:attribute name="y">
                    <xsl:value-of select="$y"/>
                </xsl:attribute>
                <xsl:value-of select="substring-before(concat($s,'&#10;'),'&#10;')"/>
            </tspan>
            <xsl:call-template name="text-area">
                <xsl:with-param name="s" select="substring-after($s, '&#10;')"/>
                <xsl:with-param name="y" select="number($y)+10"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
