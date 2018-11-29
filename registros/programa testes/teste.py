from tkinter import *



class MyFirstGUI:
    def __init__(self, master):
        self.master = master
        master.title("GUI agressiva")

        self.label = Label(master, text="Essa é a nossa primeira GUI arrombado!")
        self.label.pack()

        self.greet_button = Button(master, text="Aeee CARAIO!", command=self.greet)
        self.greet_button.pack()
        self.greet_button.place(x=55, y=220)

        self.close_button = Button(master, text="Fecha essa merda", command=master.quit)
        self.close_button.pack()
        self.close_button.place(x=50, y=250)

    def greet(self):
        var = StringVar()
        label = Message(root, textvariable = var, padx=2, pady=2)
        var.set("Olá PORRA!!!")
        label.pack()
        #if 
        




root = Tk()
rolamento = Scrollbar(root)
rolamento.pack(side=RIGHT, fill=Y)
rolamento.config(command=label.yview)
root.geometry("800x300")
my_gui = MyFirstGUI(root)
root.mainloop()