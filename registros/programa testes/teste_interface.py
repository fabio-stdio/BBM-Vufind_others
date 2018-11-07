#!/usr/bin/python3
#Partes do código tirado de https://www.python-course.eu/tkinter_entry_widgets.php , acessado em 2 de outubro de 2018 às 17:44 (Brasília)
#Principal parte copiada de https://pythonprogramming.net/urllib-tutorial-python-3/ , acessado em 2 de outubro de 2018 às 17:47 (Brasília)

'''Utilizado como teste para uma interface totalmente customizada para a Biblioteca Brasiliana Guita e José Mindlin da Universidade de São Paulo por Fábio Chagas da Silva
(fabio.chagas.silva@usp.br)

Este programa é um software livre; você pode redistribuí-lo e/ou
modificá-lo sob os termos da Licença Pública Geral GNU como publicada
pela Free Software Foundation; na versão 3 da Licença, ou
(a seu critério) qualquer versão posterior.

Este programa é distribuído na esperança de que possa ser útil,
mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO
a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
Licença Pública Geral GNU para mais detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral GNU junto
com este programa. Se não, veja <http://www.gnu.org/licenses/>. 
'''
from tkinter import *
import parse



campos = 'Código de Barras', 'Número de Registro no Dedalus'

def dados(entries):
   num_dedalus = entries['Número de Registro no Dedalus'].get()
   cod_barras = entries['Código de Barras'].get()
   parse.parse(num_dedalus)

def formulario(root, campos):
   entries = {}
   for campo in campos:
      row = Frame(root)
      lab = Label(row, width=40, text=campo+":", anchor='w')
      ent = Entry(row)
      row.pack(side=TOP, fill=X, padx=5, pady=5)
      lab.pack(side=LEFT)
      ent.pack(side=RIGHT, expand=YES, fill=X)
      entries[campo] = ent
   return entries

if __name__ == '__main__':
   root = Tk()
   ents = formulario(root, campos)
   root.bind('<Return>', (lambda event, e=ents: dados(e)))   
   b1 = Button(root, text='Mostrar',
          command=(lambda e=ents: dados(e)))
   b1.pack(side=LEFT, padx=5, pady=5)
   b2 = Button(root, text='Sair', command=root.quit)
   b2.pack(side=LEFT, padx=5, pady=5)
   root.mainloop()