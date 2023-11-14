import tkinter as tk

class App:
    def __init__(self, root):
        self.root = root
        self.root.title("Sua Automação")

        # Configuração da janela
        self.root.configure(bg='dark blue')
        self.root.geometry("1000x800")  # Largura e altura iniciais (pode ajustar conforme necessário)

        # Configuração para centralizar verticalmente
        self.root.eval('tk::PlaceWindow . center')

        # Título no centro da tela
        title_label = tk.Label(root, text="Automação", font=('Arial', 20), bg='dark blue', fg='white')
        title_label.pack(pady=20)

        # Botões na primeira linha
        self.create_buttons_row(5)

        # Botões na segunda linha
        self.create_buttons_row(5)

        # Botões na terceira linha
        self.create_buttons_row(1, big_button=True)
        self.create_buttons_row(1)

    def create_buttons_row(self, num_buttons, big_button=False):
        button_frame = tk.Frame(self.root, bg='dark blue')
        button_frame.pack()

        button_width = 8
        button_height = 2

        if big_button:
            button_width *= 4

        # Adiciona os botões à frame
        for i in range(num_buttons):
            button = tk.Button(button_frame, text=f'Botão {i + 1}', width=button_width, height=button_height, bg='white', fg='dark blue')
            button.pack(side='left', padx=5, pady=5)


root = tk.Tk()
app = App(root)
root.mainloop()
