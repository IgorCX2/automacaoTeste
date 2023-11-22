import customtkinter
import tkinter
import customtkinter
from PIL import Image
from tkinter import Tk, PhotoImage
from datetime import datetime
import json ##adcionar biblioteca

customtkinter.set_appearance_mode("dark")
customtkinter.set_default_color_theme("dark-blue")
nomeSelecionado = "31231"
def carregar_usuarios():
    try:
        with open("users/userConfig.txt", "r") as arquivo:
            usuarios = eval(arquivo.read())
        return usuarios
    except FileNotFoundError:
        return []

def obter_turno_atual():
    hora_atual = datetime.now().time()
    turno_m_inicio = datetime.strptime("06:00", "%H:%M").time()
    turno_m_fim = datetime.strptime("19:00", "%H:%M").time()
    turno1_inicio = datetime.strptime("06:00", "%H:%M").time()
    turno2_inicio = datetime.strptime("14:36", "%H:%M").time()
    turno3_inicio = datetime.strptime("23:04", "%H:%M").time()

    if turno_m_inicio <= hora_atual < turno_m_fim:
        if turno1_inicio <= hora_atual < turno2_inicio:
            return "M1"
        else:
            return "M2"
    elif turno1_inicio <= hora_atual < turno2_inicio:
        return 1
    elif turno2_inicio <= hora_atual < turno3_inicio:
        return 2
    else:
        return 3

def mostrar_usuarios(turno_selecionado, cod):
    list_permit={
        "0405": "Mecanico",
        "0406": "Eletricista",
        "0407": "Eletricista",
        "0408": "Eletricista",
        "0403": "TODOS",
        "0706": "TODOS",
        "0502": "Mecanico",
        "0504": "Eletricista",
        "0505": "Eletricista",
        "0506": "Eletricista",
        "0404": "Mecanico",
        "0418": "Mecanico",
    }
    usuarios = carregar_usuarios()
    usuarios_turno = []
    print(list_permit[cod])
    for usuario in usuarios:
        if isinstance(turno_selecionado, int) and usuario["Profissao"] != list_permit[cod]:
            if str(usuario["Turno"]) == str(turno_selecionado):
                usuarios_turno.append(usuario)
        elif isinstance(turno_selecionado, str):
            if turno_selecionado[0] == 'M' and (usuario["Turno"] == "M" or str(usuario["Turno"]) == turno_selecionado[1:] and usuario["Profissao"] != list_permit[cod]):
                usuarios_turno.append(usuario)
    return usuarios_turno

def janelaConfig(janela, titulo):
    janela.title(titulo)
    largura_tela = janela.winfo_screenwidth()
    altura_tela = janela.winfo_screenheight()
    janela.geometry(f"{largura_tela}x{altura_tela}+0+0")


