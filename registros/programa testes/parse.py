
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

		saveFile = open('marc'+num_dedalus+'.xml','w')
		saveFile.write(str(respDataUTF_8))
		saveFile.close()
		
	except Exception as e:
		print(str(e))




''' A partir daqui o código foi desenvolvido quase que inteiramente por Fábio Chagas da Silva (fabio.chagas.silva@usp.br), com base no programa de mesma função
escrito em Java pelo o ICMCC - USP São Carlos. Referências serão feitas ao longo do código quando os trechos usados foram feitos por outros. A licensa do uso
desse código é GNU General License como explicado acima.'''

