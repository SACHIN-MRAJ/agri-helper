<div align="center">

<img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
<img src="https://img.shields.io/badge/AI-Groq%20LLM-00A67E?style=for-the-badge&logo=openai&logoColor=white"/>
<img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=for-the-badge&logo=android&logoColor=white"/>
<img src="https://img.shields.io/badge/SIH-2025-FF6B35?style=for-the-badge"/>

# 🌾 Agri Helper — AI Crop Yield Prediction & Optimization

**Smart India Hackathon 2025 | Problem Statement SIH25044**  
*Government of Odisha Initiative*

> An AI-powered mobile application that helps Indian farmers make data-driven decisions about crop yield prediction, nutrient management, and real-time farming advisory — in their regional language.

</div>

---

## 📱 Features

| Feature | Description |
|---|---|
| 🤖 **AI Yield Prediction** | Groq LLM-powered crop yield analysis with 5-year historical weather data |
| 🌤️ **Live Weather** | Real-time weather & 5-day forecast via OpenWeatherMap API |
| 📊 **Nutrient Analysis** | Detailed N-P-K deficit analysis with fertilizer recommendations |
| 🗺️ **GPS Auto-Fill** | Auto-detects district, soil type & NPK levels from GPS location |
| 📋 **My Advisory** | Saves all AI predictions with yield history & bar charts |
| ⚠️ **Risk Alerts** | Waterlogging, pest, and weather risk alerts per crop & season |
| 🌍 **Multi-Language** | Supports English, हिंदी, தமிழ், and ଓଡ଼ିଆ |
| 📈 **Yield Scenarios** | What-if analysis for optimized NPK management |

---

## 🛠️ Tech Stack

```
Flutter 3.x (Dart 3.x)
├── AI / Backend
│   └── Groq LLM API          — AI crop analysis & smart suggestions
│   └── OpenWeatherMap API    — Live weather + 5-day forecast
│   └── Open-Meteo API        — 5-year historical weather data
│
├── Flutter Packages
│   ├── fl_chart              — Bar & line charts for yield visualization
│   ├── geolocator            — GPS location detection
│   ├── geocoding             — Reverse geocoding (coords → district)
│   ├── shared_preferences    — Local storage for advisory history
│   ├── http                  — REST API calls
│   ├── intl                  — Internationalization (i18n)
│   └── image_picker          — Soil image scan (future feature)
│
└── Platforms
    ├── Android
    └── iOS
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code with Flutter plugin
- A physical device or emulator (Android API 21+ / iOS 12+)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/SACHIN-MRAJ/agri-helper.git
cd agri_helper

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Environment Configuration

This app uses Groq LLM for AI crop analysis and OpenWeatherMap for live forecast data.

1. Setup environment configuration:
   ```bash
   # Linux/macOS
   cp lib/core/config/app_environment.template.dart lib/core/config/app_environment.dart

   # Windows (PowerShell)
   Copy-Item lib/core/config/app_environment.template.dart lib/core/config/app_environment.dart
   ```

2. Add your API credentials in `lib/core/config/app_environment.dart` or supply them via compile-time parameters:
   - **Groq Cloud API Key:** Free at [console.groq.com](https://console.groq.com)
   - **OpenWeatherMap API Key:** Free at [openweathermap.org](https://openweathermap.org/api)

> 🔒 **Security Architecture:** `lib/core/config/app_environment.dart` is git-ignored and credentials use runtime memory decoding. Alternatively, inject keys securely via `--dart-define=GROQ_API_KEY=...` and `--dart-define=WEATHER_API_KEY=...`.

---

## 📂 Project Structure

```
agri_helper/
├── lib/
│   ├── main.dart               # Entire app — all screens & logic
│   ├── marketplace/            # (reserved — future Agri Marketplace)
│   └── workplace/              # (reserved — future Agri Bidding)
│
├── android/                    # Android platform files
├── ios/                        # iOS platform files
├── test/                       # Unit & widget tests
├── pubspec.yaml                # Dependencies
└── README.md                   # You are here
```

---

## 📸 Screenshots

| Home | Predict | AI Analysis | Advisory |
|:---:|:---:|:---:|:---:|
| 🏠 Weather + Crops | 📝 Farm Details Form | 📊 Yield + NPK Charts | 📋 History & Stats |

---

## 🧠 How It Works

```
User Inputs (Crop, Area, District, Season)
        │
        ▼
GPS Auto-Fill ──► District → Soil Type + NPK defaults
        │
        ▼
Live Weather Fetch (OpenWeatherMap)
        │
        ▼
5-Year Historical Weather (Open-Meteo)
        │
        ▼
Groq LLM Analysis
        │
        ├─► Expected Yield (kg/acre)
        ├─► Risk Alerts (waterlogging, pest, drought)
        ├─► Fertilizer Recommendations (N-P-K)
        ├─► AI Smart Suggestions (bullet points)
        └─► Similar Past Years
        │
        ▼
Saved to Local Advisory History (SharedPreferences)
```

---

## 🌐 Supported Languages

| Language | Code |
|---|---|
| English | `en` |
| हिंदी (Hindi) | `hi` |
| தமிழ் (Tamil) | `ta` |
| ଓଡ଼ିଆ (Odia) | `or` |

---

## 🏆 Hackathon Context

| Field | Details |
|---|---|
| **Event** | Smart India Hackathon 2025 |
| **Problem ID** | SIH25044 |
| **Category** | Agriculture & Rural Development |
| **Ministry** | Government of Odisha |
| **Theme** | AI-Powered Crop Yield Prediction & Optimization |

---

## 👨‍💻 Team

Built with ❤️ by **Team Agri Helper** for SIH 2025.

- Sachin — Flutter Developer (AI Integration & Core UI)
- Selva — Flutter Developer (Advisory UI Module)

---

## 📄 License

This project is built for Smart India Hackathon 2025 and is not licensed for commercial use.

---

<div align="center">

Made with 🌾 for Indian farmers

**[⭐ Star this repo if you found it useful!]**

</div>
