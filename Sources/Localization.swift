//
//  Localization.swift
//  Localized
//
//  Created by 锋炜 刘 on 16/7/8.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import Foundation

/// Internal current language key
let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"

/// Default language. English. If English is unavailable defaults to base localization.
let LCLDefaultLanguage = "en"

/// Base bundle as fallback.
let LCLBaseBundle = "Base"

/// Name for language change notification
public let LCLLanguageDidChangeNotification = "LCLLanguageDidChangeNotification"

public final class Localization {
    
    /// List all available languages.
    ///
    /// - Parameter excludingBase: Determine if "Base" wll be excluded from the result.
    /// - Returns: An array of all available language codes.
    public class func availableLanguages(excludingBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.index(of: "Base"), excludingBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        
        return availableLanguages
    }
    
    /// Get current language.
    ///
    /// - Returns: App's current language code.
    public class func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        
        return defaultLanguage()
    }
    
    /// Set the current language.
    ///
    /// - Parameter language: New language code.
    public class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if (selectedLanguage != currentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageDidChangeNotification), object: nil)
        }
    }
    
    /// Get default language.
    ///
    /// - Returns: App's default language code.
    public class func defaultLanguage() -> String {
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        
        return self.availableLanguages().contains(preferredLanguage) ? preferredLanguage : LCLDefaultLanguage
    }
    
    /// Resets the current language to the default.
    public class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    /// Get the current language's display name for a language.
    ///
    /// - Parameter language: Language code.
    /// - Returns: The display name of the specified language.
    public class func displayNameForLanguage(language: String) -> String? {
        let locale = NSLocale(localeIdentifier: currentLanguage())
        
        if let displayName = (locale as NSLocale).displayName(forKey: NSLocale.Key.languageCode, value: language) {
            return displayName
        } else {
            return nil
        }
    }
}
