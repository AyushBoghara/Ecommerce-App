
# Online Brand Store

The **Online Brand Store** is a modern e-commerce platform designed to provide a seamless shopping experience for customers and efficient management tools for admins. Built with **Flutter** for the frontend, **Firebase** for the backend, and **Cloudinary** for image storage, it ensures real-time synchronization, scalability, and high performance across **Android, iOS, and Web** platforms.

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

---

## 📑 Table of Contents

- [Overview](##overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [References](#references)

---

## 📋 Overview

The Online Brand Store enables customers to browse products, add items to their cart, place orders, and make secure payments. Admins can manage product listings, inventory, orders, and promotions through an intuitive dashboard.  
The platform supports real-time data synchronization, secure transactions, and cross-platform compatibility, making it a robust solution for modern e-commerce businesses.

---

## 🚀 Features

### Customer Features
- Browse and filter products by category, price, or stock status.
- Add products to cart or wishlist.
- Secure checkout with multiple payment options (Razorpay, Cash on Delivery).
- Order tracking and purchase history.
- Product reviews and ratings.

### Admin Features
- Manage products, categories, and inventory.
- Track orders and process refunds.
- View sales analytics and revenue reports.
- Apply promotions and discounts.
- Role-based access control for secure management.

### General Features
- Real-time data updates via Firebase Firestore.
- Optimized media storage with Cloudinary.
- Cross-platform mobile app (Android/iOS) and Web Admin Panel.
- Advanced search with predictive filtering.

---

## 🛠 Tech Stack

| Component          | Technology                  |
|--------------------|------------------------------|
| Frontend           | Flutter (Dart)               |
| Backend            | Firebase (Authentication, Firestore, Cloud Functions) |
| Database           | Firebase Firestore           |
| Image Storage      | Cloudinary                   |
| Payment Gateway    | Razorpay                     |
| Development Tools  | Android Studio, Visual Studio Code |

---

## ⚙️ Installation

### Prerequisites
- Flutter SDK (v3.0 or higher)
- Android Studio or Visual Studio Code
- Firebase account and project setup
- Cloudinary account
- Node.js (optional, for local functions)

### Steps

1. **Clone the repository:**
    ```bash
    git clone https://github.com/username/online-brand-store.git
    cd online-brand-store
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Configure Firebase:**
    - Set up a Firebase project.
    - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
    - Enable Authentication, Firestore, and Cloud Functions.

4. **Configure Cloudinary:**
    - Add Cloudinary API keys to your project environment/configuration files.

5. **Run the App:**
    ```bash
    flutter run
    ```

---

## 📱 Usage

- **Customer App:**  
  Download the app from Google Play or App Store, register/login, browse products, and place orders.

- **Admin Panel:**  
  Access the web-based admin panel to manage products, orders, and view analytics.

- **Development:**  
  Modify the codebase using Android Studio or VS Code, and test on emulators or physical devices.

---
## 📜 License

This project is licensed under the **MIT License**.

---

## 📚 References

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Cloudinary Documentation](https://cloudinary.com/documentation)
- [Razorpay API Documentation](https://razorpay.com/docs/)
- [Dart Programming Language](https://dart.dev/guides)
