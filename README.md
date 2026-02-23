# Saudi Tourist App 🇸🇦

A comprehensive mobile application developed as the **Final Project** for the **Flutter Bootcamp** presented by **Teacher Mohammed Alawaji**. This project serves as an interactive guide to explore the most iconic tourist destinations in Saudi Arabia, built with a focus on modern UI/UX and robust backend integration.

## 📖 Project Overview
The **Saudi Tourist App** is designed to provide users with a seamless experience to discover the heritage and beauty of Saudi Arabia (Riyadh, AlUla, Qassim, and more). It transforms the idea of a simple travel guide into a functional, data-driven application that handles real-time authentication, data persistence, and interactive content management.

## 🚀 Key Features

* [cite_start]**Secure Authentication**: A fully functional Sign-up and Login system powered by **Supabase Auth**, ensuring user data privacy and personalized experiences[cite: 22, 23].
* [cite_start]**Dynamic Destination Explorer**: Users can browse a curated list of Saudi landmarks, each featuring high-quality images and detailed descriptions[cite: 12].
* **Personalized Favorites**: Logged-in users can toggle favorite status for any location. [cite_start]These preferences are stored in the database and accessible via a dedicated "My Favorites" screen[cite: 24].
* **Smart "Add Place" Modal (Creative Feature)**: An advanced contribution system that allows users to either add a new place to an existing city or define a brand-new city. [cite_start]This feature utilizes dynamic dropdowns and real-time database insertion[cite: 115].
* **Rich Media Galleries**: Each destination includes a dedicated photo gallery with captions, providing a deeper visual insight into the location.
* [cite_start]**Responsive & Interactive UI**: Built using custom extensions for navigation and sizing, ensuring the app looks great on all device screens[cite: 11, 12].

## 🛠 Technical Stack & Quality Standards

* [cite_start]**Frontend**: [Flutter](https://flutter.dev/) - Utilizing a well-organized project structure (Models, Screens, Utils)[cite: 26, 27, 89].
* [cite_start]**Backend**: [Supabase](https://supabase.com/) - Leveraging the Supabase Flutter package for database management and user sessions[cite: 22].
* [cite_start]**State Management**: Optimized using `StatefulBuilder` and `setState` for real-time UI updates during data fetching and user interactions[cite: 12].
* [cite_start]**Data Modeling**: Implemented robust Dart models for JSON parsing, ensuring clean and readable code[cite: 97, 98].

---

## 📸 App Screenshots

### 🔐 Authentication Flow
<table align="center">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c8dd04ef-5178-4947-8fa0-6057c2f09736" width="220" />
      <br /><b>Login Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/1bbce8ba-dc14-452c-adf7-5a47c3446c6a" width="220" />
      <br /><b>Sign Up Screen</b>
    </td>
  </tr>
</table>

### 🗺️ Discovery & Exploration
<table align="center">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/d708b9b2-a637-4e46-afd6-58505b702cb1" width="220" />
      <br /><b>Home / Explore Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/ff717e0f-3bbf-40b1-968d-87b2f61f63b8" width="220" />
      <br /><b>Riyadh Details</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/ee789e5f-5c6c-4e7d-8b01-8831de779226" width="220" />
      <br /><b>Photo Gallery</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/71e7796e-7d59-4326-8c97-fba8d409590d" width="220" />
      <br /><b>AlUla Details</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/fb236586-8332-4951-a17e-aa757e559930" width="220" />
      <br /><b>Qassim Details</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/67a1e2bd-500f-4025-b7d0-554acf479248" width="220" />
      <br /><b>My Favorites List</b>
    </td>
  </tr>
</table>

### ➕ Management & Contribution
<table align="center">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8fc27dd0-5672-418e-9955-6bd0f61b20ac" width="220" />
      <br /><b>Existing City Modal</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8a0b5365-15e2-498b-a79e-aac5a092f080" width="220" />
      <br /><b>Add New City Flow</b>
    </td>
  </tr>
</table>

---

## 📊 Database Structure (Supabase Dashboard)
The application architecture is supported by a relational database on Supabase. Below is a snapshot of the `places` table schema:

<p align="center">
  <img src="https://github.com/user-attachments/assets/d7d9da97-5403-47c9-99b7-1348149bb626" width="850" alt="Supabase Table Screenshot">
  <br /><i>Real-time Database View showing stored destinations and metadata.</i>
</p>

---
**Developed for the Flutter Bootcamp Final Project - Presented by Teacher Mohammed Alawaji.**



