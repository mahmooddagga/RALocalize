//
//  Localization.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 11/26/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import UIKit

open class RALocalize: NSObject {

    // MARK: Default language
    public static var defaultLanguageCode: String? = Locale.current.languageCode

    // MARK: - Available languages
    open class var availableLanguages: [RALanguage] {
        var availableLanguages = Bundle.main.localizations
        if let index = availableLanguages.firstIndex(of: "Base") {
            availableLanguages.remove(at: index)
        }
        return availableLanguages.map { RALanguage(code: $0) }
    }

    // MARK: - Current language code
    open class var currentLanguage: RALanguage? {
        if let currentLanguage = UserDefaults.standard.string(forKey: RALocalizeUserDefaultKey) {
            return RALanguage(code: currentLanguage)
        }
        guard let currentLanguageCode = defaultLanguageCode else { return nil }
        UserDefaults.standard.set(currentLanguageCode, forKey: RALocalizeUserDefaultKey)
        return RALanguage(code: currentLanguageCode)
    }

    // MARK: - Change language
    open class func changeLanguage(language: RALanguage) {
        guard availableLanguages.contains(language), currentLanguage != language else { return }

        var appleLanguageIdentifiers = Locale.preferredLanguages
        let languageCodes = appleLanguageIdentifiers.map { identifier -> String in
            let components = Locale.components(fromIdentifier: identifier)
            return components[NSLocale.Key.languageCode.rawValue] ?? ""
        }

        let selectedIndex = languageCodes.firstIndex(of: language.code) ?? 0
        let languageIdentifier = appleLanguageIdentifiers[selectedIndex]
        appleLanguageIdentifiers.remove(at: selectedIndex)
        appleLanguageIdentifiers.insert(languageIdentifier, at: 0)

        UserDefaults.standard.set(language.code, forKey: RALocalizeUserDefaultKey)
        UserDefaults.standard.set(appleLanguageIdentifiers, forKey: "AppleLanguages")
        NotificationCenter.default.post(name: .ApplicationLanguageChanged, object: nil)
    }

    // MARK: - Change language with code
    open class func changeLanguage(languageCode: String) {
        let language = RALanguage(code: languageCode)
        changeLanguage(language: language)
    }

    // MARK: - Check for language change
    open class func checkForLanguageChange() {
        guard let changedLanguage = Locale.preferredLanguages.first, let currentLanguage = UserDefaults.standard.string(forKey: RALocalizeUserDefaultKey) else { return }
        let components = Locale.components(fromIdentifier: changedLanguage)
        let languageCode = components[NSLocale.Key.languageCode.rawValue] ?? ""
        guard languageCode != currentLanguage else { return }
        changeLanguage(languageCode: languageCode)
    }
}

