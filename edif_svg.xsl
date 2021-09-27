<?xml version="1.0" encoding="shift_jis"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" media-type="text/xsl" indent="yes"/>
    <xsl:param name="page"/>

    <!--keys
        fgl: figureGroup list   libraryName-figureGroupName
        vwl: view list          libraryName-cellName-viewName
    -->
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
    <xsl:key name="fgl" match="//figureGroup" use="translate(
        concat(../../@name,'-',@name),
        'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    <xsl:key name="vwl" match="//view" use="translate(
        concat(../../@name,'-',../@name,'-',@name),
        'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

    <!--root/edif-->
    <xsl:template match="/">
        <xsl:apply-templates select="edif"/>
    </xsl:template>
    <xsl:template match="edif">
        <svg xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:ev="http://www.w3.org/2001/xml-events">
            <xsl:attribute name="style">
                <xsl:text>background: #0ee</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="library">
                <xsl:call-template name="_viewBox"/>
            </xsl:for-each>
        <rect fill="#088">
            <xsl:attribute name="x">
                <xsl:call-template name="_pt_xs"/>
            </xsl:attribute>
            <xsl:attribute name="y">
                <xsl:call-template name="_pt_ys"/>
            </xsl:attribute>
            <xsl:attribute name="width">
                <xsl:call-template name="_pt_dx"/>
            </xsl:attribute>
            <xsl:attribute name="height">
                <xsl:call-template name="_pt_dy"/>
            </xsl:attribute>
        </rect>
            <xsl:apply-templates select="external"/>
            <xsl:apply-templates select="library"/>
            <xsl:apply-templates select="design"/>
        </svg>
    </xsl:template>

    <xsl:template name="_viewBox">
        <xsl:attribute name="viewBox">
            <xsl:call-template name="_pt_xs"/>
            <xsl:text>,</xsl:text>
            <xsl:call-template name="_pt_ys"/>
            <xsl:text>,</xsl:text>
            <xsl:call-template name="_pt_dx"/>
            <xsl:text>,</xsl:text>
            <xsl:call-template name="_pt_dy"/>
        </xsl:attribute>
    </xsl:template>

    <!--design-->
    <xsl:template match="design">
        <xsl:for-each select="cellRef/libraryRef">
            <use stroke="black" stroke-width="1" fill="none">
                <xsl:attribute namespace="http://www.w3.org/1999/xlink" name="href">
                    <xsl:value-of select="concat('#',@name,'-',../@name)"/>
                </xsl:attribute>
            </use>
        </xsl:for-each>
    </xsl:template>

    <!--library/external/technology-->
    <xsl:template match="library|external">
        <defs stroke="black" stroke-width="1" fill="none">
            <xsl:attribute name="id">
                <xsl:value-of select="concat('#',@name)"/>
            </xsl:attribute>
            <xsl:apply-templates select="technology"/>
            <xsl:apply-templates select="cell"/>
        </defs>
    </xsl:template>

    <xsl:template match="technology">
        <xsl:if test="not (count(figureGroup)=0)">
            <style type="text/css">
                <xsl:apply-templates select="figureGroup"/>
            </style>
        </xsl:if>
    </xsl:template>

    <!--cell-->
    <xsl:template match="cell">
        <g>
            <xsl:attribute name="id">
                <xsl:value-of select="../@name"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:apply-templates select="view"/>
        </g>
    </xsl:template>

    <xsl:template match="view">
        <g>
            <xsl:attribute name="id">
                <xsl:value-of select="../../@name"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="../@name"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:apply-templates select="interface"/>
            <xsl:apply-templates select="contents"/>
            <xsl:apply-templates select="property"/>
        </g>
    </xsl:template>

    <!--interface-->
    <xsl:template match="interface">
        <xsl:apply-templates select="protectionFrame"/>
        <xsl:apply-templates select="symbol"/>
        <xsl:apply-templates select="port"/>
        <xsl:apply-templates select="designator"/>
        <xsl:apply-templates select="property"/>
        <xsl:call-template name="_border"/>
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

    <!--port-->
    <xsl:template match="port">
        <!-- <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="designator"/>
        <xsl:apply-templates select="property"/> -->
    </xsl:template>

    <!--symbol-->
    <xsl:template match="symbol">
        <xsl:apply-templates select="boundingBox"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="portImplementation"/>
        <xsl:apply-templates select="commentGraphics"/>
        <xsl:apply-templates select="annotate"/>
        <xsl:apply-templates select="pageSize"/>
        <xsl:apply-templates select="keywordDisplay"/>
        <xsl:apply-templates select="propertyDisplay"/>
        <xsl:apply-templates select="parameterDisplay"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>

    <!--portImplementation-->
    <xsl:template match="portImplementation">
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="connectLocation">
            <xsl:with-param name="name" select="name/text()"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="name"/>
        <xsl:apply-templates select="rename"/>
        <xsl:apply-templates select="keywordDisplay"/>
    </xsl:template>

    <xsl:template match="connectLocation">
        <xsl:apply-templates select="figure"/>
    </xsl:template>

    <!--contents-->
    <xsl:template match="contents">
        <xsl:call-template name="contents_page"/>
        <xsl:for-each select="page[@name=$page]">
            <xsl:call-template name="contents_page"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="contents_page">
        <xsl:apply-templates select="pageSize"/>
        <xsl:apply-templates select="boundingBox"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="portImplementation"/>
        <xsl:apply-templates select="net"/>
        <xsl:apply-templates select="commentGraphics"/>
        <!--offPageConnector-->
    </xsl:template>

    <xsl:template match="commentGraphics">
        <xsl:apply-templates select="boundingBox"/>
        <xsl:apply-templates select="figure"/>
        <xsl:apply-templates select="instance"/>
        <xsl:apply-templates select="annotate"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>
    <xsl:template match="designator">
        <xsl:apply-templates select="stringDisplay"/>
    </xsl:template>
    <xsl:template match="annotate">
        <xsl:apply-templates select="stringDisplay"/>
    </xsl:template>
    <xsl:template match="property">
        <xsl:apply-templates select="string|integer|number"/>
    </xsl:template>
    <xsl:template match="string">
        <xsl:apply-templates select="stringDisplay"/>
    </xsl:template>
    <xsl:template match="integer">
        <xsl:apply-templates select="integerDisplay"/>
    </xsl:template>
    <xsl:template match="number">
        <xsl:apply-templates select="numberDisplay"/>
    </xsl:template>

    <!--instance-->
    <xsl:template match="instance">
        <g>
            <xsl:for-each select="transform">
                <xsl:call-template name="_transform_figure"/>
            </xsl:for-each>
            <xsl:call-template name="instance_viewlist"/>
        </g>
        <xsl:apply-templates select="parameterAssign"/>
        <xsl:apply-templates select="portInstance"/>
        <xsl:apply-templates select="designator"/>
        <xsl:apply-templates select="property"/>
    </xsl:template>

    <xsl:template name="instance_viewlist">
        <xsl:for-each select="viewRef">
            <xsl:call-template name="instance_viewref"/>
        </xsl:for-each>
        <xsl:for-each select="viewList">
            <xsl:call-template name="instance_viewlist"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="_viewref_name">
        <xsl:if test="not (count(cellRef/libraryRef)=0)">
            <xsl:value-of select="cellRef/libraryRef/@name"/>
        </xsl:if>
        <xsl:if test="count(cellRef/libraryRef)=0">
            <xsl:value-of select="ancestor::node()/library/@name"/>
        </xsl:if>
        <xsl:text>-</xsl:text>
        <xsl:if test="not (count(cellRef)=0)">
            <xsl:value-of select="cellRef/@name"/>
        </xsl:if>
        <xsl:if test="count(cellRef)=0">
            <xsl:value-of select="ancestor::node()/cell/@name"/>
        </xsl:if>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="@name"/>
    </xsl:template>

    <xsl:template name="_viewref_call">
        <xsl:param name="kw"/>
        <xsl:apply-templates select="key('vwl',translate($kw,$lowercase,$uppercase))">
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template name="instance_viewref">
        <xsl:call-template name="_viewref_call">
            <xsl:with-param name="kw">
                <xsl:call-template name="_viewref_name"/>
                <!-- <xsl:if test="not (count(cellRef/libraryRef)=0)">
                    <xsl:value-of select="cellRef/libraryRef/@name"/>
                </xsl:if>
                <xsl:if test="count(cellRef/libraryRef)=0">
                    <xsl:value-of select="ancestor::node()/library/@name"/>
                </xsl:if>
                <xsl:text>-</xsl:text>
                <xsl:if test="not (count(cellRef)=0)">
                    <xsl:value-of select="cellRef/@name"/>
                </xsl:if>
                <xsl:if test="count(cellRef)=0">
                    <xsl:value-of select="ancestor::node()/cell/@name"/>
                </xsl:if>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="@name"/> -->
            </xsl:with-param>
        </xsl:call-template>
        <!-- <use>
            <xsl:attribute namespace="http://www.w3.org/1999/xlink" name="href">
                <xsl:text>#</xsl:text>
                <xsl:call-template name="_viewref_name"/>
            </xsl:attribute>
        </use> -->
    </xsl:template>

    <xsl:template match="portInstance">
        <xsl:apply-templates select="name"/>
        <!--TODO: string-->
        <xsl:apply-templates select="designator"/>
    </xsl:template>

    <!-- <xsl:template match="nameDef">
        <xsl:choose>
            <xsl:when test="not (count(name)=0)">
            </xsl:when>
            <xsl:when test="not (count(rename)=0)">
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="designator"/>
    </xsl:template> -->

    <xsl:template match="name|stringDisplay|integerDisplay|numberDisplay">
        <xsl:apply-templates select="display">
            <xsl:with-param name="s" select="text()"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="rename">
        <xsl:apply-templates select="display">
            <xsl:with-param name="s" select="text()"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="display">
        <xsl:param name="s" select="../text()"/>
        <g>
            <xsl:if test="not (count(origin)=0)">
                <xsl:call-template name="_transform_text"/>
            </xsl:if>
            <text>
                <xsl:attribute name="class">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
                <xsl:apply-templates select="figureGroupOverride"/>
                <xsl:call-template name="text-anchor"/>
                <xsl:apply-templates select="$s"/>
            </text>
            <circle r="1" fill="#0" stroke="red" stroke-width="1" cx="0" cy="0"/>
        </g>
    </xsl:template>

    <!--net-->
    <xsl:template match="net">
        <g stroke="black" stroke-width="1">
            <xsl:attribute name="id">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <!--joined-->
            <!--criticary-->
            <!--netDelay-->
            <xsl:apply-templates select="commonGraphics"/>
            <xsl:apply-templates select="figure"/>
            <xsl:apply-templates select="instance"/>
            <xsl:apply-templates select="net"/>
            <xsl:apply-templates select="property"/>
        </g>
    </xsl:template>

    <!--figureGroup/figureGroupOverride-->
    <xsl:template match="figureGroup">
        <xsl:value-of select="concat('.',@name,'{')"/>
        <xsl:call-template name="_style"/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="figureGroupOverride">
        <xsl:attribute name="class">
            <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="style">
            <xsl:call-template name="_style"/>
        </xsl:attribute>
    </xsl:template>

    <!--pt-border-->
    <xsl:template name="_border">
        <xsl:if test="not (count(pt)=0)">
            <path stroke-dasharray="2 2">
                <xsl:attribute name="d">
                    <xsl:text>M</xsl:text>
                    <xsl:call-template name="_pt_xs"/>
                    <xsl:text>,</xsl:text>
                    <xsl:call-template name="_pt_ys"/>
                    <xsl:text>L</xsl:text>
                    <xsl:call-template name="_pt_xe"/>
                    <xsl:text>,</xsl:text>
                    <xsl:call-template name="_pt_ys"/>
                    <xsl:text>L</xsl:text>
                    <xsl:call-template name="_pt_xe"/>
                    <xsl:text>,</xsl:text>
                    <xsl:call-template name="_pt_ye"/>
                    <xsl:text>L</xsl:text>
                    <xsl:call-template name="_pt_xs"/>
                    <xsl:text>,</xsl:text>
                    <xsl:call-template name="_pt_ye"/>
                    <xsl:text>Z</xsl:text>
                </xsl:attribute>
            </path>
        </xsl:if>
    </xsl:template>

    <xsl:template name="_pt_xs">
        <xsl:param name="d" select="5"/>
        <xsl:for-each select=".//pt">
            <xsl:sort select="number(substring-before(text(),' '))" data-type="number"/>
            <xsl:if test="position()=1">
                <xsl:value-of select="0+number(substring-before(text(),' '))-$d"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="_pt_xe">
        <xsl:param name="d" select="5"/>
        <xsl:for-each select=".//pt">
            <xsl:sort select="substring-before(text(),' ')" data-type="number" order="descending"/>
            <xsl:if test="position()=1">
                <xsl:value-of select="0+substring-before(text(),' ')+$d"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="_pt_dx">
        <xsl:param name="d" select="5"/>
        <xsl:call-template name="_pt_d">
            <xsl:with-param name="s">
                <xsl:call-template name="_pt_xs">
                    <xsl:with-param name="d">
                        <xsl:value-of select="$d"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="e">
                <xsl:call-template name="_pt_xe">
                    <xsl:with-param name="d">
                        <xsl:value-of select="$d"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_pt_ys">
        <xsl:param name="d" select="5"/>
        <xsl:for-each select=".//pt">
            <xsl:sort select="-substring-after(.,' ')" data-type="number"/>
            <xsl:if test="position()=1">
                <xsl:value-of select="0-substring-after(.,' ')-$d"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="_pt_ye">
        <xsl:param name="d" select="5"/>
        <xsl:for-each select=".//pt">
            <xsl:sort select="-substring-after(.,' ')" data-type="number" order="descending"/>
            <xsl:if test="position()=1">
                <xsl:value-of select="0-substring-after(.,' ')+$d"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="_pt_dy">
        <xsl:param name="d" select="5"/>
        <xsl:call-template name="_pt_d">
            <xsl:with-param name="s">
                <xsl:call-template name="_pt_ys">
                    <xsl:with-param name="d">
                        <xsl:value-of select="$d"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="e">
                <xsl:call-template name="_pt_ye">
                    <xsl:with-param name="d">
                        <xsl:value-of select="$d"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="_pt_d">
        <xsl:param name="s" select="0"/>
        <xsl:param name="e" select="0"/>
        <xsl:value-of select="0-$s+$e"/>
    </xsl:template>

    <!--vispble/textHeight-->
    <xsl:template name="_style">
        <xsl:call-template name="_lineStyle"/>
        <xsl:call-template name="_penType"/>
        <xsl:for-each select="textHeight/..">
            <xsl:text>font-size:</xsl:text>
            <xsl:value-of select="textHeight"/>
            <xsl:text>;</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="visible">
            <xsl:if test="count(.//false)=0">
                <xsl:text>visibility:visible;</xsl:text>
            </xsl:if>
            <xsl:if test="not (count(.//false)=0)">
                <!-- <xsl:text>visibility:hidden;</xsl:text> -->
                <xsl:text>visibility:visible;font-size:6;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!--pathWidth/boderWidth/cornerType/endType-->
    <xsl:template name="_lineStyle">
        <xsl:for-each select="pathWidth/..">
            <xsl:text>stroke-width:</xsl:text>
            <xsl:value-of select="1+(pathWidth)"/>
            <xsl:text>;</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="borderWidth/..">
            <xsl:text>stroke-width:</xsl:text>
            <xsl:value-of select="1+(borderWidth)"/>
            <xsl:text>;</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="cornerType">
            <xsl:value-of select="cornerType"/>
            <xsl:choose>
                <xsl:when test=".='EXTEND'">
                    <xsl:text>stroke-linejoin:bevel;</xsl:text>
                </xsl:when>
                <xsl:when test=".='ROUND'">
                    <xsl:text>stroke-linejoin:round;</xsl:text>
                </xsl:when>
                <xsl:when test=".='TRUNCATE'">
                    <xsl:text>stroke-linejoin:miter;</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
        <xsl:for-each select="endType">
            <xsl:choose>
                <xsl:when test=".='EXTEND'">
                    <xsl:text>stroke-linecap:square;</xsl:text>
                </xsl:when>
                <xsl:when test=".='ROUND'">
                    <xsl:text>stroke-linecap:round;</xsl:text>
                </xsl:when>
                <xsl:when test=".='TRUNCATE'">
                    <xsl:text>stroke-linecap:butt;</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!--color/fillPattern/borderPattern-->
    <xsl:template name="_penType">
        <xsl:for-each select="color/..">
            <xsl:text>stroke:</xsl:text>
            <xsl:call-template name="_color"/>
            <xsl:text>;</xsl:text>
            <xsl:text>fill:</xsl:text>
            <xsl:call-template name="_color"/>
            <xsl:text>;</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="fillPattern/..">
            <xsl:text>fill:</xsl:text>
            <xsl:if test="count(fillPattern//false)=0">
                <xsl:call-template name="_color"/>
            </xsl:if>
            <xsl:if test="not (count(fillPattern//false)=0)">
                <xsl:text>none</xsl:text>
            </xsl:if>
            <xsl:text>;</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="borderPattern/..">
            <xsl:text>fill:</xsl:text>
            <xsl:if test="count(borderPattern//false)=0">
                <xsl:call-template name="_color"/>
            </xsl:if>
            <xsl:if test="not (count(borderPattern//false)=0)">
                <xsl:text>none</xsl:text>
            </xsl:if>
            <xsl:text>;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="_color">
        <xsl:param name="rgb" select="color"/>
        <xsl:param name="r" select="round(2.55*substring-before($rgb,' '))"/>
        <xsl:param name="g" select="round(2.55*substring-before(substring-after($rgb,' '),' '))"/>
        <xsl:param name="b" select="round(2.55*substring-after(substring-after($rgb,' '),' '))"/>
        <xsl:value-of select="concat('rgb(',$r,',',$g,',',$b,')')"/>
    </xsl:template>

    <!--figure-->
    <xsl:template match="figure">
        <g>
            <xsl:attribute name="class">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:if test="not (count(figureGroupOverride)=0)">
                <xsl:apply-templates select="figureGroupOverride"/>
            </xsl:if>
            <xsl:apply-templates select="./*"/>
        </g>
    </xsl:template>

    <xsl:template name="_transform_figure">
        <xsl:param name="x" select="0+substring-before(origin/pt,' ')"/>
        <xsl:param name="y" select="0-substring-after(origin/pt,' ')"/>
        <xsl:param name="a" select="orientation/text()"/>
        <xsl:if test="not (count(origin)=0)">
            <xsl:attribute name="transform">
                <xsl:if test="not (count(origin)=0)">
                    <xsl:text>translate(</xsl:text>
                    <xsl:value-of select="$x"/>
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="$y"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:if test="not (count(orientation)=0)">
                    <xsl:if test="$a='R0'">
                        <xsl:text>rotate(0)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R90'">
                        <xsl:text>rotate(270)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R180'">
                        <xsl:text>rotate(180)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R270'">
                        <xsl:text>rotate(90)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MY'">
                        <xsl:text>scale(-1,1)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MX'">
                        <xsl:text>scale(1,-1)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MYR90'">
                        <xsl:text>scale(-1,1)rotate(270)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MXR90'">
                        <xsl:text>scale(1,-1)rotate(270)</xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:attribute>
        </xsl:if>
        <text x="0" y="-15" font-size="6">
            <xsl:value-of select="$a"/>
        </text>
    </xsl:template>

    <!--circle-->
    <!--TODO-->
    <xsl:template match="circle">
        <xsl:param name="x1" select="0+substring-before(pt[1],' ')"/>
        <xsl:param name="y1" select="0-substring-after(pt[1],' ')"/>
        <xsl:param name="x2" select="0+substring-before(pt[2],' ')"/>
        <xsl:param name="y2" select="0-substring-after(pt[2],' ')"/>
        <circle fill="none">
            <xsl:attribute name="cx">
                <xsl:value-of select="0.5*($x2+$x1)"/>
            </xsl:attribute>
            <xsl:attribute name="cy">
                <xsl:value-of select="0.5*($y2+$y1)"/>
            </xsl:attribute>
            <xsl:attribute name="r">
                <xsl:value-of select="(0.5*$x2)-(0.5*$x1)"/>
            </xsl:attribute>
        </circle>
    </xsl:template>

    <!--dot-->
    <xsl:template match="dot">
        <xsl:param name="x" select="0+substring-before(pt[1],' ')"/>
        <xsl:param name="y" select="0-substring-after(pt[1],' ')"/>
        <circle r="1" fill="#0">
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
    <!--TODO-->
    <xsl:template match="polygon">
        <path>
            <xsl:attribute name="d">
                <xsl:text>M</xsl:text>
                <xsl:apply-templates select="pointList/pt"/>
                <xsl:text>Z</xsl:text>
            </xsl:attribute>
        </path>
    </xsl:template>

    <!--rectangle-->
    <xsl:template match="rectangle">
        <xsl:param name="x1" select="0+substring-before(pt[1],' ')"/>
        <xsl:param name="y1" select="0-substring-after(pt[1],' ')"/>
        <xsl:param name="x2" select="0+substring-before(pt[2],' ')"/>
        <xsl:param name="y2" select="0-substring-after(pt[2],' ')"/>
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
        <xsl:param name="x" select='0+substring-before(text()," ")'/>
        <xsl:param name="y" select='0-substring-after(text()," ")'/>
        <xsl:text>&#32;</xsl:text>
        <xsl:value-of select="$x"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="$y"/>
    </xsl:template>

    <!--shape/openShape-->
    <xsl:template match="sharpe|openShape">
        <xsl:apply-templates select="curve"/>
    </xsl:template>
    <xsl:template match="curve">
        <xsl:apply-templates select="arc"/>
    </xsl:template>
    <xsl:template match="arc">
        <xsl:param name="x1" select="0+substring-before(pt[1],' ')"/>
        <xsl:param name="y1" select="0-substring-after(pt[1],' ')"/>
        <xsl:param name="x2" select="0+substring-before(pt[2],' ')"/>
        <xsl:param name="y2" select="0-substring-after(pt[2],' ')"/>
        <xsl:param name="x3" select="0+substring-before(pt[3],' ')"/>
        <xsl:param name="y3" select="0-substring-after(pt[3],' ')"/>
        <path fill="none">
            <xsl:attribute name="d">
                <xsl:text>M</xsl:text>
                <xsl:value-of select="$x1"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y1"/>
                <xsl:text>Q</xsl:text>
                <xsl:value-of select="-0.5*($x3+$x1)+2*$x2"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="-0.5*($y3+$y1)+2*$y2"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$x3"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$y3"/>
            </xsl:attribute>
        </path>
    </xsl:template>

    <xsl:template name="_transform_text">
        <xsl:param name="x" select="0+substring-before(origin/pt,' ')"/>
        <xsl:param name="y" select="0-substring-after(origin/pt,' ')"/>
        <xsl:param name="a" select="orientation/text()"/>
        <xsl:if test="not (count(origin)=0)">
            <xsl:attribute name="transform">
                <xsl:if test="not (count(origin)=0)">
                    <xsl:text>translate(</xsl:text>
                    <xsl:value-of select="$x"/>
                    <xsl:text>,</xsl:text>
                    <xsl:value-of select="$y"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:if test="not (count(orientation)=0)">
                    <xsl:if test="$a='R0'">
                        <xsl:text>rotate(0)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R90'">
                        <xsl:text>rotate(270)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R180'">
                        <xsl:text>rotate(180)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='R270'">
                        <xsl:text>rotate(90)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MY'">
                        <xsl:text>scale(-1,1)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MX'">
                        <xsl:text>scale(1,-1)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MYR90'">
                        <xsl:text>rotate(90)scale(-1,1)</xsl:text>
                    </xsl:if>
                    <xsl:if test="$a='MXR90'">
                        <xsl:text>rotate(90)scale(1,-1)</xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:attribute>
        </xsl:if>
        <!-- <text x="0" y="-15" font-size="6">
            <xsl:value-of select="$a"/>
        </text> -->
    </xsl:template>

    <xsl:template match="keywordDisplay">
        <xsl:param name="name" select="../name/text()"/>
        <xsl:param name="kw" select="text()"/>
        <xsl:if test="not (count(display)=0)">
            <xsl:if test="name()=$kw">
                <!-- display -->                <!--TODO-->
                <!-- <text font-size="50%">
                    <xsl:for-each select="../../../port[@name=$name]/*">
                        <xsl:value-of select="text()"/>
                    </xsl:for-each>
                </text> -->
            </xsl:if>
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
        <xsl:param name="h" select="10"/>
        <xsl:if test="string-length($s)">
            <tspan x="0">
                <xsl:attribute name="y">
                    <xsl:value-of select="$y"/>
                </xsl:attribute>
                <xsl:value-of select="substring-before(concat($s,'&#10;'),'&#10;')"/>
            </tspan>
            <xsl:call-template name="text-area">
                <xsl:with-param name="s" select="substring-after($s, '&#10;')"/>
                <xsl:with-param name="y" select="number($y)+$h"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
