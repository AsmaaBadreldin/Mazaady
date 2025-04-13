
---

## 🧱 Architecture Decisions

- **UIKit + Programmatic Layout**: Chosen for full control over layout and performance.
- **MVP Architecture**: 
  - Keeps business logic in the Presenter.
  - Views are passive and reusable.
  - Makes unit testing easier.
- **Protocol-Oriented Design**: For better decoupling between view and presenter.
- **Modular Structure**: Isolates the profile module and allows easier maintenance and scalability.
- **Custom Views**:
  - `SearchBarView`, `TagListView`, `ProductGridView`, `ProfileHeaderView`, etc.
- **Dynamic Height Calculation**:
  - ScrollView with `UIStackView` to handle flexible content (e.g., banners, tags).
- **Localization Support**: Strings and direction support for English and Arabic with runtime switching.

---

## 🚀 How to Run the Project

1. Clone the repository.
2. Open the project in **Xcode**.
3. Run on simulator or real device.
4. The default entry point is set in `SceneDelegate.swift` to show `MainTabBarController`.

---

## ⚖️ Trade-offs & Assumptions

- **Offline caching** is not yet implemented but designed to be modular and pluggable.
- **Search filtering** is handled inside the `ProductGridView` to avoid presenter bloat.
- Tags and products are fetched from **separate APIs**, assuming no dependency between them.
- The centered store tab button uses a `CustomTabBar` for styling — may require custom layout tweaks across different devices.
- **Scene reload for localization** is implemented via `reloadAppInterface()` in `SceneDelegate`.


---

## 🧪 Coming Enhancements

- Add Unit Tests for Presenter layer  
- Add loading/error states  
- Implement offline caching for products  
- Enhance accessibility & RTL support  
