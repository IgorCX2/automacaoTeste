import tkinter as tk
from pynput import keyboard
import threading
import datetime

root = None

def create_fullscreen_window(maquina):
    global root
    root = tk.Tk()
    root.attributes("-fullscreen", True)
    root.title("LIBERACAO")


    title_label = tk.Label(root, text=maquina, font=("Helvetica", 36, "bold"))
    title_label.pack(pady=30)

    frame_form = tk.Frame(root)
    frame_form.pack(padx=20)
    frame1 = tk.Frame(frame_form)
    frame1.pack(side="left", padx=20)

    sintoma_label = tk.Label(frame1, text="Sintoma", font=("Helvetica", 16))
    sintoma_label.pack(pady=10)
    entry1 = tk.Text(frame1, height=5, width=50)
    entry1.pack()


    frame2 = tk.Frame(frame_form)
    frame2.pack(side="left", padx=20)

    causa_label = tk.Label(frame2, text="Causa", font=("Helvetica", 16))
    causa_label.pack(pady=10)
    entry2 = tk.Text(frame2, height=5, width=50)
    entry2.pack()


    frame3 = tk.Frame(frame_form)
    frame3.pack(side="left", padx=20)

    solucao_label = tk.Label(frame3, text="Solução", font=("Helvetica", 16))
    solucao_label.pack(pady=10)
    entry3 = tk.Text(frame3, height=5, width=50)
    entry3.pack()

    save_button = tk.Button(root, text="Salvar", command=lambda: save_data(entry1.get("1.0", "end-1c"), entry2.get("1.0", "end-1c"), entry3.get("1.0", "end-1c")))
    save_button.configure(bg="#00FF00")  # Defina a cor de fundo como verde
    save_button.configure(width=8) # Aumente a altura do botão
    save_button.configure(font=("Helvetica", 12, "bold"))
    save_button.pack(pady=20)

    root.mainloop()

def on_key_release(key):
    global key_sequence
    global historic_sequence
    if hasattr(key, 'char'):
        teste = str(key).replace("'", '')
        key_sequence += teste
        print(key_sequence)
        if '0706' in key_sequence or '<96><103><96><102>' in key_sequence:
            if not historic_sequence:
                target = '0706' if '0706' in key_sequence else '<96><103><96><102>'
                historic_sequence = key_sequence.replace(target, '')

            create_fullscreen_window(historic_sequence)
            key_sequence = ''
            historic_sequence = ''
    else:
        historic_sequence = key_sequence
        key_sequence = ''
        print(historic_sequence)

def save_data(data1, data2, data3):
    current_datetime = datetime.datetime.now()
    with open("dados.txt", "a") as file: 
        file.write(f"Data e Hora do Cadastro: {current_datetime}\n")
        file.write(f"Campo 1: {data1}\n")
        file.write(f"Campo 2: {data2}\n")
        file.write(f"Campo 3: {data3}\n")
        file.write("\n") 


    root.quit()
    root.destroy()

key_listener = keyboard.Listener(on_release=on_key_release)
key_listener.start()

key_sequence = ''
historic_sequence = ''

key_listener.join()
