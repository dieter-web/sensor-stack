# Sensor Stack - Lua DSL + Node.js Runtime + Haskell Core

Ein vollständig modularer Sensorik-Stack bestehend aus:

- ** Lua ** - deklarative DSL für Sensoren, Regeln und Aktionen
- ** Node.js ** - Runtime, IO, Scheduling, Rule Engine
- ** Haskell ** - Validator, Parser, statische Kernlogik

## Struktur

dsl/ # Lua DSL runtime/ # Node.js Runtime
core/ # Haskell Validator

## Starten

node runtime/index.mjs

## Validierung

stack run --validate < config.json


