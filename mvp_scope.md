# Will I Make the Bus? — MVP Scope

## Project Overview
**Will I Make the Bus?** is a predictive transit system designed to estimate the probability that a user will successfully catch a specific bus if they leave at a given moment. The system combines real-time transit data, historical delay patterns, and user walking behavior to produce probabilistic, decision-oriented predictions.

---

## Target City / Transit Agency
**City:** [Winnipeg]  
**Transit Agency:** [Winnipeg Transit]

---

## User Goal
Help a commuter answer the question:

> “If I leave now, what is the likelihood that I will catch this bus?”

The system prioritises actionable decisions over raw schedule information.

---

## What Version 1 (MVP) WILL Include
- Cross-platform mobile application built with Flutter
- Integration with real-time transit APIs (JSON)
- Historical transit delay preprocessing from GTFS CSV data
- Probabilistic prediction of catching a bus (not just yes/no)
- Walking-time estimation using user location
- Local notifications for leave-time alerts
- Scenario-based evaluation and documentation of model behaviour
- User accounts or authentication

---

## What Version 1 (MVP) Will NOT Include
- Route re-planning or alternate-route suggestions
- Weather-based modelling
- Advanced machine learning models (e.g., neural networks)

---

## Prediction 
- prioritises avoiding missed buses, even if it suggests leaving earlier  

---
