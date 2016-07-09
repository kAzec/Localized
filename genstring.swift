#!/usr/bin/swift

import Foundation

class GenStrings {
    
    let fileManager = NSFileManager.defaultManager()
    let acceptedFileExtensions = ["swift"]
    let excludedFolderNames = ["Carthage"]
    let excludedFileNames = ["genstrings.swift"]
    var regularExpresions = [String:NSRegularExpression]()

    let localizedRegex = "(?<=\")([^\"]*)(?=\"\\.(?:localized|localizedFormat|localizedPlural))|(?<=NSLocalizedString\\(\")([^\"]*)(?=\")"

    enum GenstringsError:ErrorType {
        case Error
    }
    
    // Performs the genstrings functionality.
    func perform() throws {
        do {
            let rootPath = NSURL(fileURLWithPath: fileManager.currentDirectoryPath)
            let allFiles = try fetchFilesInFolder(rootPath)
            
            // We use a set to avoid duplicates
            var localizableStrings = Set<String>()
            for filePath in allFiles {
                let stringsInFile = try localizableStringsInFile(filePath)
                localizableStrings = localizableStrings.union(stringsInFile)
            }
            
            // Sort the strings
            let sortedStrings = localizableStrings.sort({ $0 < $1 })
            var processedStrings = String()
            for string in sortedStrings {
                processedStrings.appendContentsOf("\"\(string)\" = \"\(string)\"; \n")
            }
            
            if sortedStrings.isEmpty {
                print("No localizable strings found!")
            } else {
                print("------Localizable Strings------")
                print(processedStrings)
            }
        } catch {
            throw error
        }
    }
    
    // Applies regex to a file at filePath. 
    func localizableStringsInFile(filePath: NSURL) throws -> Set<String> {
        if let fileContentsData = NSData(contentsOfURL: filePath), let fileContentsString = NSString(data: fileContentsData, encoding: NSUTF8StringEncoding) {
            do {
                let localizedStringsArray = try regexMatches(localizedRegex, string: fileContentsString as String).map({fileContentsString.substringWithRange($0.range)})
                return Set(localizedStringsArray)
            } catch {
                throw error
            }
        }

        return Set<String>()
    }
    
    // Regex.
    func regexWithPattern(pattern: String) throws -> NSRegularExpression {
        var safeRegex = regularExpresions
        if let regex = safeRegex[pattern] {
            return regex
        } else {
            do {
                let currentPattern =  try NSRegularExpression(pattern: pattern, options:NSRegularExpressionOptions.CaseInsensitive)
                safeRegex.updateValue(currentPattern, forKey: pattern)
                self.regularExpresions = safeRegex
                
                return currentPattern
            } catch {
                throw error
            }
        }
    }
    
    func regexMatches(pattern: String, string: String) throws -> [NSTextCheckingResult] {
        do {
            let internalString = string
            let currentPattern =  try regexWithPattern(pattern)
            // NSRegularExpression accepts Swift strings but works with NSString under the hood. Safer to bridge to NSString for taking range.
            let nsString = internalString as NSString
            let stringRange = NSMakeRange(0, nsString.length)
            let matches = currentPattern.matchesInString(internalString, options: [], range: stringRange)
            
            return matches
        } catch {
            throw error
        }
    }
    
    // Fetch files recursively.
    func fetchFilesInFolder(rootPath: NSURL) throws -> [NSURL] {
        do {
            var files = [NSURL]()
            
            let directoryContents = try fileManager.contentsOfDirectoryAtURL(rootPath, includingPropertiesForKeys: [], options: .SkipsHiddenFiles)
            for urlPath in directoryContents {
                if let stringPath = urlPath.path, lastPathComponent = urlPath.lastPathComponent, pathExtension = urlPath.pathExtension {
                    var isDir: ObjCBool = false
                    if fileManager.fileExistsAtPath(stringPath, isDirectory:&isDir) {
                        if isDir && !excludedFolderNames.contains(lastPathComponent) {
                            let dirFiles = try fetchFilesInFolder(urlPath)
                            files.appendContentsOf(dirFiles)
                        } else if acceptedFileExtensions.contains(pathExtension) && !excludedFileNames.contains(lastPathComponent) {
                            files.append(urlPath)
                        }
                    }
                }
            }
            
            return files
        } catch {
            throw error
        }
    }
}

do {
    let genStrings = GenStrings()
    try genStrings.perform()
} catch {
    print("Cannot perform genstring due to error: \(error)")
}