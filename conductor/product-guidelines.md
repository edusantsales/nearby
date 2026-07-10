# Nearby - Product Guidelines

## Text and Voice Style

**Tone:** Friendly and close. The language should be warm and inviting, making the user feel welcome and encouraged to explore local offers.

**Guidelines:**
- Use the second person ("you") to create proximity
- Short, conversational sentences (e.g., "How about saving today?")
- Avoid technical jargon — simple and accessible language
- Inviting CTAs instead of cold imperatives ("Redeem my coupon" instead of "Redeem")
- Empathetic error messages (e.g., "Oops! We couldn't load the offers. How about trying again?")

## Branding and Visual Identity

**Color Palette (keep current):**
- **Green (primary):** #257F49 (greenBase) — main brand color, used in buttons and highlight elements
- **Light green:** #3B9B62 (greenLight) — for hover/secondary states
- **Dark green:** #052914 (greenDark) — for text on light backgrounds and high-contrast elements
- **Red (alerts):** #F94144 (redBase) — used sparingly for errors and alerts
- **Gray tones:** gray100 (#FCFDFE) to gray600 (#1A1F24) — for backgrounds, texts, and borders

**Typography:**
- Family: **Rubik** (Regular, Medium, SemiBold, Bold)
- Hierarchy: titleXL (24/Bold) → titleLG (20/Bold) → titleMD (16/SemiBold) → textMD (16/Regular) → textSM (14/Regular) → textXS (12/Regular)
- Always provide fallback for systemFont

## UX Principles

### 1. Performance First
- The interface must respond instantly to user interactions
- Network operations must not block the UI — always show skeleton content or loading states
- Images must load asynchronously and progressively
- Optimize re-renders and avoid unnecessary layouts

### 2. Clear Visual Feedback
- Every user action must have immediate feedback (visual, haptic, or textual)
- Loading states: use appropriate spinners or skeletons
- Success states: clear visual confirmation (e.g., coupon redeemed with animation)
- Error states: clear message + retry action
- Empty states: illustrations or messages that guide the user

### 3. Minimal Friction
- Reduce the number of taps to complete primary actions (especially coupon redemption)
- Prefer contextual actions instead of deep menus
- Do not require login/registration to explore offers (if possible)
- Intuitive navigation with familiar iOS gestures

## Localization and Language

**Strategy:** pt-BR as default language, with preparation for English (en).

**Guidelines:**
- All user-visible text must use localizable strings
- Do not hardcode Portuguese texts directly into views
- Use String Catalogs or Localizable.strings to manage translations
- Set up i18n structure from the beginning, even if only pt-BR is implemented
- Format dates, numbers, and currency according to the device's locale

## Naming Conventions

- **Portuguese** for domain names/business rules (categories, markets, coupons)
- **English** for code, variables, filenames, and architecture
- Maintain consistency with the existing Prisma schema and Swift models
