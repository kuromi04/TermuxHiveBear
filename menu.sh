#!/usr/bin/env bash
# ==============================================================================
# TermuxHiveBear Interactive Menu
# ==============================================================================

set -e

MODEL_PATH="$HOME/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf"

show_menu() {
    clear
    echo "=========================================================="
    echo "       🐻 Menú Interactivo - TermuxHiveBear 🐻           "
    echo "=========================================================="
    echo " 1) 💬 Iniciar Chat Interactivo con IA (Qwen 2.5 0.5B)"
    echo " 2) 🌐 Iniciar Servidor de API (OpenAI / Ollama Local)"
    echo " 3) 📊 Ver Recomendaciones de Hardware (CPU / RAM)"
    echo " 4) 📦 Descargar / Verificar Modelo Qwen 2.5 0.5B"
    echo " 5) 💾 Ver Almacenamiento Utilizado"
    echo " 6) ❓ Ver Ayuda Completa de HiveBear"
    echo " 0) ❌ Salir"
    echo "=========================================================="
    read -p " Selecciona una opción [0-6]: " choice
    echo ""

    case $choice in
        1)
            echo "🚀 Iniciando Chat Interactivo..."
            if [ ! -f "$MODEL_PATH" ]; then
                echo "⚠️ El modelo no está descargado. Descargando primero..."
                mkdir -p ~/.cache/hivebear/models
                curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
            fi
            hivebear run "$MODEL_PATH"
            ;;
        2)
            echo "🌐 Iniciando Servidor API en http://localhost:11434..."
            hivebear serve
            ;;
        3)
            echo "📊 Analizando Hardware..."
            hivebear recommend
            read -p "Presiona Enter para continuar..."
            show_menu
            ;;
        4)
            echo "📦 Descargando modelo Qwen 2.5 0.5B GGUF..."
            mkdir -p ~/.cache/hivebear/models
            curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
            echo "✅ Modelo descargado correctamente."
            read -p "Presiona Enter para continuar..."
            show_menu
            ;;
        5)
            echo "💾 Almacenamiento:"
            hivebear storage
            read -p "Presiona Enter para continuar..."
            show_menu
            ;;
        6)
            echo "❓ Ayuda de HiveBear:"
            hivebear --help
            read -p "Presiona Enter para continuar..."
            show_menu
            ;;
        0)
            echo "👋 ¡Hasta luego!"
            exit 0
            ;;
        *)
            echo "❌ Opción no válida."
            sleep 1
            show_menu
            ;;
    esac
}

show_menu