def telaLotto(local, usuario):
    nomeSelecionado = usuario
    def pesquisar_chave(event):
        chave_campo_digitada = digt_chave.get()

        with open("c:/Users/User/Desktop/chaves.txt", "r") as arquivo:
            dados = arquivo.read()
            chaves = json.loads("[" + dados.replace("}\n{", "},{") + "]")
            for item in chaves:
                if str(item.get("chave")) == chave_campo_digitada:
                    titletipo_label.configure(text=f"{item.get('tipo')}")
                    return
            titletipo_label.configure(text="Chave não encontrada")

    janela_lotto= customtkinter.CTk()
    if local == "modal":
        janela_lotto.title("LOTTO")
        janela_lotto.geometry("%dx%d"%(500,800))
    else:
        janela.destroy()
        janelaConfig(janela_lotto, "LOTTO")

    titletipo_label = customtkinter.CTkLabel(janela_lotto, text="", font=("Helvetica", 60), fg_color='transparent', text_color='white')
    titletipo_label.pack()
    titlereporte_label = customtkinter.CTkLabel(janela_lotto, text="LOTTO", font=("Helvetica", 60, "bold"), fg_color='transparent', text_color='white')
    titlereporte_label.pack()


    frame_total = customtkinter.CTkFrame(janela_lotto,fg_color='transparent',width=501)
    frame_total.pack()
    lotto_inicial_frame = customtkinter.CTkFrame(frame_total, fg_color='transparent',width=950)
    lotto_inicial_frame.pack(side='left')
    chave_title_label = customtkinter.CTkLabel(lotto_inicial_frame, text="Maquina", font=("Helvetica", 20, "bold"), fg_color='transparent',width=950, anchor="w", text_color='white')
    chave_title_label.pack(pady=10)
    digt_chave = customtkinter.CTkEntry(lotto_inicial_frame, placeholder_text="Inserir Maquina",width=950,height=35, font=("Helvetica", 20))
    digt_chave.pack()	
    digt_chave.bind("<KeyRelease>", pesquisar_chave)
    teste_title_label = customtkinter.CTkLabel(lotto_inicial_frame, text=nomeSelecionado, font=("Helvetica", 20, "bold"), fg_color='transparent',width=950, anchor="w", text_color='white')
    teste_title_label.pack(pady=10)

    janela_lotto.mainloop()

def enviarPcFactory():
    print(nomeSelecionado)

def telaReporte_pcFactory(cod, txt):
    def mudarPessoa(pessoa, janela):
        global nomeSelecionado
        print(pessoa)
        nomeSelecionado = pessoa
        janela.configure(fg_color="red")
    janela.destroy()
    janela_reporte_pcf = customtkinter.CTk()
    janelaConfig(janela_reporte_pcf, "Reporte"+" "+cod)
    titlereporte_label = customtkinter.CTkLabel(janela_reporte_pcf, text=txt.upper(), font=("Helvetica", 60, "bold"), fg_color='transparent', text_color='white')
    titlereporte_label.pack(pady=70)

    frame_total = customtkinter.CTkFrame(janela_reporte_pcf,fg_color='transparent',width=501)
    frame_total.pack()

    user_frame = customtkinter.CTkFrame(frame_total, fg_color='transparent')
    user_frame.pack()
    usertitle_label = customtkinter.CTkLabel(user_frame, text="Usuario", font=("Helvetica", 20, "bold"), fg_color='transparent',width=950, anchor="w", text_color='white')
    usertitle_label.pack()

    userbox_frame = customtkinter.CTkFrame(user_frame, fg_color='transparent',width=950)
    userbox_frame.pack(side='left')
    usuario_carregados = mostrar_usuarios(obter_turno_atual(), cod)
    for i in range(len(usuario_carregados)):
        corSelect = "transparent"
        if usuario_carregados[i]["Nome"] == nomeSelecionado:
            corSelect = "red"
        if usuario_carregados[i]["Nome"] != None: 
            my_image = customtkinter.CTkImage(light_image=Image.open("config/imgs/users/"+usuario_carregados[i]["Foto"]),dark_image=Image.open("config/imgs/users/"+usuario_carregados[i]["Foto"]),size=(90, 110))
            button_user = customtkinter.CTkButton(userbox_frame, image=my_image, compound="top", text=usuario_carregados[i]["Nome"],font=("Helvetica", 18, "bold"), fg_color="transparent", text_color='white')
            button_user.configure(command=lambda arg1=usuario_carregados[i]["Nome"], arg2=button_user: mudarPessoa(arg1, arg2))
            button_user.pack(side='left', padx=8, pady=8)


    digitMaquina_frame = customtkinter.CTkFrame(frame_total, fg_color='transparent')
    digitMaquina_frame.pack(pady=20)
    maquinatitle_label = customtkinter.CTkLabel(digitMaquina_frame, text="Maquina", font=("Helvetica", 20, "bold"), fg_color='transparent',width=950, anchor="w", text_color='white')
    maquinatitle_label.pack(pady=10)
    digt_maquina = customtkinter.CTkEntry(digitMaquina_frame, placeholder_text="Inserir Maquina",width=950,height=35, font=("Helvetica", 20))
    digt_maquina.pack()	

    digitComment_frame = customtkinter.CTkFrame(frame_total, fg_color='transparent')
    digitComment_frame.pack(pady=20)
    maquinatitle_label = customtkinter.CTkLabel(digitComment_frame, justify="left", text="Comentario", font=("Helvetica", 20, "bold"), fg_color='transparent', width=950, anchor="w", text_color='white')
    maquinatitle_label.pack(pady=10)
    digt_maquina = customtkinter.CTkTextbox(digitComment_frame, width=950, font=("Helvetica", 20))
    digt_maquina.pack()

    buttonSave_frame = customtkinter.CTkFrame(frame_total, fg_color='transparent')
    buttonSave_frame.pack(pady=20)
    button = customtkinter.CTkButton(buttonSave_frame, text="SALVAR",font=("Helvetica", 18, "bold"), command=enviarPcFactory, fg_color='#6aa84f', text_color='white', width=850,height=40)
    button.pack(side='left', padx=8, pady=8)
    button = customtkinter.CTkButton(buttonSave_frame, text="LOTTO",font=("Helvetica", 18, "bold"), command=lambda arg1="modal", arg2=nomeSelecionado: telaLotto(arg1, arg2), fg_color='#1155cc', text_color='white', width=80,height=40)
    button.pack(side='left', padx=8, pady=8)

    janela_reporte_pcf.mainloop()

