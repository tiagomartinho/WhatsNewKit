//
//  WhatsNewView.swift
//  WhatsNewKit-iOS
//
//  Created by Sven Tiigi on 30.06.20.
//  Copyright © 2020 WhatsNewKit. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI
#if !WhatsNewKitCocoaPods
import WhatsNewKit
#endif

/// The WhatsNew SwiftUI View
@available(iOS 13.0, *)
public struct WhatsNewView: UIViewControllerRepresentable {
    
    // MARK: Typealias
    
    /// The Configuration typealias
    public typealias Configuration = WhatsNewViewController.Configuration
    
    /// The Theme typealias
    public typealias Theme = WhatsNewViewController.Theme
    
    // MARK: Properties
    
    /// The WhatsNew object
    public let whatsNew: WhatsNew
    
    /// The Configuration
    private let configuration: Configuration
    
    /// The optional WhatsNewVersionStore
    private let versionStore: WhatsNewVersionStore?
    
    // MARK: Initializer
    
    /// Designated Initializer with WhatsNew and Configuration
    /// - Parameters:
    ///   - whatsNew: The WhatsNew
    ///   - configuration: The Configuration. Default value `.init()`
    public init(
        whatsNew: WhatsNew,
        configuration: Configuration = .init()
    ) {
        self.whatsNew = whatsNew
        self.configuration = configuration
        self.versionStore = nil
    }
    
    /// Convenience Initializer with WhatsNew and a Theme
    /// - Parameters:
    ///   - whatsNew: The WhatsNew
    ///   - theme: The Theme
    public init(
        whatsNew: WhatsNew,
        theme: Theme
    ) {
        self.init(
            whatsNew: whatsNew,
            configuration: .init(theme)
        )
    }
    
    /// Convenience optional initializer with WhatsNewVersionStore.
    /// Initializer checks via WhatsNewVersionStore if Version has already been presented.
    /// If a Version has been found the initializer will return nil.
    /// - Parameters:
    ///   - whatsNew: The WhatsNew
    ///   - configuration: The Configuration
    ///   - versionStore: The WhatsNewVersionStore
    public init?(
        whatsNew: WhatsNew,
        configuration: Configuration = .init(),
        versionStore: WhatsNewVersionStore
    ) {
        // Verify VersionStore has not stored the WhatsNew Version
        guard !versionStore.has(version: whatsNew.version) else {
            // Return nil as Version has already been presented
            return nil
        }
        self.whatsNew = whatsNew
        self.configuration = configuration
        self.versionStore = versionStore
    }
    
    /// Convenience Initializer with WhatsNew, Theme and WhatsNewVersionStore
    /// Initializer checks via WhatsNewVersionStore if Version has already been presented.
    /// If a Version has been found the initializer will return nil.
    /// - Parameters:
    ///   - whatsNew: The WhatsNew
    ///   - theme: The Theme
    public init?(
        whatsNew: WhatsNew,
        theme: Theme,
        versionStore: WhatsNewVersionStore
    ) {
        self.init(
            whatsNew: whatsNew,
            configuration: .init(theme),
            versionStore: versionStore
        )
    }
    
    // MARK: UIViewControllerRepresentable
    
    /// Creates a `UIViewController` instance to be presented.
    /// - Parameter context: The Context
    public func makeUIViewController(
        context: Context
    ) -> UIViewController {
        // Check if a VersionStore is available
        if let versionStore = self.versionStore {
            // Check if WhatsNewViewController can be initialized with VersionStore
            // This check should never evlaute to `nil` as the VersionStore will
            // already been checked in the initializer of `WhatsNewView`
            if let whatsNewViewController = WhatsNewViewController(
                whatsNew: self.whatsNew,
                configuration: self.configuration,
                versionStore: versionStore
            ) {
                // Return WhatsNewViewController with VersionStore
                return whatsNewViewController
            } else {
                // Fallback: Return empty ViewController
                return .init()
            }
        } else {
            // Otherwise initialize WhatsNewViewController without VersionStore
            return WhatsNewViewController(
                whatsNew: self.whatsNew,
                configuration: self.configuration
            )
        }
    }
    
    /// Updates the presented `UIViewController` (and coordinator) to the latest configuration.
    /// - Parameters:
    ///   - uiViewController: The UIViewController
    ///   - context: The Context
    public func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}
    
}

#endif
