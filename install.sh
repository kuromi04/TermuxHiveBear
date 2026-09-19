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

# 3.5 Instalar el binario de hivebear
echo "⚙️  Instalando binario de hivebear..."
if command -v cargo &> /dev/null; then
    echo "🔨 Compilando hivebear desde el código fuente..."
    cargo build --release
    cp target/release/hivebear $PREFIX/bin/hivebear
    chmod +x $PREFIX/bin/hivebear
else
    echo "📥 Descargando binario precompilado de hivebear (ARM64)..."
    # Reemplaza la URL con la ubicación real de tu release en GitHub
    curl -L -o $PREFIX/bin/hivebear https://github.com/tu-usuario/TermuxHiveBear/releases/latest/download/hivebear-aarch64
    chmod +x $PREFIX/bin/hivebear
fi

# 4. Crear alias/comandos globales con variaciones de mayúsculas/minúsculas
echo "🔗 Configurando ejecutables globales (termuxhivebear / termuxhiveBear / TermuxHiveBear)..."
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cat << EOF > "$BIN_DIR/termuxhivebear"
#!/usr/bin/env bash
SCRIPT_DIR="$REPO_DIR"
if [ -f "\$SCRIPT_DIR/menu.sh" ]; then
    bash "\$SCRIPT_DIR/menu.sh"
else
    hivebear --help
fi
EOF

chmod +x "$BIN_DIR/termuxhivebear"

# Crear variaciones
ln -sf "$BIN_DIR/termuxhivebear" "$BIN_DIR/termuxhiveBear" 2>/dev/null || cp "$BIN_DIR/termuxhivebear" "$BIN_DIR/termuxhiveBear"
ln -sf "$BIN_DIR/termuxhivebear" "$BIN_DIR/TermuxHiveBear" 2>/dev/null || cp "$BIN_DIR/termuxhivebear" "$BIN_DIR/TermuxHiveBear"

# Copiar a $PREFIX/bin para disponibilidad global inmediata
if [ -d "$PREFIX/bin" ]; then
    cp "$BIN_DIR/termuxhivebear" "$PREFIX/bin/termuxhivebear" 2>/dev/null || true
    cp "$BIN_DIR/termuxhivebear" "$PREFIX/bin/termuxhiveBear" 2>/dev/null || true
    cp "$BIN_DIR/termuxhivebear" "$PREFIX/bin/TermuxHiveBear" 2>/dev/null || true
    chmod +x "$PREFIX/bin/termuxhivebear" "$PREFIX/bin/termuxhiveBear" "$PREFIX/bin/TermuxHiveBear" 2>/dev/null || true
fi

echo ""
echo "🎉 ¡Instalación y alias completados con éxito!"
echo "--------------------------------------------------------"
echo "¡Puedes abrir el menú escribiendo cualquiera de estos comandos:"
echo "  - termuxhivebear"
echo "  - termuxhiveBear"
echo "  - TermuxHiveBear"
echo "--------------------------------------------------------"
