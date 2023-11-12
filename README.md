# automacaoTeste

## pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org selenium
## pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org webdriver-manager
## python.exe -m pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org --upgrade pip

import tkinter as tk
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def clicar_botao():
    maquina = maquina_url.get()
    login = maquina_login.get()
    senha = maquina_senha.get()
    btn = maquina_btn.get()
    driver = maquina_driver.get()
    if driver:
        servico = Service(driver)
    else:
        servico = Service(ChromeDriverManager().install()) 
    navegador = webdriver.Chrome(service=servico)
    navegador.get(maquina)
    WebDriverWait(navegador, 120).until(
        EC.visibility_of_element_located((By.XPATH, login))
    ).send_keys("31231")

    WebDriverWait(navegador, 120).until(
        EC.visibility_of_element_located((By.XPATH, senha))
    ).send_keys("31231")

    WebDriverWait(navegador, 120).until(
        EC.element_to_be_clickable((By.XPATH, btn))
    ).click()

    WebDriverWait(navegador, 10).until(
        EC.element_to_be_clickable((By.XPATH, '//*[@id="section-10356508"]/section/div[2]/div/div[2]/form/button'))
    ).click()



root = tk.Tk()
root.title("Automatização de pcFactory")


tk.Label(root, text="Url:").pack(pady=10)
maquina_url = tk.Entry(root)
maquina_url.pack(pady=10)

tk.Label(root, text="login:").pack(pady=10)
maquina_login = tk.Entry(root)
maquina_login.pack(pady=10)

tk.Label(root, text="senha:").pack(pady=10)
maquina_senha = tk.Entry(root)
maquina_senha.pack(pady=10)

tk.Label(root, text="driver:").pack(pady=10)
maquina_driver = tk.Entry(root)
maquina_driver.pack(pady=10)

tk.Label(root, text="Btn:").pack(pady=10)
maquina_btn = tk.Entry(root)
maquina_btn.pack(pady=10)
tk.Button(root, text="Executar", command=clicar_botao).pack(pady=20)

root.mainloop()
