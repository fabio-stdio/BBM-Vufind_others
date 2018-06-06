<!-- available fields are defined in solr/biblio/conf/schema.xml -->
<!-- This document was write for Biblioteca Brasiliana Guita e José Mindlin by Fabio Chagas da Silva (fabio.chagas.silva@usp.br). It take metadata directly from dim to index in solr. Based on the dspace.xsl found in the Vufind wiki page -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmls:dim="http://www.dspace.org/xmlns/dspace/dim"
    xmlns:php="http://php.net/xsl"
    xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:param name="institution">BBM Digital</xsl:param>
    <xsl:param name="collection">Pública Digital</xsl:param>
    <xsl:param name="url">https://digital.bbm.usp.br/handle/</xsl:param>
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


    			<!-- TITLE -->
    			<xsl:if test="//dim:field[@element="title"]">
    				<field name="title">
    					<xsl:value-of select="//dim:field[@element="title"]"/>
    				</field>
    			</xsl:if>


    			<!-- AUTHOR -->	
    			<xsl:if test="//dim:field[@element="contribuitor" and @qualifier="author"]">
    				<field name="author">
    					<xsl:value-of select="//dim:field[@element="contribuitor" and @qualifier="author"]"/>
    				</field>
    			</xsl:if>


    			<!-- CO AUTHOR -->
    			<xsl:if test="//dim:field[@element="contribuitor" and @qualifier="other"]">
    				<field name="author2">
    					<xsl:value-of select="//dim:field[@element="contribuitor" and @qualifier="other"]"/>
    				</field>
    			</xsl:if>


    			<!-- SUBJECT -->
    			<xsl:if test="//dim:field[@element="subject"]">
    				<field name="topic">
    					<xsl:value-of select="//dim:field[@element="subject"]"/>
    				</field>
    			</xsl:if>

    			<!-- Published Date -->
    			<xsl:if test="//dim:field[@element="date" and @qualifer="issued"]">
    				<field name="publishDate">
    					<xsl:value-of select="//dim:field[@element="date" and @qualifer="issued"]"/>
    				</field>
    			</xsl:if>

    			<!-- Language -->
    			<xsl:if test="//dim:field[@element="language" and @qualifier="iso"]">
    				<field name="language">
    					<xsl:value-of select="//dim:field[@element="language" and @qualifier="iso"]"/>
    				</field>
    			</xsl:if>

    			<!-- Publisher -->
    			<xsl:if test="//dim:field[@element="publisher"]">
    				<field name="publisher">
    					<xsl:value-of select=""//dim:field[@element="publisher"]"/>
    				</field>
    			</xsl:if>

    			<!-- Format -->
    			<xsl:if test="//dim:field[@element="format" and @qualifier="medium"]">
    				<field name="physical">
    					<xsl:value-of select="//dim:field[@element="format" and @qualifier="medium"]"/>
    				</filed>
    			</xsl:if>

    			<!-- Tyoe -->
    			<xsl:if test="//dim:field[@element="type"]">
    				<field name="format">
    					<xsl:value-of select="//dim:field[@element="type"]"/>
    				</field>
    			</xsl:if>

    			<!-- Abstract -->


    			<!-- Aternative Title -->
    			<xsl:if test="//dim:field[@element="title" and @qualifier="alternative"]">
    				<field name="title_alt">
    					<xsl:value-of select="//dim:field[@element="title" and @qualifier="alternative"]"/>
    				</field>
    			</xsl:if>


    			<!-- Description -->
    			<xsl:if test="//dim:field[@element="description"]">
    				<field name="description">
    					<xsl:value-of select="//dim:field[@element="description"]"/>
    				</field>
    			</xsl:if>

    			<!-- Volume (dc.relation.isPartOf) -->
    			<xsl:if test="//dim:field[@qualifier="ispartofseries"]">
    				<field name="container_volume">
    					<xsl:value-of select="//dim:field[@qualifier="ispartofseries"]"/>
    				</field>
    			</xsl:if>

    			<!-- Table of contents -->
    			<xsl:if test="//dim:field[@element="description" and @qualifier="tableofcontents"]">
    				<field name="contents">
    					<xsl:value-of select="//dim:field[@element="description" and @qualifier="tableofcontents"]"/>
    				</field>
    			</xsl:if>

    			<!-- Spatial -->
    			<xsl:if test="//dim:field[@qualifier="spatial"]">
    				<field name="geographic_facet">
    					<xsl:value-of select="//dim:field[@qualifier="spatial"]"/>
    				</field>
    			</xsl:if>

    			<!-- ISBN -->
    			<xsl:if test="//dim:field[@qualifier="isbn"]">
    				<field name="isbn">
    					<xsl:value-of select="//dim:field[@qualifier="isbn"]"/>
    				</field>
    			</xsl:if>

    			<!-- ISSN -->
    			<xsl:if test="//dim:field[@qualifier="issn"]">
    				<field name="issn">
    					<xsl:value-of select="//dim:field[@qualifier="issn"]"/>
    				</field>
    			</xsl:if>

    			<!-- Periodicity -->
    			<!--<xsl:if test="//dim:field[@element="accrualPeridicity"]">
    				<field name="">
    					<xsl:value-of select="//dim:field[@element="accrualPeridicity"]"/>
    				</field>
    			</xsl:if> -->

    			<!-- URL -->
    			<xsl:if test="//dim:field[@element="relation" and @qualifier="requires"]">
    				<field name="url">
    					<xsl:value-of select="concat($url, $//dim:field[@element="relation" and @qualifier="requires"])"/>
    				</field>
    			</xsl:if>

    		</doc>
    	</add>
    </xsl:template>
</xsl:stylesheet>




