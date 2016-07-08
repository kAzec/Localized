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
        if let path = NSBundle.mainBundle().pathForResource(Localization.currentLanguage(), ofType: "lproj"), bundle = NSBundle(path: path) {
            return bundle.localizedStringForKey(self, value: nil, table: nil)
        } else if let path = NSBundle.mainBundle().pathForResource(LCLBaseBundle, ofType: "lproj"), bundle = NSBundle(path: path) {
            return bundle.localizedStringForKey(self, value: nil, table: nil)
        }
        
        return self
    }
    
    /**
     Get localized and formatted version of `self` with format arguments.
     
     - parameter arguments: Arguments to determine formation.
     
     - returns: The localized and formatted string.
     */
    func localizedFormat(arguments: CVarArgType...) -> String {
        return String(format: localized(), arguments: arguments)
    }
    
    /**
     Get localized and pluralized version of `self` with a argument.
     
     - parameter argument: Argument to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(argument: CVarArgType) -> String {
        return NSString.localizedStringWithFormat(localized(), argument) as String
    }
    
    /**
     Get localized and pluralized version of `self` with arguments.
     
     - parameter argx: Arguments to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(arg1: CVarArgType, _ arg2: CVarArgType) -> String {
        return NSString.localizedStringWithFormat(localized(), arg1, arg2) as String
    }
    
    /**
     Get localized and pluralized version of `self` with arguments.
     
     - parameter argx: Arguments to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(arg1: CVarArgType, _ arg2: CVarArgType, _ arg3: CVarArgType) -> String {
        return NSString.localizedStringWithFormat(localized(), arg1, arg2, arg3) as String
    }
    
    /**
     Get localized and pluralized version of `self` with arguments.
     
     - parameter argx: Arguments to determine pluralisation.
     
     - returns: Pluralized localized string.
     */
    func localizedPlural(arg1: CVarArgType, _ arg2: CVarArgType, _ arg3: CVarArgType, _ arg4: CVarArgType) -> String {
        return NSString.localizedStringWithFormat(localized(), arg1, arg2, arg3, arg4) as String
    }
}