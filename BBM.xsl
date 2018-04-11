<!-- available fields are defined in solr/biblio/conf/schema.xml -->
<!-- Adapted from / Author: Filipe M S Bento <filben@gmail.com; fsb@ua.pt> -->
<!-- Adapted by / Author: Fábio C. da Silva <fabio.chagas.silva@usp.br> -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:php="http://php.net/xsl"
    xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:param name="institution">BBM Digital</xsl:param>
    <xsl:param name="collection">Pública Digital</xsl:param>
    <xsl:param name="building"></xsl:param>
    <xsl:param name="urlPrefix">https</xsl:param>
	<xsl:template match="oai_dc:dc">
        <add>
            <doc>
                <!-- ID -->
                <!-- Important: This relies on an <identifier> tag being injected by the OAI-PMH harvester. -->
                <field name="id">
                    <xsl:value-of select="//identifier"/>
                </field>

                <!-- RECORDTYPE -->
                <field name="recordtype">PDF</field>

                <!-- FULLRECORD -->
                <!-- disabled for now; records are so large that they cause memory problems!
                <field name="fullrecord">
                    <xsl:copy-of select="php:function('VuFind::xmlAsText', //oai_dc:dc)"/>
                </field>
                  -->

                <!-- ALLFIELDS -->
                <field name="Todos os campo">
                    <xsl:value-of select="normalize-space(string(//oai_dc:dc))"/>
                </field>

                <!-- INSTITUTION -->
                <field name="institution">
                    <xsl:value-of select="$institution" />
                </field>

                <!-- COLLECTION -->
                <field name="collection">
                    <xsl:value-of select="$collection" />
                </field>

                <!-- building -->
                <field name="building">
                    <xsl:value-of select="$building" />
                </field>

                <!-- LANGUAGE -->
                <xsl:if test="//dc:language">
                    <xsl:for-each select="//dc:language">
                        <xsl:if test="string-length() > 0">
                            <field name="language">
                                <!--
                                <xsl:value-of select="php:function('VuFind::mapString', normalize-space(string(.)), 'language_map_oai_utf8.properties')"/>
                                -->
                                <xsl:value-of select="php:function('VuFind::mapString', normalize-space(string(.)), 'language_map_iso639-1.properties')"/>
                            </field>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>

                
                <!-- FORMAT / TYPE -->
                					
				
				<xsl:choose>
					<xsl:when test="(//dc:type = 00) and (//dc:relation != 'ISBN:0') and (//dc:description = '1') " >
									<field name="format">Livro</field>
					</xsl:when>
					<xsl:when test="(contains(//dc:identifier, 'articles/show/title'))">
									<field name="format">Book Part</field>
					</xsl:when>


					<xsl:when test="//dc:relation = 'ISBN:0'">
									<field name="format">Article</field>
					</xsl:when>
					
				
					<xsl:otherwise>
						<field name="format">Book Part</field>
					</xsl:otherwise>
			
				</xsl:choose>
				

				<field name="format">Online</field>
				

                <!-- SUBJECT -->
                <xsl:if test="//dc:subject">
                    <xsl:for-each select="//dc:subject">
                        <xsl:if test="string-length() > 0">
                            <field name="topic">
                                <xsl:value-of select="normalize-space()"/>
                            </field>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>

			<!-- DESCRIPTION -->
			
                <xsl:if test="(contains(//dc:identifier, 'articles/show/title') and (//dc:description != '1'))">
					<field name="description">&lt;b&gt;<xsl:if test="//dc:subject"><xsl:value-of select="//dc:subject"/>&lt;/b&gt; </xsl:if> <xsl:if test="//dc:type &gt; 00">, Chap. <xsl:value-of select="//dc:type"/></xsl:if><xsl:if test="//dc:description">:&lt;br&gt;<xsl:value-of select="//dc:description"/></xsl:if></field>
				</xsl:if>					    								 
				<xsl:if test="((//dc:type &lt; 1) and (//dc:description != '1'))">
					<xsl:if test="//dc:description"><field name="description"><xsl:value-of select="//dc:description"/></field></xsl:if>
				</xsl:if>	
				
				

                <!-- ADVISOR / CONTRIBUTOR -->
                <xsl:if test="//dc:contributor[normalize-space()]">
                    <field name="author2">
                        <xsl:value-of select="php:function('VuFind::InverteNome', //dc:contributor[normalize-space()]" />
                    </field>
                </xsl:if>


                <!-- AUTHOR -->
                <xsl:if test="//dc:creator">
                    <xsl:for-each select="//dc:creator">
                        <xsl:if test="normalize-space()">
                            <field name="author">
                                <xsl:value-of select="php:function('VuFind::InverteNome', normalize-space())"/>
                            </field>
                            <!-- use first author value for sorting -->
                            <xsl:if test="position()=1">
                                <field name="author_sort">
                                     <xsl:value-of select="php:function('VuFind::InverteNome', normalize-space())"/>
                                </field>
                            </xsl:if>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>

                <!-- TITLE -->
                <xsl:if test="//dc:title[normalize-space()]">
                    <field name="title">
                        <xsl:value-of select="//dc:title[normalize-space()]"/>
                    </field>
                    <field name="title_short">
                        <xsl:value-of select="//dc:title[normalize-space()]"/>
                    </field>
                    <field name="title_full">
                        <xsl:value-of select="//dc:title[normalize-space()]"/>
                    </field>
                    <field name="title_sort">
                        <xsl:value-of select="php:function('VuFind::stripArticles', string(//dc:title[normalize-space()]))"/>
                    </field>
                </xsl:if>

                <!-- PUBLISHER -->
                <xsl:if test="//dc:publisher[normalize-space()]">
                    <field name="publisher">
                        <xsl:value-of select="//dc:publisher[normalize-space()]"/>
                    </field>
                </xsl:if>

                <!-- PUBLISHDATE -->
                <xsl:if test="//dc:date">
                    <field name="publishDate">
                        <xsl:value-of select="substring(//dc:date, 1, 4)"/>
                    </field>
                        <field name="publishDateSort">
                        <xsl:value-of select="substring(//dc:date, 1, 4)"/>
                    </field>
                </xsl:if>

				
				<!-- ISBN -->
                <xsl:if test="//dc:relation">
					<xsl:if test="(contains(//dc:relation,'ISBN:'))">
						<xsl:if test="//dc:relation != 'ISBN:0'">
							<field name="issn">
								<xsl:value-of select="substring(//dc:relation, 6, 30)"/>
							</field>
						</xsl:if>
				    </xsl:if>
                </xsl:if>
				
					
				
				<!-- PDF URL of the book chapter-->
				<xsl:if test="//dc:source">							
					  <xsl:if test="contains(//dc:source,'://')">
						   <field name="url"><xsl:value-of select="//dc:source" />
					       </field>
					   </xsl:if>
				</xsl:if>
				
				
				<!-- PDF URL of the entire e-book-->
				<xsl:if test="(contains(//dc:identifier, 'articles/show/title') and (//dc:description != '1'))">
					<xsl:if test="//dc:relation">							
							   <field name="url">http://www.intechopen.com/download/books/books_isbn/<xsl:value-of select="substring(//dc:relation, 6, 30)"/>
							   </field>
						  
					</xsl:if>	
				</xsl:if>	
				
				<!-- container_title => Book Title = dc:subject | only if it has <dc:relation>ISBN:0</dc:relation> = journal article -->
<!--
				<xsl:if test="//dc:relation = 'ISBN:0'">
					<xsl:if test="//dc:subject">
				        <field name="container_title">
						   <xsl:value-of select="//dc:subject"/> 
						</field>		
					</xsl:if>	
				</xsl:if>	
-->			   
            </doc>
        </add>
    </xsl:template>
</xsl:stylesheet>