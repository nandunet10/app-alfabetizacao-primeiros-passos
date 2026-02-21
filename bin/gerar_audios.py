import json
import os
from gtts import gTTS

# Caminho do JSON original
json_path = "assets/data/silabas.json"

# Pasta base para os áudios
audio_base_path = "assets/audios"

# Carrega JSON
with open(json_path, encoding="utf-8") as f:
    data = json.load(f)

# Gera áudios e atualiza JSON
for tipo, items in data.items():
    tipo_path = os.path.join(audio_base_path, tipo)
    os.makedirs(tipo_path, exist_ok=True)  # cria pasta se não existir

    for item in items:
        palavra = item["palavra"]
        # Remove caracteres estranhos para criar nome de arquivo
        sanitized = ''.join(e for e in palavra if e.isalnum())
        audio_file = f"{sanitized}.mp3"
        audio_path = os.path.join(tipo_path, audio_file)

        print(f"Gerando {audio_path}")
        tts = gTTS(text=palavra, lang="pt-br")
        tts.save(audio_path)

        # Atualiza JSON com caminho relativo do app
        item["audio"] = f"{tipo}/{audio_file}"

# Salva JSON atualizado
output_json_path = "assets/data/silabas_com_audio.json"
with open(output_json_path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f"✅ Áudios gerados e JSON atualizado salvo em {output_json_path}")