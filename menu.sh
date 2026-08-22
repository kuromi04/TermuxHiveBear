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
    local c_termux='\033[1;36m'  # Cyan para Termux
    local c_hive='\033[1;33m'    # Amarillo/Miel para HiveBear
    local c_line='\033[1;30m'    # Gris oscuro/Negro brillante para separadores
    local c_text='\033[1;37m'    # Blanco brillante para el texto
    local c_reset='\033[0m'
    
    local banner=(
        "${c_termux}  _____                              ${c_reset}"
        "${c_termux} |_   _|___ _ _ _ __ _  ___ __       ${c_reset}"
        "${c_termux}   | |/ -_) '_| '  \\ || \\ \\ /        ${c_reset}"
        "${c_termux}   |_|\\___|_| |_|_|_\\_,_/_\\_\\        ${c_reset}"
        "${c_hive}      _  _ _         ___             ${c_reset}"
        "${c_hive}     | || (_)_ _____| _ ) ___ __ _ _ ${c_reset}"
        "${c_hive}     | __ | \\ V / -_) _ \\/ -_) _\` | '_|${c_reset}"
        "${c_hive}     |_||_|_|\\_/\\___|___/\\___\\__,_|_|  ${c_reset}"
        "${c_line}=======================================${c_reset}"
        "${c_text}    🐻 Interactive Menu by kuromi04 🐻 ${c_reset}"
        "${c_line}=======================================${c_reset}"
    )
    if [ "$LANG_MODE" = "ES" ]; then
        banner[9]="${c_text}    🐻 Menú Interactivo by kuromi04 🐻 ${c_reset}"
    fi
    for i in "${!banner[@]}"; do
        echo -e "${banner[$i]}"
        sleep 0.02
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
        echo " 1) 💬 Iniciar Chat Interactivo (Seleccionar Modelo)"
        echo " 2) 🌐 Iniciar Servidor de API (OpenAI / Ollama Local)"
        echo " 3) 🛑 Detener Servidor API en Segundo Plano"
        echo " 4) 📊 Ver Recomendaciones de Hardware (CPU / RAM)"
        echo " 5) 📦 Descargar / Verificar Modelo Qwen 2.5 0.5B"
        echo " 6) 💾 Ver Almacenamiento Utilizado"
        echo " 7) ❓ Ver Ayuda Completa de HiveBear"
        echo " 8) 🌐 Cambiar Idioma / Switch to English"
        echo " 9) 🔍 Buscar y Descargar Modelos (HuggingFace)"
        echo " 10) 🗑️ Gestionar Modelos Locales (Ver/Borrar)"
        echo " 11) 🔄 Actualizar TermuxHiveBear (Git Pull)"
        echo " 12) 🕸️ Red Mesh P2P (Compartir/Delegar CPU)"
        echo " 0) ❌ Salir"
        echo "=========================================================="
        read -p " Selecciona una opción: " choice
    else
        echo " 1) 💬 Start Interactive Chat (Select Model)"
        echo " 2) 🌐 Start API Server (OpenAI / Ollama Local)"
        echo " 3) 🛑 Stop API Server Running in Background"
        echo " 4) 📊 View Hardware Recommendations (CPU / RAM)"
        echo " 5) 📦 Download / Verify Qwen 2.5 0.5B Model"
        echo " 6) 💾 View Used Disk Storage"
        echo " 7) ❓ View Full HiveBear Help"
        echo " 8) 🌐 Switch Language / Cambiar a Español"
        echo " 9) 🔍 Search and Download Models (HuggingFace)"
        echo " 10) 🗑️ Manage Local Models (View/Delete)"
        echo " 11) 🔄 Update TermuxHiveBear (Git Pull)"
        echo " 12) 🕸️ P2P Mesh Network (Share/Offload CPU)"
        echo " 0) ❌ Exit"
        echo "=========================================================="
        read -p " Select an option: " choice
    fi
    echo ""

    case $choice in
        1)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🚀 Iniciando Chat Interactivo / Seleccionar Modelo..."
            else
                echo "🚀 Starting Interactive Chat / Select Model..."
            fi
            
            if [ ! -d "$HOME/.cache/hivebear/models" ] || [ -z "$(ls -A "$HOME/.cache/hivebear/models" 2>/dev/null)" ]; then
                if [ "$LANG_MODE" = "ES" ]; then
                    echo "⚠️ No se encontraron modelos. Descargando Qwen 2.5 0.5B por defecto..."
                else
                    echo "⚠️ No models found. Downloading default Qwen 2.5 0.5B..."
                fi
                mkdir -p ~/.cache/hivebear/models
                curl -L -o "$MODEL_PATH" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
                hivebear run "$MODEL_PATH"
            else
                mapfile -t LOCAL_MODELS < <(ls -1 "$HOME/.cache/hivebear/models/")
                echo ""
                if [ "$LANG_MODE" = "ES" ]; then
                    echo "📦 Modelos disponibles:"
                else
                    echo "📦 Available models:"
                fi
                for i in "${!LOCAL_MODELS[@]}"; do
                    size=$(du -h "$HOME/.cache/hivebear/models/${LOCAL_MODELS[$i]}" | cut -f1)
                    echo "  $((i+1))) ${LOCAL_MODELS[$i]} ($size)"
                done
                
                echo ""
                if [ "$LANG_MODE" = "ES" ]; then
                    echo "  0) Volver al menú principal"
                    read -p " Selecciona un modelo [0-${#LOCAL_MODELS[@]}]: " RUN_INDEX
                else
                    echo "  0) Back to main menu"
                    read -p " Select a model [0-${#LOCAL_MODELS[@]}]: " RUN_INDEX
                fi
                
                if [ "$RUN_INDEX" = "0" ]; then
                    show_menu
                    return
                elif [[ "$RUN_INDEX" =~ ^[0-9]+$ ]] && [ "$RUN_INDEX" -ge 1 ] && [ "$RUN_INDEX" -le "${#LOCAL_MODELS[@]}" ]; then
                    SELECTED_MODEL="${LOCAL_MODELS[$((RUN_INDEX-1))]}"
                    hivebear run "$HOME/.cache/hivebear/models/$SELECTED_MODEL"
                else
                    if [ "$LANG_MODE" = "ES" ]; then
                        echo "❌ Selección inválida."
                    else
                        echo "❌ Invalid selection."
                    fi
                fi
            fi
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
            if [ "$LANG_MODE" = "ES" ]; then
                echo "📊 Analizando Hardware..."
            else
                echo "📊 Analyzing Hardware..."
            fi
            
            TOTAL_RAM=$(free -m | awk '/Mem:/ {print $2}')
            FREE_RAM=$(free -m | awk '/Mem:/ {print $7}')
            if [ -z "$FREE_RAM" ]; then
                FREE_RAM=$(free -m | awk '/Mem:/ {print $4}')
            fi
            
            if [ -z "$TOTAL_RAM" ] || [ "$TOTAL_RAM" = "" ]; then
                TOTAL_RAM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
                TOTAL_RAM=$((TOTAL_RAM / 1024))
                FREE_RAM=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
                if [ -z "$FREE_RAM" ]; then
                    FREE_RAM=$(grep MemFree /proc/meminfo | awk '{print $2}')
                fi
                FREE_RAM=$((FREE_RAM / 1024))
            fi
            
            echo "------------------------------------------------"
            if [ "$LANG_MODE" = "ES" ]; then
                echo "RAM Total: ${TOTAL_RAM}MB | RAM Disponible: ${FREE_RAM}MB"
                echo "Recomendaciones basadas en memoria disponible:"
                echo "------------------------------------------------"
                echo "🧠 Modelos Pequeños (< 2GB RAM):"
                echo "  - Qwen 2.5 0.5B (q4_k_m) - ~398MB"
                echo "  - TinyLlama 1.1B (q4_k_m) - ~637MB"
                echo "  - Gemma 2B (q4_k_m) - ~1.5GB"
                
                if [ "$FREE_RAM" -gt 3000 ]; then
                    echo "🔥 Modelos Medianos (Recomendados para ti):"
                    echo "  - Llama 3 8B (q4_k_m) - ~4.7GB"
                    echo "  - Mistral 7B (q4_k_m) - ~4.1GB"
                    echo "  - Qwen 2.5 7B (q4_k_m) - ~4.2GB"
                else
                    echo "⚠️ No tienes suficiente RAM para modelos de 7B-8B (Se requieren ~4GB libres)."
                fi
                
                if [ "$FREE_RAM" -gt 8000 ]; then
                    echo "🚀 Modelos Grandes (Hardware potente):"
                    echo "  - Mixtral 8x7B (q4_k_m) - ~26GB"
                    echo "  - Qwen 2.5 14B (q4_k_m) - ~8.5GB"
                fi
                echo "------------------------------------------------"
                echo "💡 Busca estos modelos en la Opción 9 (HuggingFace)"
            else
                echo "Total RAM: ${TOTAL_RAM}MB | Available RAM: ${FREE_RAM}MB"
                echo "Recommendations based on available memory:"
                echo "------------------------------------------------"
                echo "🧠 Small Models (< 2GB RAM):"
                echo "  - Qwen 2.5 0.5B (q4_k_m) - ~398MB"
                echo "  - TinyLlama 1.1B (q4_k_m) - ~637MB"
                echo "  - Gemma 2B (q4_k_m) - ~1.5GB"
                
                if [ "$FREE_RAM" -gt 3000 ]; then
                    echo "🔥 Medium Models (Recommended for you):"
                    echo "  - Llama 3 8B (q4_k_m) - ~4.7GB"
                    echo "  - Mistral 7B (q4_k_m) - ~4.1GB"
                    echo "  - Qwen 2.5 7B (q4_k_m) - ~4.2GB"
                else
                    echo "⚠️ Not enough RAM for 7B-8B models (~4GB free required)."
                fi
                
                if [ "$FREE_RAM" -gt 8000 ]; then
                    echo "🚀 Large Models (Powerful hardware):"
                    echo "  - Mixtral 8x7B (q4_k_m) - ~26GB"
                    echo "  - Qwen 2.5 14B (q4_k_m) - ~8.5GB"
                fi
                echo "------------------------------------------------"
                echo "💡 Search these models in Option 9 (HuggingFace)"
            fi
            
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
                echo " (Deja vacío y presiona Enter para volver / Leave blank to return)"
                read -p " Introduce el término de búsqueda (ej. DeepSeek, Mistral): " SEARCH_TERM
            else
                echo "🔍 Interactive HuggingFace Search"
                echo " (Deja vacío y presiona Enter para volver / Leave blank to return)"
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
                    echo "  0) Volver / Cancel"
                    
                    read -p " Selecciona un repositorio / Select a repo [0-${#MODELS_ARRAY[@]}]: " REPO_INDEX
                    if [ "$REPO_INDEX" = "0" ]; then show_menu; return; fi
                    if [[ "$REPO_INDEX" =~ ^[0-9]+$ ]] && [ "$REPO_INDEX" -ge 1 ] && [ "$REPO_INDEX" -le "${#MODELS_ARRAY[@]}" ]; then
                        SELECTED_REPO="${MODELS_ARRAY[$((REPO_INDEX-1))]}"
                        echo "⏳ Buscando archivos GGUF en / Searching GGUF files in $SELECTED_REPO..."
                        
                        FILES_JSON=$(curl -s "https://huggingface.co/api/models/${SELECTED_REPO}/tree/main")
                        FILES_WITH_SIZE=$(echo "$FILES_JSON" | jq -r '.[] | select(.type=="file" and (.path|endswith(".gguf"))) | "\(.path)|\(.size)"')
                        
                        if [ -z "$FILES_WITH_SIZE" ]; then
                            echo "❌ No se encontraron archivos .gguf en este repositorio / No .gguf files found."
                        else
                            mapfile -t FILES_ARRAY <<< "$FILES_WITH_SIZE"
                            echo ""
                            echo "📦 Archivos disponibles / Available files:"
                            
                            declare -a PURE_FILES_ARRAY
                            for i in "${!FILES_ARRAY[@]}"; do
                                file_name="${FILES_ARRAY[$i]%%|*}"
                                file_size_bytes="${FILES_ARRAY[$i]##*|}"
                                PURE_FILES_ARRAY[$i]="$file_name"
                                
                                if [ "$file_size_bytes" -ge 1073741824 ]; then
                                    size_fmt="$((file_size_bytes / 1073741824)).$(((file_size_bytes % 1073741824) * 10 / 1073741824)) GB"
                                    echo "  $((i+1))) $file_name ($size_fmt)"
                                elif [ "$file_size_bytes" -ge 1048576 ]; then
                                    size_fmt="$((file_size_bytes / 1048576)) MB"
                                    echo "  $((i+1))) $file_name ($size_fmt)"
                                else
                                    echo "  $((i+1))) $file_name ($file_size_bytes B)"
                                fi
                            done
                            echo "  0) Volver / Cancel"
                            
                            read -p " Selecciona un archivo para descargar / Select a file to download [0-${#PURE_FILES_ARRAY[@]}]: " FILE_INDEX
                            if [ "$FILE_INDEX" = "0" ]; then show_menu; return; fi
                            if [[ "$FILE_INDEX" =~ ^[0-9]+$ ]] && [ "$FILE_INDEX" -ge 1 ] && [ "$FILE_INDEX" -le "${#PURE_FILES_ARRAY[@]}" ]; then
                                SELECTED_FILE="${PURE_FILES_ARRAY[$((FILE_INDEX-1))]}"
                                DOWNLOAD_URL="https://huggingface.co/${SELECTED_REPO}/resolve/main/${SELECTED_FILE}"
                                
                                echo "📥 Descargando / Downloading $SELECTED_FILE ..."
                                mkdir -p ~/.cache/hivebear/models
                                curl -L -C - -o ~/.cache/hivebear/models/"$SELECTED_FILE" "$DOWNLOAD_URL"
                                echo "✅ Descarga completada / Download complete."
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
                    echo "  0) Volver al menú principal"
                    read -p " Escribe el número del modelo que deseas BORRAR [0-${#LOCAL_MODELS[@]}]: " DEL_INDEX
                else
                    echo "  0) Back to main menu"
                    read -p " Enter the number of the model you want to DELETE [0-${#LOCAL_MODELS[@]}]: " DEL_INDEX
                fi
                
                if [ "$DEL_INDEX" = "0" ] || [ -z "$DEL_INDEX" ]; then
                    show_menu
                    return
                elif [[ "$DEL_INDEX" =~ ^[0-9]+$ ]] && [ "$DEL_INDEX" -ge 1 ] && [ "$DEL_INDEX" -le "${#LOCAL_MODELS[@]}" ]; then
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
        11)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🔄 Buscando actualizaciones de TermuxHiveBear..."
            else
                echo "🔄 Checking for TermuxHiveBear updates..."
            fi
            cd ~/TermuxHiveBear && git pull && bash install.sh
            echo ""
            read -p " Pulsa ENTER para continuar / Press ENTER to continue..."
            show_menu
            ;;
        12)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "🕸️ Opciones de Red Mesh P2P:"
                echo " 1. Prestar CPU a la red (contribute)"
                echo " 2. Ver estado de la red (status)"
                echo " 3. Ejecutar chat usando la red (mesh run)"
                echo " 4. Compartir modelo vía web (share)"
                echo " 0. Volver al menú principal"
                read -p " Elige una opción: " sub_choice
                case $sub_choice in
                    0) show_menu; return ;;
                    1) hivebear contribute ;;
                    2) hivebear mesh status; read -p "Presiona Enter..." ;;
                    3) 
                        mapfile -t LOCAL_MODELS < <(ls -1 "$HOME/.cache/hivebear/models/" 2>/dev/null || true)
                        if [ ${#LOCAL_MODELS[@]} -eq 0 ]; then
                            echo "⚠️ No se encontraron modelos. Usando Qwen 2.5 por defecto."
                            mpath="$MODEL_PATH"
                        else
                            echo "📦 Modelos disponibles:"
                            for i in "${!LOCAL_MODELS[@]}"; do echo "  $((i+1))) ${LOCAL_MODELS[$i]}"; done
                            echo "  0) Volver al menú principal"
                            read -p " Selecciona un modelo [0-${#LOCAL_MODELS[@]}]: " RUN_INDEX
                            if [ "$RUN_INDEX" = "0" ]; then show_menu; return; fi
                            if [[ "$RUN_INDEX" =~ ^[0-9]+$ ]] && [ "$RUN_INDEX" -ge 1 ] && [ "$RUN_INDEX" -le "${#LOCAL_MODELS[@]}" ]; then
                                mpath="$HOME/.cache/hivebear/models/${LOCAL_MODELS[$((RUN_INDEX-1))]}"
                            else
                                echo "❌ Opción inválida. Usando modelo por defecto."
                                mpath="$MODEL_PATH"
                            fi
                        fi
                        hivebear mesh run "$mpath"
                       ;;
                    4) hivebear share ;;
                    *) echo "Opción inválida" ;;
                esac
            else
                echo "🕸️ P2P Mesh Network Options:"
                echo " 1. Share CPU with network (contribute)"
                echo " 2. View network status (status)"
                echo " 3. Run chat over network (mesh run)"
                echo " 4. Share model via web link (share)"
                echo " 0. Back to main menu"
                read -p " Choose an option: " sub_choice
                case $sub_choice in
                    0) show_menu; return ;;
                    1) hivebear contribute ;;
                    2) hivebear mesh status; read -p "Press Enter..." ;;
                    3) 
                        mapfile -t LOCAL_MODELS < <(ls -1 "$HOME/.cache/hivebear/models/" 2>/dev/null || true)
                        if [ ${#LOCAL_MODELS[@]} -eq 0 ]; then
                            echo "⚠️ No models found. Using default Qwen 2.5."
                            mpath="$MODEL_PATH"
                        else
                            echo "📦 Available models:"
                            for i in "${!LOCAL_MODELS[@]}"; do echo "  $((i+1))) ${LOCAL_MODELS[$i]}"; done
                            echo "  0) Back to main menu"
                            read -p " Select a model [0-${#LOCAL_MODELS[@]}]: " RUN_INDEX
                            if [ "$RUN_INDEX" = "0" ]; then show_menu; return; fi
                            if [[ "$RUN_INDEX" =~ ^[0-9]+$ ]] && [ "$RUN_INDEX" -ge 1 ] && [ "$RUN_INDEX" -le "${#LOCAL_MODELS[@]}" ]; then
                                mpath="$HOME/.cache/hivebear/models/${LOCAL_MODELS[$((RUN_INDEX-1))]}"
                            else
                                echo "❌ Invalid option. Using default model."
                                mpath="$MODEL_PATH"
                            fi
                        fi
                        hivebear mesh run "$mpath"
                       ;;
                    4) hivebear share ;;
                    *) echo "Invalid option" ;;
                esac
            fi
            read -p "Presiona Enter para continuar / Press Enter to continue..."
            show_menu
            ;;
        0)
            if [ "$LANG_MODE" = "ES" ]; then
                echo "👋 ¡Hasta luego! Gracias por usar la red P2P."
                echo "✨ Sistema ensamblado y sellado por: kuromi04 ✨"
            else
                echo "👋 Goodbye! Thanks for using the P2P network."
                echo "✨ System built & sealed by: kuromi04 ✨"
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
