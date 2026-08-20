#!/usr/bin/env bash
# ==============================================================================
# TermuxHiveBear Automated Installer & Setup Script
# ==============================================================================
set -e

echo "🐻 Instalando y configurando TermuxHiveBear..."

# 1. Instalar dependencias
pkg update -y && pkg install curl git -y

# 2. Crear directorio de modelos
mkdir -p ~/.cache/hivebear/models

# 3. Descargar el modelo Qwen 2.5 0.5B (GGUF) si no existe
MODEL_PATH="$HOME/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf"
if [ ! -f "$MODEL_PATH" ]; then
    echo "📥 Descargando modelo Qwen 2.5 0.5B (GGUF ~398MB)..."
    curl -L -o "$MODEL_PATH" \
      https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
else
    echo "✅ El modelo Qwen 2.5 0.5B ya está descargado en tu dispositivo."
fi

echo ""
echo "🎉 ¡Instalación y configuración completadas con éxito!"
echo "--------------------------------------------------------"
echo "Para iniciar el chat con la IA ejecuta:"
echo "hivebear run ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf"
echo ""
echo "Para iniciar el servidor de API compatible con OpenAI/Ollama:"
echo "hivebear serve"
echo "--------------------------------------------------------"
