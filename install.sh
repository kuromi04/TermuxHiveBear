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

PRIMARY_URL="https://github.com/kuromi04/HiveBear/releases/latest/download/hivebear-aarch64-linux-android.tar.gz"
FALLBACK_URL="https://github.com/kuromi04/TermuxHiveBear/releases/latest/download/hivebear-aarch64-linux-android.tar.gz"

INSTALLED=0

# Intentamos descargar el binario ARM64 precompilado actualizado
if curl --output /dev/null --silent --head --fail -L "$PRIMARY_URL"; then
    echo "📥 Descargando binario precompilado de hivebear (ARM64) desde kuromi04/HiveBear..."
    if curl -L -f -o "$PREFIX/tmp/hivebear.tar.gz" "$PRIMARY_URL"; then
        tar xzf "$PREFIX/tmp/hivebear.tar.gz" -C "$PREFIX/bin/"
        chmod +x "$PREFIX/bin/hivebear"
        rm -f "$PREFIX/tmp/hivebear.tar.gz"
        INSTALLED=1
        echo "✅ Binario de hivebear instalado y actualizado correctamente."
    fi
fi

if [ "$INSTALLED" -eq 0 ] && curl --output /dev/null --silent --head --fail -L "$FALLBACK_URL"; then
    echo "📥 Descargando binario precompilado de hivebear (ARM64) desde kuromi04/TermuxHiveBear..."
    if curl -L -f -o "$PREFIX/tmp/hivebear.tar.gz" "$FALLBACK_URL"; then
        tar xzf "$PREFIX/tmp/hivebear.tar.gz" -C "$PREFIX/bin/"
        chmod +x "$PREFIX/bin/hivebear"
        rm -f "$PREFIX/tmp/hivebear.tar.gz"
        INSTALLED=1
        echo "✅ Binario de hivebear instalado y actualizado correctamente (fallback)."
    fi
fi

if [ "$INSTALLED" -eq 0 ]; then
    if command -v cargo &> /dev/null; then
        echo "🔨 Compilando hivebear desde código fuente con cargo en Termux..."
        export ANDROID_NDK=$PREFIX
        if cargo build --release -p hivebear-cli --bin hivebear --no-default-features --features "api,cloud,candle"; then
            cp target/release/hivebear "$PREFIX/bin/hivebear"
            chmod +x "$PREFIX/bin/hivebear"
            INSTALLED=1
            echo "✅ Compilado e instalado correctamente con cargo."
        else
            echo "⚠️ Error al compilar hivebear en Termux."
        fi
    else
        echo "❌ No se encontró cargo ni un release precompilado disponible."
    fi
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
