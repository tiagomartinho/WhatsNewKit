//
//  InMemoryWhatsNewVersionStore.swift
//  WhatsNewKit-iOS
//
//  Created by Sven Tiigi on 24.05.18.
//  Copyright © 2018 WhatsNewKit. All rights reserved.
//

import Foundation

// MARK: - InMemoryWhatsNewVersionStore

/// The InMemoryWhatsNewVersionStore
public final class InMemoryWhatsNewVersionStore {
    
    // MARK: Static-Properties
    
    /// The shared (Singleton) `InMemoryWhatsNewVersionStore` instance
    public static let shared = InMemoryWhatsNewVersionStore()
    
    // MARK: Properties
    
    /// The Versions
    public var versions: [WhatsNew.Version]
    
    // MARK: Initializer
    
    /// Default initializer
    public init() {
        // Initialize Version Array
        self.versions = .init()
    }
    
}

// MARK: - Clear Versions

public extension InMemoryWhatsNewVersionStore {
    
    /// Clear all stored Versions
    func clearVersions() {
        self.versions.removeAll()
    }
    
}

// MARK: - WriteableWhatsNewVersionStore

extension InMemoryWhatsNewVersionStore: WriteableWhatsNewVersionStore {
    
    /// Set Version
    ///
    /// - Parameter version: The Version
    public func set(version: WhatsNew.Version) {
        // Append Version
        self.versions.append(version)
    }
    
}

// MARK: - ReadableWhatsNewVersionStore

extension InMemoryWhatsNewVersionStore: ReadableWhatsNewVersionStore {
    
    /// Has Version
    ///
    /// - Parameter version: The Version
    /// - Returns: Bool if Version has been presented
    public func has(version: WhatsNew.Version) -> Bool {
        // Return if versions is contained in versions
        self.versions.contains(version)
    }
    
}
