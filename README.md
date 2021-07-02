# DependencyResolver

Basic implementation of a dependency resolver letting users to have dependency injection in their projects.

## Usage

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependencies = DependencyResolver()
            .register(SomeProtocol.self, resolveClosure: SomeImplementation.init)
        dependencies.build()

        return true
    }
}

class SomeClass {
    @Inject var someProtocol: SomeProtocol?
}
```