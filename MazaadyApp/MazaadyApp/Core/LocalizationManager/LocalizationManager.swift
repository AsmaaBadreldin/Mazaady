//
//  LocalizationManager.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()
    
    private init() {}

    var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.language.languageCode?.identifier ?? "en"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "AppLanguage")
            NotificationCenter.default.post(name: .languageChanged, object: nil)
        }
    }

    func localizedString(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

extension Notification.Name {
    static let languageChanged = Notification.Name("LanguageChangedNotification")
}
