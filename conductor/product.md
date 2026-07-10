# Initial Concept

A mobile benefits club app (Nearby) that offers coupons for use at nearby establishments. Users discover nearby coupons/offers, filter by categories, view establishment info, and redeem coupons directly in the app.

# Nearby - Product Guide

## Overview

Nearby is a mobile benefits club application for iOS that connects users looking for deals with coupons and discounts at establishments close to their location. As a portfolio/learning project, it demonstrates modern iOS development practices with a full-stack architecture.

## Target Users

**Primary:** Deal hunters — people actively looking for local discounts and offers in nearby establishments. They value convenience, clear savings, and easy coupon redemption.

## Core Value Proposition

Discover and redeem exclusive coupons at establishments near you. Save money on everyday purchases while exploring local businesses.

## Key Features

### Nearby Benefits Discovery (Core)
- Explore available coupons and offers at establishments near the user's location
- Interactive map showing participating locations with custom pins
- Results based on user location

### Category Filter
- Filter establishments by categories (Food, Shopping, Health, Entertainment, etc.)
- Quick filter buttons for agile navigation

### Establishment Information
- View contact details, address, and hours
- View establishment rules and coupon terms
- Cover images for each location

### Coupon Redemption
- Redeem coupons directly through the application
- Generate unique coupon codes per redemption
- Real-time coupon availability tracking

## Design Principles

- **Clean and intuitive UI:** Minimal friction between discovering an offer and redeeming it
- **Location-first:** Geolocation is central to the experience — the app highlights what is *nearby*
- **Reliable information:** Clear rules, precise establishment details, transparent coupon terms
- **pt-BR Localization:** The app targets Brazilian users with texts in Portuguese

## Project Context

- **Type:** Portfolio / learning project
- **Platform:** iOS (native)
- **UI Evolution:** Swift + SwiftUI
- **Backend:** Firebase
- **Architecture:** MVVM-C (Model-View-ViewModel-Coordinator)

## Future Considerations

- **Real Location Services:** Currently uses a default fixed location (São Paulo). Future iterations should integrate CoreLocation for actual user positioning.
- **Error Handling:** Improve user-visible error states (network failures, no results, etc.) with proper feedback in the UI.
