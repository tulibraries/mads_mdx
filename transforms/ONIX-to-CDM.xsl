<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="text() | @*"/>
    
    <xsl:template match="/ONIXMessage">
        <collection>
            <xsl:apply-templates select="Product" />
        </collection>
    </xsl:template>
    
    <xsl:template match="//Product">
        <record>
            <xsl:apply-templates/>
        </record>
    </xsl:template>
    
    
    <!-- Discount Code for flagging Trade Titles-->
    
    <xsl:template match="//SupplyDetail[1]/Price[1]/DiscountCoded[1]/DiscountCode[1]">
        <Discount>
            <xsl:value-of select="."/>
        </Discount>      
    </xsl:template>
            
            <!-- Title -->
    
    <xsl:template match="Title">
        <Title>
            <xsl:value-of select="TitleText"/>         
        </Title>
        <xsl:if test="Subtitle">
            <Subtitle>
            <xsl:value-of select="Subtitle"/>
            </Subtitle>
        </xsl:if>
    </xsl:template>         
            
            <!-- Date -->
    
    <xsl:template match="CopyrightYear">
        <CopyrightYear>
            <xsl:value-of select="."/>
        </CopyrightYear>
    </xsl:template>
    
    <xsl:template match="PublicationDate">
        <PublicationDate>
            <xsl:value-of select="."/>
        </PublicationDate>
    </xsl:template>
            
            <!-- Author and Contributors-->
    
    <!--
    <xsl:template match="//ContributorRole[.='A01']">
        <Author>
        <xsl:call-template name="join">    
            <xsl:with-param name="valueList" select="parent::PersonalNameInverted"/>       
            <xsl:with-param name="separator" select="' ; '"/>           
        </xsl:call-template>
        </Author>
    </xsl:template>-->
    

    <xsl:template match="Contributor">      
        <xsl:choose>          
            <xsl:when test="ContributorRole[.='A01']">
                <Author>
                    <xsl:value-of select="PersonNameInverted"/>
                </Author>
            </xsl:when>
            <xsl:when test="ContributorRole[.='B01']">
                <ContributorEditor>
                    <xsl:value-of select="PersonNameInverted"/>
                </ContributorEditor>
            </xsl:when>
            <xsl:otherwise>
                <ContributorOther>
                    <xsl:value-of select="PersonNameInverted"/>
                </ContributorOther>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

            
            <!-- Series -->
    
    <xsl:template match="Series">
        <Series>
            <xsl:value-of select="TitleOfSeries"/>
        </Series>
    </xsl:template>
            
            <!-- Identifiers -->
    
    <xsl:template match="//Product/ProductIdentifier">
        <xsl:choose>
            <xsl:when test="ProductIDType[.='15']">
                <EISBN>
                    <xsl:value-of select="IDValue"/>
                </EISBN>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//RelatedProduct/ProductIdentifier">
        <xsl:choose>
            <xsl:when test="ProductIDType[.='15']">
                <ISBN>
                    <xsl:value-of select="IDValue"/>
                </ISBN>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!--
    <xsl:template name="join">          
            <xsl:param name="valueList" select="''"/>            
            <xsl:param name="separator" select="' ; '"/>           
            <xsl:for-each select="$valueList">            
                <xsl:choose>                    
                    <xsl:when test="position() = 1">                        
                        <xsl:value-of select="."/>                       
                    </xsl:when>                   
                    <xsl:otherwise>                
                        <xsl:value-of select="concat($separator, .) "/>                       
                    </xsl:otherwise>                    
                </xsl:choose>                
            </xsl:for-each>                  
    </xsl:template>-->
            
            
</xsl:stylesheet>