import os
import sys
import glob
import xml.etree.ElementTree as ET
import pandas as pd 
import time
import json
import pickle


#Caminho para a pasta onde estão os registros xml em dim.
caminho = '/usr/local/vufind/local/harvest/DSpace/'

#conjuntos com os qualifiers e os elements de acordo com um arquivo dim.
qualifiers = { 'author', 'other', 'city', 'issued', 'medium', 'isPartOf', 'tableOfContents', 'isReferencedBy', 'abstract', 'localnote', 'alternative', 'spatial', 
				'iso', 'requires', 'issn', 'isbn', 'personalname', 'version'}
elements = {'type', 'publisher', 'AccrualPeriodicity', 'description', 'title'}



def Ler(raiz_dim):

	#vetor que receberá os valores de element e qualifiers e se transformará em dicionário
	metadados = []
	#Contador de qualifier e de element
	count_q = 0
	count_e = 0
	i = 1

	for line in raiz_dim.iter():
		#Para cada atributo 'qualifier' de cada linha da raíz que estiver no conjunto 'qualifier', soma 1 no contador qualifier. Mesmo com 'element' 
		if line.attrib.get('qualifier') in qualifiers:
			count_q += 1
			#No vetor metadados, será colocado o valor do atributo achado junto com seu nome, separado por virgula.
			metadados.append([line.attrib.get('qualifier'),line.text])
		elif line.attrib.get('element') in elements:
			count_e += 1
			metadados.append([line.attrib.get('element'),line.text])
		else:
			#Os metadados que não tem os atributos nos conjuntos
			metadados.append([line.attrib.get('qualifier'), repr(i)])
			i += 1
	return dict(metadados), count_q, count_e, i 







def main():

	arvore_dim = 0
	raiz_dim = 0
	metadata = 0
	T_0 = time.clock()
	j = 1
	frames = []
	f0 = open('dicionario.p','w')
	f = open('contadores.txt', 'w')
	for filename in glob.glob(os.path.join(caminho, '*.xml')):
		t0 = time.clock()
		
		arvore_dim = ET.ElementTree(file=filename)
		raiz_dim = arvore_dim.getroot()
		metadados, contador_q, contador_e, contador_none = Ler(raiz_dim)
		dicionario = json.dumps(metadados)
		#dataFrame = pd.DataFrame.from_dict(list(metadados.items))
 
		#dataFrame.to_csv('Tabela_metadados.csv')
		f0.write(dicionario + '\n')
		f.write(filename + '\n')

		f.write('qualifiers = '+ repr(contador_q) + '\n')
		f.write('elements = '+ repr(contador_e) + '\n')
		tp = time.clock()
		print(filename + '	', end=repr(tp - t0) + ' segundos\n')

	f0.close()
	f.close()
	T_final = time.clock()
	print(repr(T_final - T_0) + ' segundos\n')


main()


			
