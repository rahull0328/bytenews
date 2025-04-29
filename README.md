# 📱 ByteNews - Flutter News App

ByteNews is a sleek and modern mobile news application built with **Flutter**, designed to deliver real-time news fetched from [NewsAPI.org](https://newsapi.org/). The app supports both **Android** and **iOS** platforms, featuring a beautiful UI, category-based filtering, webview integration, and performance enhancements like shimmer loading and image caching.

---

## ✨ Features

- 📌 **Cross-platform** support: Works on Android & iOS devices.
- 📰 **Live News Feed**: Fetches latest headlines from NewsAPI.
- 🖼️ **Image Carousel (Slider)**: Stunning image slider on the homepage.
- 📚 **Category-wise News**: Browse news by categories like Business, Sports, Health, Entertainment, etc.
- 🌐 **WebView Integration**: Opens full news articles in a webview linked to the official news site.
- 💫 **Shimmer Effect**: Smooth skeleton loading animation while content is fetched.
- 🗂️ **Image Caching**: Reduces network load by caching news images on the device.

---

## 🚀 Getting Started

### 🔧 Prerequisites

- Flutter SDK installed. [Install Flutter](https://flutter.dev/docs/get-started/install)
- Android Studio / Xcode (for platform-specific builds)
- NewsAPI Key from [https://newsapi.org](https://newsapi.org)

### 🛠️ Installation

```bash
git clone https://github.com/rahull0328/bytenews.git
cd bytenews
flutter pub get
```

### 🔑 Add API Key

- Create a secrets.dart file (or use .env securely) and insert your NewsAPI key:

```dart
const String newsApiKey = "YOUR_NEWS_API_KEY";
```

---

### 💡 Future Improvements
- 🔍 Search functionality

- 🌙 Dark mode

- 📥 Offline storage and bookmarks

- 🔔 Push notifications for breaking news