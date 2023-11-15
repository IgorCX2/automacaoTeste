import customtkinter
from datetime import datetime

customtkinter.set_appearance_mode("dark")
customtkinter.set_default_color_theme("dark-blue")

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

def mostrar_usuarios(turno_selecionado):
    usuarios = carregar_usuarios()
    usuarios_turno = []
    for usuario in usuarios:
        if isinstance(turno_selecionado, int):
            if str(usuario["Turno"]) == str(turno_selecionado):
                usuarios_turno.append(usuario)
        elif isinstance(turno_selecionado, str):
            if turno_selecionado[0] == 'M' and (usuario["Turno"] == "M" or str(usuario["Turno"]) == turno_selecionado[1:]):
                usuarios_turno.append(usuario)
    print(usuarios_turno)
    return usuarios_turno

def janelaConfig(janela, titulo):
    janela.title(titulo)
    largura_tela = janela.winfo_screenwidth()
    altura_tela = janela.winfo_screenheight()
    janela.geometry(f"{largura_tela}x{altura_tela}")

def trocarJanela(antiga, nova):
    antiga.destroy()
    nova.mainloop()


def telaReporte_pcFactory(cod, txt):
    turno_atual = obter_turno_atual()
    janela_reporte_pcf = customtkinter.CTk()
    janelaConfig(janela_reporte_pcf, "Reporte"+" "+cod)
    titlereporte_label = customtkinter.CTkLabel(janela_reporte_pcf, text=txt.upper(), font=("Helvetica", 60, "bold"), fg_color='transparent', text_color='white')
    titlereporte_label.pack(pady=100)

    user_frame = customtkinter.CTkFrame(janela_reporte_pcf, fg_color='transparent')
    user_frame.pack()
    usertitle_label = customtkinter.CTkLabel(user_frame, text="Usuario", font=("Helvetica", 20, "bold"), fg_color='transparent', text_color='white')
    usertitle_label.pack(pady=10)

    userbox_frame = customtkinter.CTkFrame(user_frame, fg_color='transparent')
    userbox_frame.pack()
    usuario_carregados = mostrar_usuarios(obter_turno_atual())
    for usuario in usuario_carregados:
        if usuario["Nome"] != None:
            button = customtkinter.CTkButton(userbox_frame, text=usuario["Nome"], font=("Helvetica", 18, "bold"), width=button_width, height=button_height, fg_color='white', text_color='dark blue')
            button.pack(side='left', padx=8, pady=8)

    trocarJanela(janela,janela_reporte_pcf)

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
button = customtkinter.CTkButton(button_frame, text="SISTEMA LOTTO", font=("Helvetica", 18, "bold"), width=button_grand, height=button_height, fg_color='white', text_color='dark blue')
button.pack(side='left', padx=8, pady=8)
button = customtkinter.CTkButton(button_frame, text="BCR", font=("Helvetica", 18, "bold"), width=button_width, height=button_height, fg_color='white', text_color='dark blue')
button.pack(side='left', padx=8, pady=8)
button = customtkinter.CTkButton(button_frame, text="LIMPEZA", font=("Helvetica", 18, "bold"), width=button_width, height=button_height, fg_color='white', text_color='dark blue')
button.pack(side='left', padx=8, pady=8)

janela.mainloop()
