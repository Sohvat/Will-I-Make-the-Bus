# Will I Make the Bus? 🚌

A Flutter mobile app that tells you whether you'll make your bus using real-time transit data and predictive modeling.

## What It Does

Got tired of running for buses only to watch them drive away? This app answers that classic Winnipeg question: **"Will I make the bus?"**

Using your current location and walking speed, the app:
- Finds nearby bus stops
- Calculates walking time to each stop
- Gets real-time bus arrival data from Winnipeg Transit API
- Compares walking time vs. bus arrival time

## Tech Stack

**Frontend:** Flutter (Dart)  
**Backend:** Python (Pandas for data processing)  
**APIs:** Winnipeg Transit Open Data (real-time)  
**Data:** Processed 6M+ historical records of transit data

## Key Features

- **Real-time bus tracking** via Winnipeg Transit API
- **Predictive modelling** based on historical delay patterns
- **Personalized calculations** using your walking speed
- **Clean UI** with Material Design
- **Smart notifications** to tell you when to leave

## Screenshots

<div align="center">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2014.55.23.png" width="45%" alt="Home Screen">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2015.06.42.png" width="45%" alt="Nearby Stops">
  <br>
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2015.26.42.png" width="45%" alt="Stop Selection">
  <img src="screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20Plus%20-%202026-01-24%20at%2015.26.50.png" width="45%" alt="Schedule View">
</div>

## Setup

### 1. Clone & Install
```bash
git clone https://github.com/Sohvat/Will-I-Make-the-Bus.git
cd Will-I-Make-the-Bus
flutter pub get
