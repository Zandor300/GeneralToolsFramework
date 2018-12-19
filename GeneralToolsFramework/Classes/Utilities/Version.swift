//
//  Version.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import Foundation

public class Version {
    
    public static func getCurrentVersion() -> Version {
        let version = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)! + "-" + (Bundle.main.infoDictionary!["CFBundleVersion"] as? String)!
        return Version(version: version)
    }
    
    var major: Int = 0
    var minor: Int = 0
    var patch: Int = 0
    var buildNumber: Int = 0
    
    public init(version: String) {
        let split1 = version.split(separator: "-")
        buildNumber = Int(split1[1])!
        
        let split2 = split1[0].split(separator: ".")
        major = Int(split2[0])!
        minor = Int(split2[1])!
        if split2.count == 3 {
            patch = Int(split2[2])!
        }
    }
    
    public func compare(otherVersion: Version) -> VersionComparison {
        print("Comparing " + toString() + " with " + otherVersion.toString() + "...")
        if otherVersion.major > major {
            return VersionComparison.HIGHER
        }
        if otherVersion.minor > minor && otherVersion.major == major {
            return VersionComparison.HIGHER
        }
        if otherVersion.patch > patch && otherVersion.minor == minor && otherVersion.major == major {
            return VersionComparison.HIGHER
        }
        if otherVersion.buildNumber > buildNumber && otherVersion.patch == patch && otherVersion.minor == minor && otherVersion.major == major {
            return VersionComparison.HIGHER
        }
        
        if otherVersion.major == major && otherVersion.minor == minor && otherVersion.patch == patch && otherVersion.buildNumber == buildNumber {
            return VersionComparison.EQUAL
        }
        
        return VersionComparison.LOWER
    }
    
    public func toString() -> String {
        if patch != 0 {
            return String(major) + "." + String(minor) + "." + String(patch) + "-" + String(buildNumber)
        }
        return String(major) + "." + String(minor) + "-" + String(buildNumber)
    }
    
    public func toNiceStringWithBuild() -> String {
        if patch != 0 {
            return String(major) + "." + String(minor) + "." + String(patch) + " (" + String(buildNumber) + ")"
        }
        return String(major) + "." + String(minor) + " (" + String(buildNumber) + ")"
    }
    
    public func toNiceString() -> String {
        if patch != 0 {
            return String(major) + "." + String(minor) + "." + String(patch)
        }
        return String(major) + "." + String(minor)
    }
    
}

public enum VersionComparison {
    case HIGHER
    case LOWER
    case EQUAL
}

