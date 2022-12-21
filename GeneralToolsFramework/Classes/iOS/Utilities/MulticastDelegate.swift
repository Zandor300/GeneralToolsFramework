//
//  MulticastDelegate.swift
//  GeneralToolsFramework-iOS
//
//  Created by Zandor Smith on 21/12/2022.
//

import Foundation

// https://www.vadimbulavin.com/multicast-delegate

public class MulticastDelegate<T> {

    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    public func add(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }

    public func remove(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() where delegate === delegateToRemove as AnyObject {
            delegates.remove(delegate)
        }
    }

    public func invoke(_ invocation: (T) -> Void) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T) // swiftlint:disable:this force_cast
        }
    }

}
