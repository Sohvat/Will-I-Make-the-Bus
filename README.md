# Will I Make the Bus? 🚌

A Flutter mobile app that tells you whether you'll make your bus using real-time transit data and predictive modeling.

## What It Does

Got tired of running for buses only to watch them drive away? This app answers that classic Winnipeg question: **"Will I make the bus?"**

Using your current location and walking speed, the app:
- Finds nearby bus stops
- Calculates walking time to each stop
- Gets real-time bus arrival data from Winnipeg Transit API
- Compares walking time vs. bus arrival time
- Gives you a clear ✅ Yes or ❌ No answer

## Tech Stack

**Frontend:** Flutter (Dart)  
**Backend:** Python (Pandas for data processing)  
**APIs:** Winnipeg Transit Open Data (real-time)  
**Database:** SQLite (cached transit data)  
**Data:** Processed 6M+ historical records of transit data

## Key Features

- **Real-time bus tracking** via Winnipeg Transit API
- **Predictive modeling** based on historical delay patterns
- **Personalized calculations** using your walking speed
- **Clean UI** with Material Design
- **Smart notifications** to tell you when to leave

## Screenshots

<div align="center">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2014.55.23.png" width="30%" alt="Home Screen">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2014.55.23.png" width="30%" alt="Stop Selection">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2014.55.23.png" width="30%" alt="Prediction View">
</div>

## Setup

### 1. Clone & Install
```bash
git clone https://github.com/Sohvat/Will-I-Make-the-Bus.git
cd Will-I-Make-the-Bus
flutter pub get
