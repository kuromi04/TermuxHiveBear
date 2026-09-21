![TermuxHiveBear Banner](termux_hivebear_banner.jpg)

# 🐻 TermuxHiveBear

> **Decentralized P2P Local AI Inference on Termux Android**  
> *Inferencia de IA Local y Descentralizada P2P en Termux Android*

[![GitHub fork](https://img.shields.io/badge/Forked%20From-BeckhamLabsLLC%2FHiveBear-blue?style=for-the-badge&logo=github)](https://github.com/BeckhamLabsLLC/HiveBear)
[![Termux Compatible](https://img.shields.io/badge/Termux-Official%20App-brightgreen?style=for-the-badge&logo=android)](https://github.com/termux/termux-app)
[![Architecture](https://img.shields.io/badge/Architecture-ARM64%20%2F%20aarch64-orange?style=for-the-badge)](https://github.com/kuromi04/TermuxHiveBear)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

---

## ⚡ 1-Line Automatic Installer / Instalador Automático en 1 Línea

Run this single command in Termux to install everything automatically:  
*Ejecuta este único comando en Termux para instalar todo automáticamente:*

```bash
git clone https://github.com/kuromi04/TermuxHiveBear.git && cd TermuxHiveBear && bash install.sh
```

### 🚀 Usage after installation / Uso tras la instalación
Once installed, simply type **`termuxhivebear`** anytime from any directory to open the interactive CLI menu:  
*Una vez instalado, simplemente escribe **`termuxhivebear`** desde cualquier carpeta para abrir el menú interactivo:*

```bash
termuxhivebear
```

---

## 🌐 Languages / Idiomas

- [English Documentation](#-english-documentation)
- [Documentación en Español](#-documentación-en-español)

---

## 🇬🇧 English Documentation

### 📌 About The Project
**TermuxHiveBear** is a specialized port and deployment guide for running [HiveBear](https://github.com/BeckhamLabsLLC/HiveBear) (by Beckham Labs LLC) natively inside **Termux** on Android devices. HiveBear enables decentralized peer-to-peer (P2P) mesh local LLM inference across devices, running fast GGUF models on ARM64 architectures using `llama.cpp` and Rust.

### 📲 Termux Installation Recommendation
> ⚠️ **IMPORTANT:** Always install Termux from its official **GitHub Releases** repository. **DO NOT** use the outdated Google Play Store version as its repositories are deprecated.

* Download latest APK from GitHub: [termux/termux-app Releases](https://github.com/termux/termux-app/releases)

### ✨ Core Features & Usage Guide

#### 💬 100% Private Local Chat
By downloading `.gguf` AI models directly to your device, you can run an interactive chat right from your terminal or via the API. 
* **🔒 Maximum Security:** Your conversations are completely private. No data, prompts, or personal information ever leaves your phone.
* **📵 Offline Capable:** Chat anywhere, anytime, without needing an internet connection.

#### 🕸️ Decentralized P2P Mesh Network (The Karma System)
TermuxHiveBear shines when connected to the **Mesh Network**. You can collaboratively run AI models that are too heavy for a single phone by splitting the workload across multiple devices!

| Option | Action | Description |
| :---: | :--- | :--- |
| **🛠️** | **Contribute (Earn Karma)** | Connect your phone as a worker node. Your device will process small fragments of models for the network. In exchange, you **earn Karma points**. |
| **🚀** | **Run Mesh Models (Spend Karma)** | Use your accumulated Karma to execute massive, heavy AI models that would normally crash your phone. The network divides the work among all active peers! |
| **📡** | **Network Status** | View real-time statistics of the Mesh, including how many devices are currently connected to the coordinator and ready to help. |

### 🎛️ Interactive Menu Options Explained
When you run `termuxhivebear`, you will see a main menu. Here is what each option does:

1. **💬 Start Interactive Chat:** Opens a terminal chat with any AI model you have downloaded. Completely offline.
2. **🌐 Start API Server:** Instead of a text chat, this starts a background server (`http://localhost:11434`) that mimics the **OpenAI / Ollama API**. You can connect external GUI apps (like NextChat, AnythingLLM) or code editors to your phone, tricking them into using your local model instead of paying for ChatGPT.
3. **🛑 Stop API Server:** Kills the background API server started in Option 2 to free up RAM.
4. **📊 View Hardware Recommendations:** Analyzes your Android's CPU and RAM to recommend which models will run smoothly without crashing.
5. **📦 Download Qwen 2.5 0.5B:** Downloads the default, highly optimized AI model to get you started immediately.
6. **💾 View Used Disk Storage:** Checks how much storage space your downloaded models are taking up.
7. **❓ View Full HiveBear Help:** Displays advanced CLI arguments for power users.
8. **🌐 Switch Language:** Toggles the menu interface between English and Spanish.
9. **🔍 Search and Download Models:** Lets you search for any model directly from HuggingFace and download it automatically.
10. **🗑️ Manage Local Models:** Lists all downloaded models and allows you to easily delete the ones you no longer use to free up space.
11. **🔄 Update TermuxHiveBear:** Automatically pulls the latest code from GitHub and updates your installation.
12. **🕸️ P2P Mesh Network:** Opens the Mesh sub-menu to Contribute (earn Karma) or Run distributed models.

### 🛠️ Manual Execution Commands
If you prefer bypassing the interactive menu, you can use the raw binaries:
```bash
# Run a specific model interactively
hivebear run ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf

# Start the API server manually
hivebear serve
```

---

## 🇪🇸 Documentación en Español

### 📌 Acerca del Proyecto
**TermuxHiveBear** es una adaptación y guía de despliegue especializada para ejecutar [HiveBear](https://github.com/BeckhamLabsLLC/HiveBear) (de Beckham Labs LLC) de manera nativa dentro de **Termux** en dispositivos Android. HiveBear permite la inferencia descentralizada P2P de modelos de lenguaje (LLM) entre dispositivos, ejecutando modelos GGUF ultrarrápidos en arquitecturas ARM64 con `llama.cpp` y Rust.

### 📲 Recomendación de Instalación de Termux
> ⚠️ **IMPORTANTE:** Descarga e instala siempre la aplicación Termux desde su repositorio oficial en **GitHub Releases**. **NO** utilices la versión obsoleta de Google Play Store, ya que sus repositorios están deprecados.

* Descargar el APK oficial desde GitHub: [termux/termux-app Releases](https://github.com/termux/termux-app/releases)

### ✨ Funciones Principales y Guía de Uso

#### 💬 Chat Local 100% Privado y Seguro
Al descargar los modelos de IA en formato `.gguf` directamente a tu dispositivo, puedes tener conversaciones inteligentes desde tu terminal.
* **🔒 Seguridad Máxima:** Tu información es completamente privada. Como la IA se ejecuta localmente en tu celular, ningún dato, pregunta o conversación se envía a la nube ni sale de tu dispositivo.
* **📵 Funciona Sin Internet:** Puedes chatear en cualquier momento y lugar, totalmente offline.

#### 🕸️ Red Mesh P2P Descentralizada (El Sistema de Karma)
El verdadero poder de TermuxHiveBear se libera al usar la **Red Mesh**. ¡Puedes ejecutar modelos de IA gigantescos (que normalmente harían colapsar tu celular) dividiendo el trabajo entre múltiples dispositivos!

| Opción | Acción | Descripción |
| :---: | :--- | :--- |
| **🛠️** | **Contribuir (Ganar Karma)** | Conecta tu celular como "trabajador". Tu dispositivo procesará pequeños fragmentos de modelos para la red. A cambio de tu poder de procesamiento, **ganas puntos de Karma**. |
| **🚀** | **Ejecutar Modelo (Gastar Karma)** | Usa el Karma acumulado para solicitar la ejecución de modelos de IA muy pesados. El coordinador dividirá mágicamente la tarea entre todos los celulares conectados a la malla. |
| **📡** | **Estado de la Red** | Revisa en tiempo real las estadísticas de la red Mesh, viendo cuántos nodos y dispositivos están activos y listos para procesar información. |

### 🎛️ Explicación de las Opciones del Menú
Al ejecutar `termuxhivebear`, verás un menú principal interactivo. Esto es lo que hace cada opción:

1. **💬 Iniciar Chat Interactivo:** Abre un chat de texto en tu pantalla con cualquier modelo de IA que hayas descargado. 100% sin internet.
2. **🌐 Iniciar Servidor de API:** En lugar de abrir un chat, enciende un servidor invisible en el fondo (`http://localhost:11434`) que habla el mismo idioma que la **API de OpenAI y Ollama**. Esto te permite conectar aplicaciones gráficas externas (como NextChat), editores de código o scripts a tu celular, "engañándolos" para que usen tu IA local gratuita en lugar de pagar por ChatGPT.
3. **🛑 Detener Servidor API:** Apaga el servidor encendido en la Opción 2 para liberar la memoria RAM de tu celular.
4. **📊 Ver Recomendaciones de Hardware:** Analiza el procesador y la memoria libre de tu Android para recomendarte qué tamaño de modelo funcionará fluido sin trabar tu celular.
5. **📦 Descargar Modelo Qwen 2.5 0.5B:** Descarga automáticamente el modelo por defecto, optimizado y ultraligero para que puedas empezar a probar la IA de inmediato.
6. **💾 Ver Almacenamiento Utilizado:** Calcula cuánto espacio de tu memoria interna están ocupando los modelos descargados.
7. **❓ Ver Ayuda Completa:** Muestra comandos y argumentos avanzados para usuarios experimentados.
8. **🌐 Cambiar Idioma:** Alterna toda la interfaz del menú entre Español e Inglés.
9. **🔍 Buscar y Descargar Modelos:** Te permite buscar cualquier modelo directamente en HuggingFace y descargarlo con un solo clic.
10. **🗑️ Gestionar Modelos Locales:** Te muestra una lista de los modelos que tienes guardados y te permite borrar los que ya no uses para recuperar espacio.
11. **🔄 Actualizar TermuxHiveBear:** Se conecta a GitHub y descarga la última versión del código para mantener tu instalación siempre al día.
12. **🕸️ Red Mesh P2P:** Abre el submenú de la red compartida para Contribuir (ganar Karma) o usar la potencia distribuida para modelos pesados.

### 🛠️ Comandos de Ejecución Manual
Si prefieres saltarte el menú interactivo, puedes usar los comandos directos:
```bash
# Iniciar chat interactivo directamente con un modelo
hivebear run ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf

# Iniciar el servidor API manualmente
hivebear serve
```

---

## 🤝 Acknowledgments & Special Thanks / Agradecimientos Especiales

- **Original Project:** Created by **[Beckham Labs LLC - HiveBear](https://github.com/BeckhamLabsLLC/HiveBear)**.
- **Special Thanks / Agradecimiento Especial:** Agradecimiento muy especial a **[Ivam3 / Ivam3byCinderella](https://github.com/ivam3)** por su increíble ecosistema **i-HakLab** y su skill **`termux-oracle`**, fundamental para la optimización de Android, Bionic, glibc y el diagnóstico de entornos en Termux.
- **Android Port & Maintainer:** **[kuromi04](https://github.com/kuromi04/TermuxHiveBear)**.
