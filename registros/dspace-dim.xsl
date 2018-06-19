<!-- available fields are defined in solr/biblio/conf/schema.xml -->
<!-- This document was write for Biblioteca Brasiliana Guita e José Mindlin by Fabio Chagas da Silva (fabio.chagas.silva@usp.br). It take metadata directly from dim to index in solr. Based on the dspace.xsl found in the Vufind wiki page -->

<!-- The choices of fields was made based on which metadata is most interesting for the user of the library and which solr fileds in schema.xml is close to teh metadata of choice. Those choices were made supervised by the lybrarian of Brasiliana Guita e José Mindlin, Rodrigo Garcia (garcia.rodrigo@gmail.com). -->


<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
    xmlns:php="http://php.net/xsl"
    xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:param name="institution">BBM Digital</xsl:param>
    <xsl:param name="collection">Pública Digital</xsl:param>
    <xsl:param name="url">https://digital.bbm.usp.br/handle/</xsl:param>
    <xsl:template match="dim:dim">
    	<add>
    		<doc>
    			<!-- Those fields are exactly like in the dspace.xls found in vufind wiki page: (https://github.com/vufind-org/vufind/blob/master/import/xsl/dspace.xsl), except for the tags -->

    			<!-- ID -->
    			<!-- Important: This relies on an <identifier> tag being injected by the OAI-PMH harvester. -->
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
    			<xsl:if test= "//dim:field[@element='title']">
    				<field name="title">
    					<xsl:value-of select="//dim:field[@element='title']"/>
    				</field>
    			</xsl:if>


    			<!-- All fields with repeatetive metadata info, was used for-each loop within the solr field and the function concat, to concatenate those values with new line character -->


    			<!-- AUTHOR -->	
    			<xsl:if test="//dim:field[@element='contributor' and @qualifier='author']">
    				<field name="author">
    					<xsl:for-each select="//dim:field[@element='contributor' and @qualifier='author']">
    						<xsl:value-of select="concat(., '&#xA;')"/>
    					</xsl:for-each>
    				</field>
    			</xsl:if>


    			<!-- CO AUTHOR -->
    			<xsl:if test="//dim:field[@element='contributor' and @qualifier='other']">
    				<field name="author2">
    					<xsl:for-each select="//dim:field[@element='contributor' and @qualifier='other']">
    						<xsl:value-of select="concat(., '&#xA;')"/>
    					</xsl:for-each>
    				</field>
    			</xsl:if>


    			<!-- SUBJECT -->
    			<xsl:if test="//dim:field[@element='subject']">
    				<field name="topic">
    					<xsl:for-each select="//dim:field[@element='subject']">
    						<xsl:value-of select="concat(., '&#xA;')"/>
    					</xsl:for-each>
    				</field>
    			</xsl:if>

    			<!-- Published Date -->
    			<xsl:if test="//dim:field[@element='date' and @qualifier='issued']">
    				<field name="publishDate">
    					<xsl:value-of select="//dim:field[@element='date' and @qualifier='issued']"/>
    				</field>
    			</xsl:if>

    			<!-- Language -->
    			<xsl:if test="//dim:field[@element='language' and @qualifier='iso']">
    				<field name="language">
    					<xsl:value-of select="//dim:field[@element='language' and @qualifier='iso']"/>
    				</field>
    			</xsl:if>

    			<!-- Publisher -->
    			<xsl:if test="//dim:field[@element='publisher']">
    				<field name="publisher">
    					<xsl:value-of select="//dim:field[@element='publisher']"/>
    				</field>
    			</xsl:if>

    			<!-- Format -->
    			<xsl:if test="//dim:field[@element='format' and @qualifier='medium']">
    				<field name="physical">
    					<xsl:value-of select="//dim:field[@element='format' and @qualifier='medium']"/>
    				</field>
    			</xsl:if>

    			<!-- Type -->
    			<xsl:if test="//dim:field[@element='type']">
    				<field name="format">
    					<xsl:value-of select="//dim:field[@element='type']"/>
    				</field>
    			</xsl:if>

    			<!-- Abstract -->
    			<!-- The abstract field was assigned for a dynamid field *_txt of test type -->
    			<xsl:if test="dim:field[@element='description' and @qualifier='abstract']">
    				<field name="abstract_txtP">
    					<xsl:value-of select="dim:field[@element='description' and @qualifier='abstract']"/>
    				</field>
    			</xsl:if>


    			<!-- Aternative Title -->
    			<xsl:if test="//dim:field[@element='title' and @qualifier='alternative']">
    				<field name="title_alt">
    					<xsl:for-each select="//dim:field[@element='title' and @qualifier='alternative']">
    						<xsl:value-of select="concat(., '&#xA;')"/>
    					</xsl:for-each>
    				</field>
    			</xsl:if>


    			<!-- Description -->
    				<!--PORT-->
    				<!-- Foi modificado e colocado 2 blocos IF para que não seja impresso o dim:field[@element='description' and @qualifier='provenance'] -->
    				<!-- Não imprime somente o campo  dim:field[@element='description'], mas não sei o porque. Foi forçado a impressão como visto na linha 152-->

    				<!-- Foi incluido o carctere "pula linha" para o XSLT logo após ele imprimir somente o description.
    					Dentro do laço for-each foi incluido o segundo bloco if para inspeção do atributo qualifier, para que não fosse provenance.
    					Após pegar os valores dentro de description para elemento, concatenava todos os que seriam impressos com o caracter "pula linha". -->


    				<!--ENG-->
    				<!-- Two if block was used in description, one for check its existence e another, within the for-each loop for not print a dim:field[@element='description' and @qualifier='provenance']. -->
    				<!-- Although, the field with only attribute @element='description' doesn't print, a not elegant solution was found and implemented in line 152 -->

    				<!-- It was included a text tag for new line character after print de value in the field with the attribute @element='description' only.
    					Within the for-each loop was included (as mentioned earlier) an if block. After print all values with description, except for description and provenance, concatenate with new line character. -->
    			

    			<xsl:if test="//dim:field[@element='description']">
    				<field name="description">
    					<xsl:value-of select="//dim:field[@element='description'] "/><xsl:text>&#xa;</xsl:text>
    					<xsl:for-each select="//dim:field[@element='description']">
    						<xsl:if test="@qualifier != 'provenance' and @qualifier != 'abstract' and @qualifier != 'tableofcontents'">
    							<xsl:value-of select="concat(., '&#xA;')"/>
    						</xsl:if>
    					</xsl:for-each>
    				</field>	
    			</xsl:if>

    			


    			<!-- Volume (dc.relation.requires) -->
    			<xsl:if test="//dim:field[@element='relation' and @qualifier='requires']">
    				<field name="container_volume">
    					<xsl:value-of select="//dim:field[@element='relation' and @qualifier='requires']"/>
    				</field>
    			</xsl:if>

    			<!-- Table of contents -->
    			<xsl:if test="//dim:field[@element='description' and @qualifier='tableofcontents']">
    				<field name="contents">
    					<xsl:value-of select="//dim:field[@element='description' and @qualifier='tableofcontents']"/>
    				</field>
    			</xsl:if>

    			<!-- Spatial -->
    			<xsl:if test="//dim:field[@qualifier='spatial']">
    				<field name="geographic_facet">
    					<xsl:for-each select="//dim:field[@qualifier='spatial']">
    						<xsl:value-of select="concat(., '&#xA;')"/>
    					</xsl:for-each>
    				</field>
    			</xsl:if>

    			<!-- ISBN -->
    			<xsl:if test="//dim:field[@qualifier='isbn']">
    				<field name="isbn">
    					<xsl:value-of select="//dim:field[@qualifier='isbn']"/>
    				</field>
    			</xsl:if>

    			<!-- ISSN -->
    			<xsl:if test="//dim:field[@qualifier='issn']">
    				<field name="issn">
    					<xsl:value-of select="//dim:field[@qualifier='issn']"/>
    				</field>
    			</xsl:if>

    			<!-- Periodicity -->
    			<!--<xsl:if test="//dim:field[@element='accrualPeridicity']">
    				<field name="">
    					<xsl:for-each select="//dim:field[@element='accrualPeridicity']">
    						<xsl:value-of select="concat(., '&#xA;')"/>
    					</xsl:for-each>
    				</field>
    			</xsl:if> -->

    			<!-- URL -->
    			<!-- Due some troubles with the maintenance of the internet permalink services with handle, the library has no longer those links, but DSpace still address those links for the object in the metadata. To solve this a new parameter for url was created and used for the right url which the digital object is. Check the existence of metadata but use the variables to construct the right url. -->

    			<xsl:if test="//dim:field[@element='identifier' and @qualifier='uri']">
    				<xsl:variable name="id_num" select="substring(//dim:field[@element='identifier' and @qualifier='uri'], 23)"/>
    				<field name="url">
    					<xsl:value-of select="concat($url, $id_num)"/>
    				</field>
    			</xsl:if>
			</doc>
    	</add>
    </xsl:template>
</xsl:stylesheet>




