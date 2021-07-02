import XCTest
@testable import DependencyResolver

final class DependencyResolverTests: XCTestCase {

    override class func setUp() {
        let dependencies = DependencyResolver()
            .register(Animal.self, name: "Cat") {
                Cat(name: "Perle")
            }.register(Animal.self, name: "Dog") {
                Dog(name: "Peps")
            }.register(CarBrand.self) {
                Renault()
            }.register(CarBrand.self, name: "Citroen", scope: .singleton, resolveClosure: {
                Citroen()
            })
        dependencies.build()
    }

    override func setUp() {
        super.setUp()
        container = Container()
    }

    private var container: Container!

    func testDependencyResolving() {
        XCTAssertTrue(container.cat is Cat)
        XCTAssertEqual(container.cat?.name, "Perle")
        container.cat?.name = "Fred"
        XCTAssertEqual(container.cat?.name, "Fred")
        
        XCTAssertTrue(container.dog is Dog)
        XCTAssertEqual(container.dog?.name, "Peps")

        XCTAssertNil(container.peugeot)
        XCTAssertNotNil(container.renault)
    }

    func testSingleton() {
        let citroen1: Citroen? = DependencyResolver.root.resolve(name: "Citroen")
        citroen1?.birthYear = 2021
        let citroen2: Citroen? = DependencyResolver.root.resolve(name: "Citroen")
        XCTAssertEqual(citroen2?.birthYear, 2021)
    }
}

fileprivate struct Container {
    @Inject("Cat") fileprivate var cat: Animal?
    @Inject("Cat") fileprivate var cat2: Animal?
    @Inject("Dog") fileprivate var dog: Animal?

    @Inject("Peugeot") fileprivate var peugeot: CarBrand?
    @Inject fileprivate var renault: CarBrand?
    @Inject("WrongService") fileprivate var wrongService: CarBrand?
}

fileprivate protocol Animal {
    var name: String { get set }
}

fileprivate struct Dog: Animal {
    var name: String
}

fileprivate struct Cat: Animal {
    var name: String
}

fileprivate protocol CarBrand {
    var birthYear: UInt { get set }
}

fileprivate struct Renault: CarBrand {
    var birthYear: UInt = 1898
}

fileprivate class Citroen: CarBrand {
    var birthYear: UInt = 1919
}
