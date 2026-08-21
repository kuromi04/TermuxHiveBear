#!/usr/bin/env bash
# ==============================================================================
# TermuxHiveBear Interactive Bilingual Menu (English & Español)
# ==============================================================================

set -e

MODEL_PATH="$HOME/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf"

# Language state (default: Spanish / Español)
LANG_MODE="ES"

show_banner() {
    clear
    local colors=('\033[1;31m' '\033[1;32m' '\033[1;33m' '\033[1;34m' '\033[1;35m' '\033[1;36m')
    local banner=(
        "  _____                              "
        " |_   _|___ _ _ _ __ _  ___ __       "
        "   | |/ -_) '_| '  \\ || \\ \\ /        "
        "   |_|\\___|_| |_|_|_\\_,_/_\\_\\        "
        "      _  _ _         ___             "
        "     | || (_)_ _____| _ ) ___ __ _ _ "
        "     | __ | \\ V / -_) _ \\/ -_) _\` | '_|"
        "     |_||_|_|\\_/\\___|___/\\___\\__,_|_|  "
        "======================================="
        "    🐻 Interactive Menu by kuromi04 🐻 "
        "======================================="
    )
    if [ "$LANG_MODE" = "ES" ]; then
        banner[9]="    🐻 Menú Interactivo by kuromi04 🐻 "
    fi
    for i in "${!banner[@]}"; do
        color="${colors[$RANDOM % ${#colors[@]}]}"
        echo -e "${color}${banner[$i]}\033[0m"
        sleep 0.03
    done
    
    echo ""
    local tips_es=(
        "💡 Tip: Los modelos Q4_K_M tienen el mejor balance de velocidad y memoria."
        "💡 Tip: Usa la Opción 2 para conectar TermuxHiveBear con Walkie o JCode."
        "💡 Tip: Revisa la Opción 4 si no estás seguro de cuánta RAM libre tienes."
        "💡 Tip: ¿Descargaste un modelo malo? Bórralo con la Opción 10 para liberar espacio."
    )
    local tips_en=(
        "💡 Tip: Q4_K_M models offer the best balance between speed and memory."
        "💡 Tip: Use Option 2 to connect TermuxHiveBear to Walkie or JCode APIs."
        "💡 Tip: Check Option 4 if you are unsure how much free RAM you have."
        "💡 Tip: Downloaded a bad model? Delete it using Option 10 to free space."
    )
    
    if [ "$LANG_MODE" = "ES" ]; then
        echo -e "\033[1;33m${tips_es[$RANDOM % ${#tips_es[@]}]}\033[0m"
    else
        echo -e "\033[1;33m${tips_en[$RANDOM % ${#tips_en[@]}]}\033[0m"
    fi
    echo ""
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
        echo " 9) 🔍 Buscar y Descargar Modelos (HuggingFace)"
        echo " 10) 🗑️ Gestionar Modelos Locales (Ver/Borrar)"
        echo " 0) ❌ Salir"
        echo "=========================================================="
        read -p " Selecciona una opción: " choice
    else
        echo " 1) 💬 Start Interactive Chat (Qwen 2.5 0.5B)"
        echo " 2) 🌐 Start API Server (OpenAI / Ollama Local)"
        echo " 3) 🛑 Stop API Server Running in Background"
        echo " 4) 📊 View Hardware Recommendations (CPU / RAM)"
        echo " 5) 📦 Download / Verify Qwen 2.5 0.5B Model"
        echo " 6) 💾 View Used Disk Storage"
        echo " 7) ❓ View Full HiveBear Help"
        echo " 8) 🌐 Switch Language / Cambiar a Español"
        echo " 9) 🔍 Search and Download Models (HuggingFace)"
        echo " 10) 🗑️ Manage Local Models (View/Delete)"
        echo " 0) ❌ Exit"
        echo "=========================================================="
        read -p " Select an option: " choice
    fi
    echo ""

    case $choice in
        1)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🚀 Iniciando Chat Interactivo..."
            else
                echo "🚀 Starting Interactive Chat..."
            fi
            if [ ! -f "$MODEL_PATH" ]; then
                echo "⚠️ Model not found. Downloading..."
                mkdir -p ~/.cache/hivebear/models
                curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
            fi
            hivebear run --batch-size 4096 "$MODEL_PATH"
            ;;
        2)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🌐 Iniciando Servidor API en http://localhost:11434..."
            else
                echo "🌐 Starting API Server on http://localhost:11434..."
            fi
            hivebear serve
            ;;
        3)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🛑 Buscando y deteniendo servidor API de HiveBear..."
            else
                echo "🛑 Searching and stopping HiveBear API server..."
            fi
            PIDS=$(pgrep -f "hivebear serve" || true)
            if [ -n "$PIDS" ]; then
                kill $PIDS 2>/dev/null || kill -9 $PIDS 2>/dev/null
                if [ "$LANG_MODE" = "ES" ]; then
                    echo "✅ Servidor API detenido correctamente."
                else
                    echo "✅ API Server stopped successfully."
                fi
            else
                if [ "$LANG_MODE" = "ES" ]; then
                    echo "ℹ️ No hay ningún servidor API de HiveBear ejecutándose actualmente."
                else
                    echo "ℹ️ No HiveBear API server is currently running."
                fi
            fi
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        4)
            hivebear recommend
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        5)
            mkdir -p ~/.cache/hivebear/models
            curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
            if [ "$LANG_MODE" = "ES" ]; then
                echo "✅ Modelo verificado/descargado correctamente."
            else
                echo "✅ Model verified/downloaded successfully."
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
        9)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🔍 Buscador Interactivo de HuggingFace"
                read -p " Introduce el término de búsqueda (ej. DeepSeek, Mistral): " SEARCH_TERM
            else
                echo "🔍 Interactive HuggingFace Search"
                read -p " Enter search term (e.g. DeepSeek, Mistral): " SEARCH_TERM
            fi
            
            if [ -n "$SEARCH_TERM" ]; then
                if ! command -v jq &> /dev/null; then
                    echo "⚠️ 'jq' is not installed. Installing it via pkg..."
                    pkg install -y jq
                fi
                echo "⏳ Buscando repositorios... / Searching repositories..."
                MODEL_IDS=$(curl -s "https://huggingface.co/api/models?search=${SEARCH_TERM}+gguf&sort=downloads&direction=-1&limit=8" | jq -r '.[].modelId')

                if [ -z "$MODEL_IDS" ] || [ "$MODEL_IDS" = "null" ]; then
                    echo "❌ No se encontraron modelos / No models found."
                else
                    mapfile -t MODELS_ARRAY <<< "$MODEL_IDS"
                    echo ""
                    echo "📚 Repositorios encontrados / Found repositories:"
                    for i in "${!MODELS_ARRAY[@]}"; do
                        echo "  $((i+1))) ${MODELS_ARRAY[$i]}"
                    done
                    
                    read -p " Selecciona un repositorio / Select a repo [1-${#MODELS_ARRAY[@]}]: " REPO_INDEX
                    if [[ "$REPO_INDEX" =~ ^[0-9]+$ ]] && [ "$REPO_INDEX" -ge 1 ] && [ "$REPO_INDEX" -le "${#MODELS_ARRAY[@]}" ]; then
                        SELECTED_REPO="${MODELS_ARRAY[$((REPO_INDEX-1))]}"
                        echo "⏳ Buscando archivos GGUF en / Searching GGUF files in $SELECTED_REPO..."
                        
                        FILES=$(curl -s "https://huggingface.co/api/models/${SELECTED_REPO}" | jq -r '.siblings[].rfilename | select(endswith(".gguf"))')
                        
                        if [ -z "$FILES" ]; then
                            echo "❌ No se encontraron archivos .gguf en este repositorio / No .gguf files found."
                        else
                            mapfile -t FILES_ARRAY <<< "$FILES"
                            echo ""
                            echo "📦 Archivos disponibles / Available files:"
                            for i in "${!FILES_ARRAY[@]}"; do
                                echo "  $((i+1))) ${FILES_ARRAY[$i]}"
                            done
                            
                            read -p " Selecciona un archivo para descargar / Select a file to download [1-${#FILES_ARRAY[@]}]: " FILE_INDEX
                            if [[ "$FILE_INDEX" =~ ^[0-9]+$ ]] && [ "$FILE_INDEX" -ge 1 ] && [ "$FILE_INDEX" -le "${#FILES_ARRAY[@]}" ]; then
                                SELECTED_FILE="${FILES_ARRAY[$((FILE_INDEX-1))]}"
                                DOWNLOAD_URL="https://huggingface.co/${SELECTED_REPO}/resolve/main/${SELECTED_FILE}"
                                
                                echo "📥 Descargando / Downloading $SELECTED_FILE ..."
                                mkdir -p ~/.cache/hivebear/models
                                curl -L -C - -o ~/.cache/hivebear/models/"$SELECTED_FILE" "$DOWNLOAD_URL"
                                echo "✅ Descarga completada / Download complete."
                                echo "💡 Para usarlo, cambia MODEL_PATH en el script o usa: hivebear run ~/.cache/hivebear/models/$SELECTED_FILE"
                            else
                                echo "❌ Selección cancelada o inválida / Selection cancelled or invalid."
                            fi
                        fi
                    else
                        echo "❌ Selección cancelada o inválida / Selection cancelled or invalid."
                    fi
                fi
            fi
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        10)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "📦 Modelos descargados en ~/.cache/hivebear/models/ :"
            else
                echo "📦 Downloaded models in ~/.cache/hivebear/models/ :"
            fi
            echo ""
            
            if [ ! -d "$HOME/.cache/hivebear/models" ] || [ -z "$(ls -A "$HOME/.cache/hivebear/models")" ]; then
                if [ "$LANG_MODE" = "ES" ]; then
                    echo "ℹ️ No hay modelos descargados."
                else
                    echo "ℹ️ No models downloaded."
                fi
            else
                mapfile -t LOCAL_MODELS < <(ls -1 "$HOME/.cache/hivebear/models/")
                for i in "${!LOCAL_MODELS[@]}"; do
                    size=$(du -h "$HOME/.cache/hivebear/models/${LOCAL_MODELS[$i]}" | cut -f1)
                    echo "  $((i+1))) ${LOCAL_MODELS[$i]} ($size)"
                done
                
                echo ""
                if [ "$LANG_MODE" = "ES" ]; then
                    read -p " Escribe el número del modelo que deseas BORRAR (o presiona Enter para cancelar): " DEL_INDEX
                else
                    read -p " Enter the number of the model you want to DELETE (or press Enter to cancel): " DEL_INDEX
                fi
                
                if [[ "$DEL_INDEX" =~ ^[0-9]+$ ]] && [ "$DEL_INDEX" -ge 1 ] && [ "$DEL_INDEX" -le "${#LOCAL_MODELS[@]}" ]; then
                    FILE_TO_DEL="${LOCAL_MODELS[$((DEL_INDEX-1))]}"
                    if [ "$LANG_MODE" = "ES" ]; then
                        read -p " ⚠️ ¿Estás seguro de borrar $FILE_TO_DEL? (s/n): " confirm
                        if [[ "$confirm" == [sS]* ]]; then
                            rm -f "$HOME/.cache/hivebear/models/$FILE_TO_DEL"
                            echo "✅ Modelo borrado."
                        else
                            echo "❌ Cancelado."
                        fi
                    else
                        read -p " ⚠️ Are you sure you want to delete $FILE_TO_DEL? (y/n): " confirm
                        if [[ "$confirm" == [yY]* ]]; then
                            rm -f "$HOME/.cache/hivebear/models/$FILE_TO_DEL"
                            echo "✅ Model deleted."
                        else
                            echo "❌ Cancelled."
                        fi
                    fi
                fi
            fi
            echo ""
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        0)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "👋 ¡Hasta luego!"
            else
                echo "👋 Goodbye!"
            fi
            exit 0
            ;;
        *)
            echo "❌ Opción no válida / Invalid option."
            sleep 1
            show_menu
            ;;
    esac
}

show_menu
