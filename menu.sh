#!/usr/bin/env bash
# ==============================================================================
# TermuxHiveBear Interactive Animated Bilingual Menu
# Maintained & Authored by: kuromi04
# ==============================================================================

set -e

MODEL_PATH="$HOME/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf"
LANG_MODE="ES"

# Animation helper function
animate_text() {
    local text="$1"
    local delay="${2:-0.015}"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
    echo ""
}

# Spinner animation helper
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

show_banner() {
    clear
    echo "=========================================================="
    echo "       🐻 TermuxHiveBear CLI Menu 🐻                      "
    echo "    Created & Maintained by: kuromi04                     "
    echo "=========================================================="
}

show_menu() {
    show_banner
    if [ "$LANG_MODE" = "ES" ]; then
        echo " 1) 💬 Iniciar Chat Interactivo (Qwen 2.5 0.5B)"
        echo " 2) 🌐 Iniciar Servidor de API (OpenAI / Ollama Local)"
        echo " 3) 🛑 Detener Servidor API en Segundo Plano"
        echo " 4) 📊 Ver Recomendaciones de Hardware (CPU / RAM)"
        echo " 5) 📦 Descargar / Verificar Modelo Qwen 2.5 0.5B"
        echo " 6) 💾 Ver Almacenamiento Utilizado"
        echo " 7) ❓ Ver Ayuda Completa de HiveBear"
        echo " 8) 🌐 Cambiar Idioma / Switch to English"
        echo " 0) ❌ Salir"
        echo "=========================================================="
        read -p " Selecciona una opción [0-8]: " choice
    else
        echo " 1) 💬 Start Interactive Chat (Qwen 2.5 0.5B)"
        echo " 2) 🌐 Start API Server (OpenAI / Ollama Local)"
        echo " 3) 🛑 Stop API Server Running in Background"
        echo " 4) 📊 View Hardware Recommendations (CPU / RAM)"
        echo " 5) 📦 Download / Verify Qwen 2.5 0.5B Model"
        echo " 6) 💾 View Used Disk Storage"
        echo " 7) ❓ View Full HiveBear Help"
        echo " 8) 🌐 Switch Language / Cambiar a Español"
        echo " 0) ❌ Exit"
        echo "=========================================================="
        read -p " Select an option [0-8]: " choice
    fi
    echo ""

    case $choice in
        1)
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "🚀 Iniciando Chat Interactivo por kuromi04..."
            else
                animate_text "🚀 Starting Interactive Chat by kuromi04..."
            fi
            if [ ! -f "$MODEL_PATH" ]; then
                animate_text "⚠️ Modelo no encontrado. Descargando..."
                mkdir -p ~/.cache/hivebear/models
                curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
            fi
            hivebear run "$MODEL_PATH"
            ;;
        2)
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "🌐 Iniciando Servidor API en http://localhost:11434..."
            else
                animate_text "🌐 Starting API Server on http://localhost:11434..."
            fi
            hivebear serve
            ;;
        3)
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "🛑 Buscando y deteniendo servidor API de HiveBear..."
            else
                animate_text "🛑 Searching and stopping HiveBear API server..."
            fi
            PIDS=$(pgrep -f "hivebear serve" || true)
            if [ -n "$PIDS" ]; then
                kill $PIDS 2>/dev/null || kill -9 $PIDS 2>/dev/null
                if [ "$LANG_MODE" = "ES" ]; then
                    animate_text "✅ Servidor API detenido correctamente."
                else
                    animate_text "✅ API Server stopped successfully."
                fi
            else
                if [ "$LANG_MODE" = "ES" ]; then
                    animate_text "ℹ️ No hay ningún servidor API de HiveBear ejecutándose actualmente."
                else
                    animate_text "ℹ️ No HiveBear API server is currently running."
                fi
            fi
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        4)
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "📊 Analizando perfil de hardware..."
            else
                animate_text "📊 Analyzing hardware profile..."
            fi
            hivebear recommend
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        5)
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "📦 Descargando/Verificando modelo Qwen 2.5 0.5B..."
            else
                animate_text "📦 Downloading/Verifying Qwen 2.5 0.5B model..."
            fi
            mkdir -p ~/.cache/hivebear/models
            curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "✅ Modelo verificado/descargado correctamente."
            else
                animate_text "✅ Model verified/downloaded successfully."
            fi
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        6)
            hivebear storage
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        7)
            hivebear --help
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        8)
            if [ "$LANG_MODE" = "ES" ]; then
                LANG_MODE="EN"
            else
                LANG_MODE="ES"
            fi
            show_menu
            ;;
        0)
            if [ "$LANG_MODE" = "ES" ]; then
                animate_text "👋 ¡Hasta luego! Gracias por usar TermuxHiveBear de kuromi04."
            else
                animate_text "👋 Goodbye! Thanks for using TermuxHiveBear by kuromi04."
            fi
            exit 0
            ;;
        *)
            animate_text "❌ Opción no válida / Invalid option."
            sleep 1
            show_menu
            ;;
    esac
}

show_menu
