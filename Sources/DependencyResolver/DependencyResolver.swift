//
//  DependencyResolver.swift
//
//
//  Created by Arnaud LE BOURBLANC on 14/08/2021.
//

/// A basic collection of dependencies to be registered and resolved
final public class DependencyResolver {

    /// Returns the shared container.
    public static var root = DependencyResolver()

    private var dependencies = [String: Module]()
    private var instances = [String: Any]()

    /// Assigns the current container to the shared `root`.
    public func build() {
        Self.root = self
    }
}

extension DependencyResolver {
    /// Register a new module into the container.
    /// - Parameters:
    ///   - client: Abstract type of the client used at the injection
    ///   - name: Name of the module to register, if nil `Service` description would be used instead
    ///   - scope: Scope of the injection, `transient` by default
    ///   - resolveClosure: Closure called to create the dependency at the resolution step
    /// - Returns: Itself in order to easily chain registration
    @discardableResult
    public func register<Service>(_ client: Service.Type, name: String? = nil, scope: DependencyInjectionScope = .transient, resolveClosure: @escaping () -> Service?) -> Self {
        let dependency = Module(client: client, name: name, scope: scope, resolveClosure: resolveClosure)

        if scope == .singleton {
            instances[dependency.name] = resolveClosure()
        }
        dependencies[dependency.name] = dependency
        return self
    }

    /// Inject a dependency module using its instance or its resolve closure
    /// - Parameter name: Name of the module, if nil `Service` description would be used instead
    /// - Returns: The result of the resolve closure of the module or the shared instance associated. Returns `nil` if the resolution failed.
    public func resolve<Service>(name: String?) -> Service? {
        let name = name ?? String(describing: Service.self)

        guard let dependency = dependencies[name] else {
            return nil
        }

        switch dependency.scope {
        case .transient:
            return dependency.resolveClosure() as? Service
        case .singleton:
            return instances[dependency.name] as? Service
        }
    }
}
