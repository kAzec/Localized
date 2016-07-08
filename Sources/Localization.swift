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

public class Localization {
    /**
     List available languages.
     
     - parameter excludingBase: should Base be excluded from the result.
     
     - returns: Available language codes.
     */
    public class func availableLanguages(excludingBase: Bool = false) -> [String] {
        var availableLanguages = NSBundle.mainBundle().localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.indexOf("Base") where excludingBase == true {
            availableLanguages.removeAtIndex(indexOfBase)
        }
        
        return availableLanguages
    }
    
    /**
     Get current language.
     
     - returns: App's current language code.
     */
    public class func currentLanguage() -> String {
        if let currentLanguage = NSUserDefaults.standardUserDefaults().objectForKey(LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        
        return defaultLanguage()
    }
    
    /**
     Set the current language.
     
     - parameter language: New language code.
     */
    public class func setCurrentLanguage(language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if (selectedLanguage != currentLanguage()){
            NSUserDefaults.standardUserDefaults().setObject(selectedLanguage, forKey: LCLCurrentLanguageKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            NSNotificationCenter.defaultCenter().postNotificationName(LCLLanguageDidChangeNotification, object: nil)
        }
    }
    
    /**
     Get default language.
     
     - returns: App's default language code.
     */
    public class func defaultLanguage() -> String {
        guard let preferredLanguage = NSBundle.mainBundle().preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        
        return self.availableLanguages().contains(preferredLanguage) ? preferredLanguage : LCLDefaultLanguage
    }
    
    /**
     Resets the current language to the default.
     */
    public class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    /**
     Get the current language's display name for a language.
     
     - Parameter language: Desired language.
     
     - Returns: The localized string.
     */
    
    /**
     Get the current language's display name for a language.
     
     - parameter language: String language code.
     
     - returns: The display name specified language.
     */
    public class func displayNameForLanguage(language: String) -> String? {
        let locale = NSLocale(localeIdentifier: currentLanguage())
        
        if let displayName = locale.displayNameForKey(NSLocaleLanguageCode, value: language) {
            return displayName
        } else {
            return nil
        }
    }
}