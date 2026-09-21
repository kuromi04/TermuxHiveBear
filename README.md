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

### 🛠️ Termux Setup & Execution Commands

#### 1. Create Model Directory & Download GGUF Weights
Due to HuggingFace API constraints on mobile shells, manual model downloading is recommended:
```bash
mkdir -p ~/.cache/hivebear/models
curl -L -o ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf \
  https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
```

#### 2. Run HiveBear Local Inference (Private Chat)
```bash
hivebear run ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf
```

#### 3. Run API Server Mode (OpenAI / Ollama Endpoint)
```bash
hivebear serve
```

### 🛰️ Available Commands Reference

| Command | Description |
|---|---|
| `termuxhivebear` | Open interactive CLI menu |
| `hivebear run <model_path>` | Run interactive chat with a local `.gguf` model |
| `hivebear serve` | Start an OpenAI & Ollama compatible local API server |
| `hivebear recommend` | Show hardware profile and recommended models |
| `hivebear share` | Share local model via public/local web link |
| `hivebear mesh` | Manage P2P distributed inference mesh |

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

### 🛠️ Comandos de Configuración y Ejecución en Termux

#### 1. Crear Directorio de Modelos y Descargar Pesos GGUF
Para garantizar la compatibilidad en Termux, se recomienda descargar el modelo manualmente:
```bash
mkdir -p ~/.cache/hivebear/models
curl -L -o ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf \
  https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf
```

#### 2. Ejecutar Inferencia Local con HiveBear (Chat Privado)
```bash
hivebear run ~/.cache/hivebear/models/qwen2.5-0.5b-instruct-q4_k_m.gguf
```

#### 3. Modo Servidor de API (Endpoint OpenAI / Ollama)
```bash
hivebear serve
```

### 🛰️ Referencia de Comandos

| Comando | Descripción |
|---|---|
| `termuxhivebear` | Abre el menú interactivo por CLI |
| `hivebear run <ruta_modelo>` | Inicia el chat interactivo con el modelo `.gguf` |
| `hivebear serve` | Inicia el servidor de API compatible con OpenAI / Ollama |
| `hivebear recommend` | Muestra el perfil de hardware y modelos recomendados |
| `hivebear share` | Comparte el modelo a través de un enlace web local/público |
| `hivebear mesh` | Administra la red P2P distribuida |

---

## 🤝 Acknowledgments & Special Thanks / Agradecimientos Especiales

- **Original Project:** Created by **[Beckham Labs LLC - HiveBear](https://github.com/BeckhamLabsLLC/HiveBear)**.
- **Special Thanks / Agradecimiento Especial:** Agradecimiento muy especial a **[Ivam3 / Ivam3byCinderella](https://github.com/ivam3)** por su increíble ecosistema **i-HakLab** y su skill **`termux-oracle`**, fundamental para la optimización de Android, Bionic, glibc y el diagnóstico de entornos en Termux.
- **Android Port & Maintainer:** **[kuromi04](https://github.com/kuromi04/TermuxHiveBear)**.
