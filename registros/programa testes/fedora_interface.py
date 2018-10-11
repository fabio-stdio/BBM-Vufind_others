from tkinter import *
import tkinter
import MySQLbd
# Interface da página internat para a coleta dos dados.
# A variável global servirá para os nomes de campos que deverão ser preenchidos obrigatóriamente.

campos = 'Título, Autor, Nº de registro no Dedalus, Código de barras, Bibliotecário responsável, Função, Data, Hora, Motivo, Descrição'


def dados(entradas, user, role, var):
	'''Pega as entradas e armazena na tabela no BD.'''
	titulo = entries['Título'].get()
	autor = entries['Autor'].get()
	num_dedalus = entries['Nº de registro no Dedalus'].get()
	cod_barras = entries['Código de barras'].get()
	bibliotecario = entries['Bibliotecário responsável'].get()
	function = entries['Função'].get()
	data = entries['Data'].get()
	hora = entries['Hora'].get()
	motivo = entries['Motivo'].get()
	description = entries['Descrição'].get()
	IO = var.get()


	# Fazer uma transação e colocar todas as entradas capturadas acima na tabela no BD do MySQL usando a biblioteca MySQLbd.
	cursor = con.cursor()
	cursor.execute('INSERT INTO eventos (user, titulo, autor, dedalus, codBarras, bibliotecario, data, hora, motivo, description, role, function, IO) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
		(user, titulo, autor, num_dedalus, cod_barras, bibliotecario, data, hora, motivo, description, role, function, IO))
	con.commit()





