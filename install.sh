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

# 4. Crear alias/comando global 'termuxhivebear'
echo "🔗 Configurando alias global 'termuxhivebear'..."
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

cat << 'EOF' > "$BIN_DIR/termuxhivebear"
#!/usr/bin/env bash
SCRIPT_DIR="$HOME/TermuxHiveBear"
if [ -f "$SCRIPT_DIR/menu.sh" ]; then
    bash "$SCRIPT_DIR/menu.sh"
elif [ -f "/data/data/com.termux/files/home/.gemini/antigravity-cli/brain/278a35cb-5d04-4d3d-9358-ea2e4e459dc1/menu.sh" ]; then
    bash "/data/data/com.termux/files/home/.gemini/antigravity-cli/brain/278a35cb-5d04-4d3d-9358-ea2e4e459dc1/menu.sh"
else
    hivebear --help
fi
EOF

chmod +x "$BIN_DIR/termuxhivebear"

# Asegurar también copia en $PREFIX/bin si es posible
if [ -d "$PREFIX/bin" ]; then
    cp "$BIN_DIR/termuxhivebear" "$PREFIX/bin/termuxhivebear" 2>/dev/null || true
    chmod +x "$PREFIX/bin/termuxhivebear" 2>/dev/null || true
fi

echo ""
echo "🎉 ¡Instalación y alias completados con éxito!"
echo "--------------------------------------------------------"
echo "¡Ahora puedes abrir el menú en cualquier momento escribiendo simplemente:"
echo ""
echo "    termuxhivebear"
echo ""
echo "--------------------------------------------------------"
