# gerar_letras.py
import os
import json
from gtts import gTTS

# Caminho do JSON com as letras
json_path = "assets/data/letras.json"

# Pasta onde os áudios serão salvos
output_dir = "assets/audios/letras/"

# Cria a pasta se não existir
os.makedirs(output_dir, exist_ok=True)

# Lê o JSON
with open(json_path, encoding="utf-8") as f:
    data = json.load(f)

for letra_entry in data["letras"]:
    letra = letra_entry["letra"]
    audio_path = os.path.join(output_dir, f"{letra}.mp3")
    
    # Gera áudio usando gTTS
    tts = gTTS(text=letra, lang='pt')
    tts.save(audio_path)
    
    print(f"Áudio gerado: {audio_path}")