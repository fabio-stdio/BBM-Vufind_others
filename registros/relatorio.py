import os
import sys
import glob
import xml.etree.ElementTree as ET
import pandas as pd
import re
import pickle as pkl
import json


#conjuntos com os qualifiers e os elements de acordo com um arquivo dim.
qualifiers = { 'author', 'other', 'city', 'issued', 'medium', 'isPartOf', 'tableOfContents', 'isReferencedBy', 'abstract', 'localnote', 'alternative', 'spatial', 
				'iso', 'requires', 'issn', 'isbn', 'personalname', 'version'}
elements = {'type', 'publisher', 'AccrualPeriodicity', 'description', 'title'}

#def remove_none_elements_from_list(lista):
#	return [e for e in lista if e != None]



def analise_contador():
	texto = open('contadores.txt', 'r')


	i = 0
	count_quali = 0
	count_element = 0
	quali = 0
	element = 0
	line = []
	palavras = []

	for linha in texto:
		line.append(linha)
		palavras.append(re.split('=|\s|\n', line[i]))


		k = 0
		while k < len(palavras):
			m = 0
			n = 0
			if palavras[k] == 'qualifiers':
				count_quali += 1
				m = K + 1
				while type(palavras[m]) != str:
					m += 1
				quali = quali + int(palavras[m].strip())

			elif palavras[k] == 'elements':
				count_element += 1
				n = k + 1
				while type(palavras[n]) != str:
					n +=1
				element = element + int(palavras[n].strip())
			k += 1
		i += 1


	return count_quali, count_element, quali, element

def analise_dicionario():
	

	j = 0
	count = 0
	vetor = []
	de_palavras = []

	author = 0
	title = 0
	other = 0
	city = 0
	issued = 0
	medium = 0
	ispartof = 0
	tableOfContents = 0
	abstract = 0
	localnote = 0
	alternative = 0
	spatial = 0
	iso = 0
	_type = 0
	publisher = 0
	AccrualPeriodicity = 0
	description = 0
	isReferencedBy = 0
	requires = 0
	none = 0



	with open('dicionario') as texto:
		lista = list(texto)

	for registro in lista:
		vetor.append(registro)
		de_palavras.append(re.split('\s|"|:|;', vetor[count]))
		
		while j < len(de_palavras[count]):


			if de_palavras[count][j] == 'author':
				author += 1
			elif de_palavras[count][j] == 'title':
				title += 1
			elif de_palavras[count][j] == 'other':
				other += 1
			elif de_palavras[count][j] == 'city':
				city += 1
			elif de_palavras[count][j] == 'issued':
				issued += 1
			elif de_palavras[count][j] == 'medium':
				medium += 1
			elif de_palavras[count][j] == 'isPartOf':
				ispartof += 1
			elif de_palavras[count][j] == 'tableOfContents':
				tableOfContents += 1
			elif de_palavras[count][j] == 'isReferencedBy':
				isReferencedBy += 1
			elif de_palavras[count][j] == 'abstract':
				abstract += 1
			elif de_palavras[count][j] == 'localnote':
				localnote += 1
			elif de_palavras[count][j] == 'alternative':
				alternative += 1
			elif de_palavras[count][j] == 'spatial':
				spatial += 1
			elif de_palavras[count][j] == 'iso':
				iso += 1
			elif de_palavras[count][j] == 'requires':
				requires += 1
			elif de_palavras[count][j] == 'type':
				_type += 1
			elif de_palavras[count][j] == 'publisher':
				publisher += 1
			elif de_palavras[count][j] == 'AccrualPeriodicity':
				AccrualPeriodicity += 1
			elif de_palavras[count][j] == 'description':
				description += 1
			elif de_palavras[count][j] == 'none':
				none += 1

			j += 1

		count += 1

	dict_metadados = {'author': repr(author), 'title': repr(title), 'other':repr(other), 'city':repr(city), 'issued':repr(issued), 'medium':repr(medium),
						'tableOfContents':repr(tableOfContents), 'isReferencedBy':repr(isReferencedBy), 'abstract':repr(abstract), 
						'localnote':repr(localnote), 'alternative':repr(alternative), 'spatial':repr(spatial), 'iso':repr(iso), 'requires':repr(requires), 'type':repr(_type),
						'publisher':repr(publisher), 'AccrualPeriodicity':repr(AccrualPeriodicity), 'description':repr(description), 'none':repr(none)}

	return dict_metadados, len(lista)




def main():



	frames = []
	count_quali = 0
	count_element = 0
	quali = 0
	element = 0
	n_registros = 0


	dicionario, n_registros = analise_dicionario()

	count_quali, count_element, quali, element = analise_contador()

	f = open('relatório_de_metadados.pdf', 'w')
	f.write('Relatório de metadados no perfil DIM:\n')
	f.write('Número de registros: ' + repr(n_registros) + ' registros\n')
	f.write('DIM -> author: números de registros com esse metadado: '+ dicionario.get('author') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> title: números de registros com esse metadado: ' + dicionario.get('title') + ' é element ' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> other: números de registros com esse metadado: ' + dicionario.get('other') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> issued: números de registros com esse metadado: ' + dicionario.get('issued') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> medium: números de registros com esse metadado: ' + dicionario.get('medium') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> tableOfContents: números de registros com esse metadado: ' + dicionario.get('tableOfContents') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> isReferencedBy: números de registros com esse metadado: ' + dicionario.get('isReferencedBy') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> abstract: números de registros com esse metadado: ' + dicionario.get('abstract') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> localnote: números de registros com esse metadado: ' + dicionario.get('localnote') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> alternative: números de registros com esse metadado: ' + dicionario.get('alternative') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> spatial: números de registros com esse metadado: ' + dicionario.get('spatial') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> iso: números de registros com esse metadado: ' + dicionario.get('iso') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> requires: números de registros com esse metadado: ' + dicionario.get('requires') + ' é qualifier' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> type: números de registros com esse metadado: ' + dicionario.get('type') + ' é element' + ' uma média de ' + repr() +  '\n')
	f.write('DIM -> publisher: números de registros com esse metadado: ' + dicionario.get('publisher') + ' é element' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> AccrualPeriodicity: números de registros com esse metadado: ' + dicionario.get('AccrualPeriodicity') + ' é element' + ' uma média de ' + repr() + '\n')
	f.write('DIM -> description: números de registros com esse metadado: ' + dicionario.get('description') +  ' é element' + ' uma média de ' + repr() + '\n')
	f.write('Numero de registros none: ' + dicionario.get('none') + ' uma média de ' + repr() + '\n')
	f.write('\n')
	f.write('\n')
	f.write('\n')
	f.write('Média da utlização de author: ' + repr())
	f.write('Número de qualifiers: ' + repr(quali) + ' em ' + repr(count_quali) + ' registros')
	f.write('Número de elements: ' + repr(element) + ' em ' + repr(count_element) + ' registros')



	f.close()

main()