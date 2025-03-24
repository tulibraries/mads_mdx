<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oai_qdc="http://worldcat.org/xmlschemas/qdc-1.0/"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    version="2.0">
    <xsl:output omit-xml-declaration="no" method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="text() | @*"/>
        
    <xsl:template match="oai_qdc:qualifieddc[(dcterms:isPartOf[contains(string(), 'In Her Own Right: Women Asserting Their Civil Rights, 1820-1920')])]">
        <oai_qdc:qualifieddc>
        <xsl:apply-templates/>
        </oai_qdc:qualifieddc>
    </xsl:template>
    
    <xsl:template match="oai_qdc:qualifieddc[(dcterms:isPartOf[contains(string(), 'In Her Own Right: Women Asserting Their Civil Rights, 1820-1920')])]/*">
        <xsl:element name="{name()}">
            <xsl:value-of select="normalize-space(.)" />
        </xsl:element>      
    </xsl:template>
    
    
</xsl:stylesheet>
