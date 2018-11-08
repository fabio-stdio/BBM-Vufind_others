
'''Este arquivo é parte do programa marc2dc

marc2dc é um software livre; você pode redistribuí-lo e/ou
modificá-lo dentro dos termos da Licença Pública Geral GNU como
publicada pela Fundação do Software Livre (FSF); na versão 3 da
Licença, ou (a seu critério) qualquer versão posterior.

Este programa é distribuído na esperança de que possa ser útil,
mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO
a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
Licença Pública Geral GNU para maiores detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral GNU junto
com este programa, Se não, veja <http://www.gnu.org/licenses/>.
'''

import urllib
import urllib.parse
import urllib.request 
import io
import os
import glob
import doctest
import xml.etree.ElementTree as ET
from xml.etree.ElementTree import ElementTree
from xml.etree.ElementTree import Element

# Todos os campos de metadados do Dublin Core que é interessante para a biblioteca digital que será extraido do Marc21.

DC_metadados = [["dc.contributor.author", "dc.title.alternative", "dc.title", "dc.title.alternative", "dc.description.version", "dc.coverage.spatial", "dc.publisher.city",
				"dc.publisher", "dc.date.issued", "dc.date.created", "dc.format.medium", "dc.accrualPeriodicity", "dc.relation.ispartof", "dc.description",
				"dc.description.tableofcontents", "dcterms.access.rights", "dc.relation.isreferencedby", "dc.description.abstract", "dcterms.audience", "dcterms.hasFormat", 
				 "dc.relation.uri", "dc.relation.requires", "dcterms.accrualMethod", "dc.date.copyright", "dc.rights.holder", "dc.language", "dcterms.provenance", 
				 "dc.description.localnote", "dc.subject.personalname", "dc.subject", "dc.coverage.temporal", "dc.type", "dc.contributor.other", "dc.contributor", 
				 "dc.relation.haspart", "dc.relation.replaces", "dc.relation.isreferencedby", "dc.identifier.url", "dc.identifier.url", "dc.identifier.barcode", 
				 "dc.identifier.dedalus", "dc.identifier.isbn", "dc.identifier.issn", "dc.identifier.doi", "dc.language.iso", "dc.language", "dc.subject.lcc", "dc.subject.ddc"][]]


#Função para coletar os metadados do objeto.
def parse(num_dedalus):

	try:
		url = "http://dedalus.usp.br/OAI-script?verb=GetRecord&identifier=SET_BBM-"+num_dedalus+"&metadataPrefix=marc21"

		# now, with the below headers, we defined ourselves as a simpleton who is
		# still using internet explorer.
		headers = {}
		headers['User-Agent'] = "Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.27 Safari/537.17"
		req = urllib.request.Request(url)
		resp = urllib.request.urlopen(req)
		respData = resp.read()
		respDataUTF_8 = respData.decode('utf-8')

		'''saveFile = open('marc'+num_dedalus+'.xml','w')
		saveFile.write(str(respDataUTF_8))
		saveFile.close()
		'''
		return respDataUTF_8


	except Exception as e:
		print(str(e))




''' A partir daqui o código foi desenvolvido quase que inteiramente por Fábio Chagas da Silva (fabio.chagas.silva@usp.br), com base no programa de mesma função
escrito em Java pelo o ICMCC - USP São Carlos. Referências serão feitas ao longo do código quando os trechos usados foram feitos por outros. A licensa do uso
desse código é GNU General License como explicado acima.'''


def escreve_xml(data):
# Solução encontrada no stack overflow em 8 de novembro de 2018 em:
#  https://stackoverflow.com/questions/17084250/python-2-7-and-xml-etree-how-to-create-an-xml-file-with-multiple-namespaces
	

	# Namespace do documento a ser inserido
	dim = "http://www.dspace.org/xmlns/dspace/dim"
	doc = "http://www.lyncode.com/xoai"
	xsi = "http://www.w3.org/2001/XMLSchema-instance"
	schloc = "http://www.dspace.org/xmlns/dspace/dim http://www.dspace.org/schema/dim.xsd"

	# Criação do dicionário para inserir os vários namespaces.

	nsi = {"xmlns:dim":dim, "xmlns:doc":doc, "xmlns:xsi":xsi, "xsi:schemaLocation":schloc}

	# Registrando como namespaces, ficará depois de 'dim:dim' no raiz.
	for atribt, uri in nsi.items():
		ET.register_namespace(atribt.split(":")[1], uri)

	raiz = Element('dim:dim')



def converte(respDataUTF_8, num_dedalus, cod_barras):
	# Ambas as variáveis para carregamento da arvore e da raíz do xml.
	arvore = 0
	raiz = 0

	arvore = ET.ElementTree(respDataUTF_8)
	raiz = arvore.getroot()

	for elem in raiz.iter():
		if (elem.attrib.get('tag') == '100') or (elem.attrib.get('tag') == '110') or (elem.attrib.get('tag') == '111'):
			for subelem in elem:
				DC_metadados[1].append(subelem.text)