janela = customtkinter.CTk()
janelaConfig(janela, "Manutencao Automatizada")
buttons_cod1=[["0405","0406","0407","0408","0403","0706"],["0502","0504","0505","0506","0404","0418"]]
buttons_txt1=[["Elétrico","Hidráulico","Mecânico","Pneumático","Análise","Liberar"],["Pre-Elétrico","Pre-Hidráulico","Pre-Mecânico","Pre-Pneumático","BCR","Ajus.Parâmetro"]]
button_width = 153
button_height = 120
button_grand = (button_width*4)+50
title_label = customtkinter.CTkLabel(janela, text="MANUTENÇÃO", font=("Helvetica", 70, "bold"), fg_color='transparent', text_color='white')
title_label.pack(pady=100)

for i in range(2):
    button_frame = customtkinter.CTkFrame(janela, fg_color='transparent')
    button_frame.pack()
    for c in range(len(buttons_cod1[i])):
        button = customtkinter.CTkButton(button_frame, text=buttons_txt1[i][c], command=lambda arg1=buttons_cod1[i][c], arg2=buttons_txt1[i][c]: telaReporte_pcFactory(arg1,arg2), font=("Helvetica", 18, "bold"), width=button_width, height=button_height, fg_color='white', text_color='dark blue')
        button.pack(side='left', padx=8, pady=8)

button_frame = customtkinter.CTkFrame(janela, fg_color='transparent')
button_frame.pack()
button = customtkinter.CTkButton(button_frame, text="SISTEMA LOTTO",command=lambda arg1="naomodal", arg2=nomeSelecionado: telaLotto(arg1, arg2), font=("Helvetica", 18, "bold"), width=button_grand, height=button_height, fg_color='white', text_color='dark blue')
button.pack(side='left', padx=8, pady=8)
button = customtkinter.CTkButton(button_frame, text="BCR", font=("Helvetica", 18, "bold"), width=button_width, height=button_height, fg_color='white', text_color='dark blue')
button.pack(side='left', padx=8, pady=8)
button = customtkinter.CTkButton(button_frame, text="LIMPEZA", font=("Helvetica", 18, "bold"), width=button_width, height=button_height, fg_color='white', text_color='dark blue')
button.pack(side='left', padx=8, pady=8)

janela.mainloop()
