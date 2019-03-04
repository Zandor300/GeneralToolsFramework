//
//  Version.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import Foundation

public class Version {
    
    /**
     Will return a new `Version` instance of the current app version.
     - returns: New `Version` instance of the current app version.
     */
    public static func getCurrentVersion() -> Version {
        let version = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)! + "-" + (Bundle.main.infoDictionary!["CFBundleVersion"] as? String)!
        return Version(version)
    }
    
    var major: Int = 0
    var minor: Int = 0
    var patch: Int = 0
    var buildNumber: Int = 0
    
    /**
     Initiate a new `Version` instance of the provided version.
     
     Example usage:
     ```swift
     let version = Version("1.2.5-7")
     ```
     
     - parameters:
        - version: The version number. (Ex. "1.2-4" or "1.2.5-7" where the number behind the '-' is the build number.)
     */
    public init(_ version: String) {
        let split1 = version.split(separator: "-")
        buildNumber = Int(split1[1])!
        
        let split2 = split1[0].split(separator: ".")
        major = Int(split2[0])!
        minor = Int(split2[1])!
        if split2.count == 3 {
            patch = Int(split2[2])!
        }
    }
    
    /**
     Will compare the current version with the other version that is provided. If `otherVersion` is higher than the current version, `VersionComparison.HIGHER` is returned. If they are equal, `VersionComparison.EQUAL` is returned and if `otherVersion` is lower, `VersionComparison.LOWER` is returned.
     
     - parameters:
        - otherVersion: The version to compare the current one with.
     - returns: The comparison result.
     */
    public func compare(with otherVersion: Version) -> VersionComparison {
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
    
    /**
     Will return a `String` of the version number. (Ex. "1.2.5-7")
     
     - returns: Version number as a `String`.
     */
    public func toString() -> String {
        if patch != 0 {
            return String(major) + "." + String(minor) + "." + String(patch) + "-" + String(buildNumber)
        }
        return String(major) + "." + String(minor) + "-" + String(buildNumber)
    }
    
    /**
     Will return a 'nice' `String` of the version number. Could be used for TestFlight or Debug builds on the settings page. (Ex. "1.2.5 (7)")
     
     - returns: Version number as a `String`.
     */
    public func toNiceStringWithBuild() -> String {
        if patch != 0 {
            return String(major) + "." + String(minor) + "." + String(patch) + " (" + String(buildNumber) + ")"
        }
        return String(major) + "." + String(minor) + " (" + String(buildNumber) + ")"
    }
    
    /**
     Will return a 'nice' `String` of the version number. Could be used for App Store release builds on the settings page. (Ex. "1.2.5")
     
     - returns: Version number as a `String`.
     */
    public func toNiceString() -> String {
        if patch != 0 {
            return String(major) + "." + String(minor) + "." + String(patch)
        }
        return String(major) + "." + String(minor)
    }
    
    
    /**
     Will return a 'nice' `String` of the version number that is appropriate for the current Build Configuration. Could be used for displaying on the settings page. Will return a `String` in the following formats:
     App Store: "1.2.5"
     TestFlight or Debug: "1.2.5 (7)"
     
     - returns: Version number as a `String`.
     */
    public func toNiceStringForBuildConfig() -> String {
        if BuildConfig.appConfiguration == .TestFlight || BuildConfig.isDebug {
            return self.toNiceStringWithBuild()
        } else {
            return self.toNiceString()
        }
    }
    
}

public enum VersionComparison {
    case HIGHER
    case LOWER
    case EQUAL
}

