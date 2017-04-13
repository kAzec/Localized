//
//  String+Localized.swift
//  Localized
//
//  Created by 锋炜 刘 on 16/7/8.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import Foundation

public extension String {
    /**
     Get localized version of `self`.
     
     - returns: The localized string.
     */
    func localized() -> String {
        if let path = Bundle.main.path(forResource: Localization.currentLanguage(), ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        } else if let path = Bundle.main.path(forResource: LCLBaseBundle, ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        }
        
        return self
    }
    
    /**
     Get localized and formatted version of `self` with format arguments.
     
     - parameter arguments: Arguments to determine formation.
     
     - returns: The localized and formatted string.
     */
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
    
    /**
     Get localized and pluralized version of `self` with a argument.
     
     - parameter argument: Argument to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(_ argument: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized() as NSString, argument) as String
    }
    
    /**
     Get localized and pluralized version of `self` with arguments.
     
     - parameter argx: Arguments to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(_ arg1: CVarArg, _ arg2: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized() as NSString, arg1, arg2) as String
    }
    
    /**
     Get localized and pluralized version of `self` with arguments.
     
     - parameter argx: Arguments to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(_ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized() as NSString, arg1, arg2, arg3) as String
    }
    
    /**
     Get localized and pluralized version of `self` with arguments.
     
     - parameter argx: Arguments to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(_ arg1: CVarArg, _ arg2: CVarArg, _ arg3: CVarArg, _ arg4: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized() as NSString, arg1, arg2, arg3, arg4) as String
    }
}
