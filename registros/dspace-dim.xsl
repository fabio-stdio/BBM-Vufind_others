<!-- available fields are defined in solr/biblio/conf/schema.xml -->
<!-- This document was write for Biblioteca Brasiliana Guita e José Mindlin by Fabio Chagas da Silva (fabio.chagas.silva@usp.br) take metadata directly from dim to index in solr based on the dspace.xsl found in the Vufind wiki page -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmls:dim="http://www.dspace.org/xmlns/dspace/dim"
    xmlns:php="http://php.net/xsl"
    xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:param name="institution">BBM Digital</xsl:param>
    <xsl:param name="collection">Pública Digital</xsl:param>
    <xsl:template match="dim:dc">
    	<add>
    		<doc>
    			<-- ID -->
    			<-- Important: This relies on an <identifier> tag being injected by the OAI-PMH harvester. -->
    			<field name="id">
    				<xsl:value-of select="//identifier"/>
    			</field>
    			<!-- RECORDTYPE -->
    			<field name="recordtype">dspace</field>

    			<!-- ALLFIELDS -->
    			<field name="allfields">
    				<xsl:value-of select="normalize-space(string(//dim))"/>
    			</field>

    			<!-- INSTITUTION -->
    			<field name="instituition">
    				<xsl:value-of select="$institution" />
    			</field>

    			<!-- COLLECTION -->
    			<field name="collection">
    				<xsl:value-of select="$collection" />
    			</field>


    			<!-- AUTHOR -->	
    			<xsl:if test="//dim:field[@element="contribuitor" and @qualifier="author"]">
    				<field name="author>
    					<xsl:value-of select="//dim:field[@element="contribuitor" and @qualifier="author"]"/>
    				</field>
    			</xsl:if>


    			

