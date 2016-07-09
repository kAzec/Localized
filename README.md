# Localized

![Platforms](https://img.shields.io/badge/platforms-ios%20%7C%20osx%20%7C%20watchos%20%7C%20tvos-lightgrey.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](#carthage)
![Swift version](https://img.shields.io/badge/swift-2.2-orange.svg)

Localized is a simple framework that improves i18n and localization in Swift iOS apps - providing cleaner syntax and in-app language switching. This framework is modified from [marmelroy](https://github.com/marmelroy)'s [Localize-Swift](https://github.com/marmelroy/Localize-Swift).

## Features

- Keep the Localizable.strings file your app already uses.
- Allow your users to change the app's language without changing their device language.
- Use `.localized()` instead of `NSLocalizedString(key, comment)` - a more Swifty syntax.
- Generate your strings with a new genstrings swift script that recognises `.localized()`, `.localizedFormat(_:)` and so on.

## Usage

Import Localized at the top of each Swift file that will contain localized text.

Add .localized() following any String object you want translated:

```swift
textLabel.text = "Hello World".localized()
```

To get an array of available localizations:

```swift
Localization.availableLanguages()
```

To change the current language:

```swift
Localization.setCurrentLanguage("fr")
```

To update the UI in the viewcontroller where a language change can take place, observe LCLLanguageChangeNotification :

```swift
NSNotificationCenter.defaultCenter().addObserver(self, selector: "setText", name: LCLLanguageDidChangeNotification, object: nil)
```

To reset back to the default app language:

```swift
Localization.resetCurrentLanguageToDefault()
```

### genstrings

To support this new i18n syntax, Localized includes custom genstrings swift scripts.

Copy the genstrings.swift file into your project's root folder and run with

```
./genstrings.swift
```

This will print the collected strings in the terminal. Select and copy to your default Localizable.strings.

The swift genstrings includes the ability to specify excluded directories and files (by editing the script).

## Installation
### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Log into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "kAzec/Localized"
```

## License

Copyright (c) 2015 Roy Marmelstein (http://roysapps.com/) and kAzec

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


