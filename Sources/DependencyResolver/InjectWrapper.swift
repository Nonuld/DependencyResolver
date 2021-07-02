//
//  InjectWrapper.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 14/08/2021.
//

import Foundation

/// Property wrapper to easily inject a dependency into a property from the root container
@propertyWrapper
public struct Inject<Service> {
    private var value: Service?

    public var wrappedValue: Service? {
        get { return value }
        mutating set { value = newValue }
    }

    /// Create a new wrapper and instantly resolve the dependency using its name and the `root` container.
    /// - Parameters:
    ///     - name: Name of the module to be instantiated
    public init(_ name: String) {
        self.value = DependencyResolver.root.resolve(name: name)
    }

    /// Create a new wrapper and instantly resolve the dependency using its type as a name.
    /// - Parameter dependencyResolver: DependencyResolver instance used to resolve, if not passed the `root` will be used.
    public init(_ dependencyResolver: DependencyResolver = .root) {
        self.value = dependencyResolver.resolve(name: nil)
    }

    /// Create a new wrapper and instantly resolve the dependency using its name.
    /// - Parameters:
    ///     - dependencyResolver: DependencyResolver instance used to resolve.
    ///     - name: Name of the module to be instantiated
    public init(_ name: String, dependencyResolver: DependencyResolver) {
        self.value = dependencyResolver.resolve(name: name)
    }
}
