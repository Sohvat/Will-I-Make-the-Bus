# Will I Make the Bus?

**Will I Make the Bus?** is an end-to-end predictive transit system that estimates the likelihood that a user will successfully catch a specific bus if they leave at a given moment.

The project combines **historical transit data**, **real-time arrival APIs**, and **user walking behavior** to produce **probabilistic, decision-oriented predictions** that explicitly model arrival uncertainty rather than relying on static schedules or point estimates.

---

## Motivation
Public transit apps typically display scheduled times or single estimated arrival values, which often fail to capture the uncertainty inherent in real-world transit systems. This project is designed to answer a more practical question:

> *“If I leave now, how likely am I to catch this bus?”*

By integrating historical delay patterns and live arrival data, the system provides clearer, risk-aware guidance to commuters.

---

## System Overview
The project consists of three main components:

1. **Data Processing & Modeling**
   - Ingests GTFS static data (CSV) and real-time transit API responses (JSON)
   - Computes observed delays by comparing scheduled and live arrivals
   - Aggregates historical delay statistics by route, stop, and time of day
   - Applies statistical techniques to estimate arrival uncertainty and probability of success

2. **Prediction Logic**
   - Combines live ETAs, walking-time estimates, and historical delay distributions
   - Produces probability estimates, recommended leave-by times, and confidence tiers
   - Prioritizes explainability and documented assumptions over opaque models

3. **User-Facing Application**
   - Cross-platform mobile app built with Flutter
   - Allows users to select nearby stops and upcoming buses
   - Displays clear decisions (make it / tight / miss) with probability estimates
   - Supports local notifications for leave-time alerts

---

## Data Sources
- **GTFS Static Data (CSV):** stops, routes, trips, scheduled arrivals
- **Real-Time Transit APIs (JSON):** live ETAs and arrival updates
- **Derived Historical Observations:** aggregated delay statistics computed from scheduled vs. observed arrivals
- **User Movement Data:** GPS-based walking time estimates



---

## Evaluation
Prediction behavior is evaluated through scenario-based error analysis, including:
- Peak vs. off-peak travel periods
- Short vs. long walking distances
- High-variability vs. low-variability routes

---

