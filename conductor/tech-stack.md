# Nearby - Tech Stack

## Overview

The Nearby project uses a full-stack architecture with a native iOS app in Swift + SwiftUI and Firebase as backend/infrastructure.

## Frontend (iOS)

### Language
- **Swift** (current Xcode version)

### UI Framework
- **SwiftUI** (migration in progress from UIKit)
- UIKit temporarily maintained during transition

### Architecture
- **MVVM-C** (Model-View-ViewModel-Coordinator)
- Coordinator pattern for navigation (preserved in the migration)
- ViewModels for presentation logic and state
- Declarative views with SwiftUI

### Libraries and Native Frameworks
- **MapKit** — interactive map and annotations
- **CoreLocation** — user geolocation
- **URLSession** — networking (to be replaced by Firebase SDK)
- **Foundation** — base infrastructure

### Design System
- **Typography:** Rubik (Regular, Medium, SemiBold, Bold) with fallback to systemFont
- **Colors:** Green palette (greenLight/greenBase/greenDark), red (redBase) and gray scales (gray100-gray600)

## Backend (Firebase)

### Platform
- **Firebase** — backend-as-a-service (BaaS)

### Firebase Services (to be defined as migration progresses)
- **Firestore** — real-time NoSQL database (replacing SQLite + Prisma)
- **Firebase Auth** — user authentication (if needed in the future)
- **Firebase Storage** — image storage (merchant covers, logos)
- **Firebase Cloud Functions** — server logic (e.g., coupon generation, availability decrement)
- **Firebase Remote Config** — dynamic configurations without deployment

### Data Models (Firestore)
- **categories** — { id, name }
- **markets** — { id, name, description, coupons, latitude, longitude, address, phone, cover, categoryId, rules[] }
- **coupons** — coupons generated via Cloud Functions

### Validation
- Client-side validation (Swift) and Firestore security rules
- Cloud Functions for sensitive operations (coupon redemption, atomic decrement)

## Infrastructure and Tools

### iOS Development
- **Xcode** — IDE and build system
- **Swift Package Manager (SPM)** — dependency management (Firebase iOS SDK)
- **CocoaPods** — legacy (to be replaced by SPM)

### Versioning
- **Git** — version control
- **GitHub** — remote repository

## iOS Dependencies (Planned)
- `firebase-ios-sdk` — Firebase SDK for iOS (Auth, Firestore, Storage, Functions)
- Other dependencies managed via SPM

## Notes
- The MVVM-C architecture will be preserved
- The data contract (models: Category, Place/Market, Rules) will be kept, only the data source changes from REST API to Firestore
