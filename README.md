Project Description

Currency Exchange Calculator is a native iOS app that converts USD ↔ selected currencies in real time. 
Users can enter amounts in either field, swap currencies, and select a different currency via a bottom sheet. 
Exchange rates are fetched from the DolarApp API, with a local fallback used when the currencies list API is unavailable.

Tech Stack

Language: Swift
UI: UIKit
Architecture: MVC
Networking: URLSession (REST), JSON decoding with Codable
Concurrency: GCD (DispatchQueue) / async updates on main thread
Dependency Management: None (pure Xcode project)

How to Run
1. Clone the repository:
    git clone <repo-url>
    cd <repo-folder>
2. Open the project in Xcode:
    Double-click the .xcodeproj file, or run:
    open *.xcodeproj
3. Select a simulator (or a real device) and press Run (⌘R)

Requirements: 
Xcode 15+ (recommended), iOS 16+ (or your chosen deployment target)
