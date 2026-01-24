# Will I Make the Bus? 🚌⏱️

**A real-time transit decision app that answers one simple question — should you start running?**

Built with Flutter and powered by Winnipeg Transit data, *Will I Make the Bus?* helps commuters decide whether they’ll realistically catch an incoming bus based on walking time, live arrivals, and historical delay patterns.

---

## 🚦 The Problem

If you’ve taken transit in Winnipeg, you’ve asked this before:

> *“If I leave right now… will I actually make the bus?”*

Static schedules don’t account for:
- Walking distance
- Real-time delays
- Your personal pace
- Unreliable arrival predictions

This app turns that uncertainty into a clear **Yes / No** decision.

---

## 🧠 How It Works

Using your current location, the app:

1. Identifies nearby bus stops within walking range  
2. Estimates walking time using your personalized speed  
3. Pulls **real-time arrival data** from Winnipeg Transit  
4. Adjusts predictions using **historical delay trends**  
5. Compares everything and gives you a clear outcome  

**No guesswork. Just timing.**

---

## ✨ Key Features

- **Real-time transit data** via Winnipeg Transit Open API  
- **Predictive adjustments** using historical arrival patterns  
- **Personalized ETAs** based on user walking speed  
- **Binary decision output** (Make it / Miss it) for clarity  
- **Clean, mobile-first UI** built with Material Design  
- **Leave-now notifications** when timing becomes critical  

---

## 🛠️ Tech Stack

**Mobile:** Flutter (Dart)  
**Backend / Data Processing:** Python, Pandas  
**APIs:** Winnipeg Transit Open Data (real-time)  
**Database:** SQLite (local caching)  
**Data Scale:** 6M+ historical transit records processed  

---

## 📱 Screenshots

<div align="center">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2015.26.42.png" width="20%"">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2014.55.23.png" width="20%"">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2015.06.42.png" width="20%"">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2015.26.50.png" width="20%"">
</div>

**Screens shown:**  
1. Home & app entry  
2. Nearby stops ranked by reachability  
3. Stop-level walking time & predictions  
4. Arrival schedule with adjusted ETAs  

---

## 🚀 Setup & Run

### 1. Clone the repository
```bash
git clone https://github.com/Sohvat/Will-I-Make-the-Bus.git
cd Will-I-Make-the-Bus
pub get
