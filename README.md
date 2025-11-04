# marketly

Marketly is a simple, clean Flutter eCommerce application that demonstrates a typical shopping flow backed by remote APIs. It includes onboarding and authentication flows, product browsing, category filters, product detail pages, cart and checkout flows, and a basic user profile.

## Project overview

This repository contains the Marketly Flutter app used as a demo and starting point for eCommerce app development. The app is built with Flutter and consumes RESTful APIs for product data, authentication, cart, and orders.

Key points:
- Flutter (Dart) mobile application targeting Android and iOS.
- Communicates with a backend API (REST/JSON) for auth, products, cart, and orders.
- Local assets (images) used for UI mockups and screenshots are in `assets/` and `assets/screens/`.

## Features

- Onboarding screens with CTA to sign up or login.
- Email/password authentication (login, signup, forgot/reset password flows).
- Product listing and categories with filter/section views.
- Product detail screen with images, description, and add-to-cart.
- Cart management (add/remove/update quantity) and a checkout flow.
- User profile screen to view/edit account details.

## Tech stack

- Flutter (stable) & Dart
- Uses HTTP APIs (REST/JSON) for backend communication
- Asset management via Flutter assets (images in `assets/`)

## API / Backend (what to expect)

This project expects the app to call backend endpoints for core operations. Typical endpoints the app expects (adjust to your backend):

- POST /auth/login — returns access token and user info
- POST /auth/register — create new user
- POST /auth/forgot — start password recovery
- POST /auth/reset — complete password reset
- GET /products — list products with optional filters
- GET /products/:id — product details
- GET /categories — categories and sections
- POST /cart — add item to cart
- GET /cart — get cart items
- PUT /cart/:itemId — update quantity
- DELETE /cart/:itemId — remove item
- POST /orders — place an order

Authentication is typically token-based (Bearer token). Configure the base API URL and keys inside the app's services (see `lib/services/`).

## How to run (development)

Prerequisites:
- Flutter SDK installed and configured
- Android Studio / Xcode (for simulators or real devices)

Basic steps:
1. From the project root, get dependencies:

   flutter pub get

2. Run on a connected device or emulator:

   flutter run

3. To build release APK (Android):

   flutter build apk --release

Adjust platform-specific settings in `android/` or `ios/` as needed.

## Assets

All UI screenshots used in this README are stored in `assets/screens/`. App images (icons, product placeholders) are in the other subfolders of `assets/`.

If you add/remove images make sure to update `pubspec.yaml` to include them under the `flutter.assets:` section.

## Screens

Below are UI screenshots from the app (images live in `assets/screens/`). Each row shows three images and a short description for each image in the same order. For each screen I also list the primary backend endpoints that the screen typically interacts with.

<!-- Row 1 -->
![Splash Screen](assets/screens/splash_screen.png) ![Onboarding 1](assets/screens/onboarding_1.png) ![Onboarding 2](assets/screens/onboarding_2.png)

- Splash Screen — The initial app launch screen that displays branding and a quick loading state while the app initializes (e.g., checking auth state and loading cached config). It is lightweight and usually shows for a second or two before routing to onboarding or home. APIs: none or a lightweight config/auth check (e.g., GET /auth/me).
- Onboarding 1 — The first onboarding slide that highlights the app's primary benefits and value proposition. It explains why users should use the app and leads them toward sign up or login. APIs: none (static content).
- Onboarding 2 — The second onboarding slide that describes key features and helpful tips, often with illustrations. Designed to educate users quickly before they start using the app. APIs: none (static content).

<!-- Row 2 -->
![Onboarding 3](assets/screens/onboarding_3.png) ![Login Screen](assets/screens/login_screen.png) ![Sign Up](assets/screens/signup_screen.png)

- Onboarding 3 — Final onboarding slide with a clear call-to-action (CTA) to either sign up or log in. It typically triggers navigation into the authentication flow. APIs: none (static content).
- Login Screen — Authentication UI for existing users. Accepts email and password, performs client-side validation, displays errors, and sends credentials to the backend (POST /auth/login). On success it stores the auth token and navigates to Home.
- Sign Up — Registration form where new users provide details to create an account. Performs validation and calls the registration endpoint (POST /auth/register), then may auto-login or prompt the user to verify their email.

<!-- Row 3 -->
![Forgot Password](assets/screens/forget_pass_screen.png) ![Reset Password](assets/screens/reset_pass_screen.png) ![Success Login](assets/screens/success_login.png)

- Forgot Password — Starts the password recovery flow by collecting the user's email and sending a request to the backend (POST /auth/forgot). The backend typically sends an email or OTP for verification. UX shows instructions and confirmation states.
- Reset Password — Allows the user to input a new password after verifying identity (OTP or reset token). Calls POST /auth/reset (or /auth/reset/:token) to update credentials and shows success/failure states.
- Success Login — A small confirmation state/screen displayed after successful authentication or account creation. It gives feedback before redirecting to the main app. APIs: none (display-only), but follows a successful POST /auth/login or POST /auth/register.

<!-- Row 4 -->
![Home Screen](assets/screens/home_screen.png) ![Product Details](assets/screens/products_details.png) ![Cart Add](assets/screens/cart_add.png)

- Home Screen — Main product discovery screen with banners, featured items, and category shortcuts. It retrieves product lists and promotional content (GET /products, GET /promotions, GET /categories) and supports paging and basic filters.
- Product Details — Shows product images, price, full description, and reviews. It loads detailed product data from GET /products/:id and may fetch related items or seller info (GET /products/:id/related).
- Cart Add — Visual state demonstrating adding an item to the cart (or a mini-cart confirmation). This action posts to the cart API (POST /cart) and updates local/app state.

<!-- Row 5 -->
![Cart Delete](assets/screens/cart_delet.png) ![Categories](assets/screens/categories_screen.png) ![Categories Alt](assets/screens/categories_screen_1.png)

- Cart Delete — Full cart screen showing items, quantities, and total pricing. Users can update quantities (PUT /cart/:itemId) or remove items (DELETE /cart/:itemId) and proceed to checkout (POST /orders).
- Categories — Browse categories and tap into a category to view its items. Loads category data and lists (GET /categories, GET /products?category=:id) and supports filters and sorting.
- Categories (alt) — An alternative layout for the categories screen, useful for exploring different UX/visual states. APIs: same as Categories (GET /categories, GET /products?category=:id).

<!-- Row 6 -->
![Categories Sections](assets/screens/categories_sections.png) ![Categories Sections Alt](assets/screens/categories_sections_1.png) ![Each Category](assets/screens/each_categories_.png)

- Categories Sections — Shows subsections inside a selected category to help users narrow results (subcategories, featured lists). Loads specific lists via GET /categories/:id/sections or GET /products?section=:id.
- Categories Sections (alt) — Alternate sectioned layout for categories; may show filters or promotional tiles. APIs: same as above (GET /categories/:id/sections, GET /products).
- Each Category — Item listing view for a single category; users can tap items to view details. Uses GET /products?category=:id with pagination and filter parameters.

<!-- Row 7 -->
![Example](assets/screens/example.png) ![Profile Section](assets/screens/profile_section.png) ![Example (duplicate)](assets/screens/example.png)

- Example — Placeholder or example layout used during development and design exploration. It helps demonstrate UI patterns without being tied to a specific endpoint. APIs: none (development asset).
- Profile Section — User account screen where profile data, address book, and order history are shown. Reads and writes profile info via GET /auth/me, PUT /auth/me and fetches orders (GET /orders).
- Example (duplicate) — Duplicate of the example image to maintain the 3-image-per-row layout. Replace with any other asset if you prefer; just tell me which file to use.
