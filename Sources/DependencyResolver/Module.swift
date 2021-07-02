//
//  Module.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 14/08/2021.
//

import Foundation

internal struct Module {
    let name: String
    let scope: DependencyInjectionScope
    let resolveClosure: () -> Any?

    init<Service>(client: Service.Type, name: String? = nil, scope: DependencyInjectionScope = .transient, resolveClosure: @escaping () -> Service?) {
        self.name = name ?? String(describing: client)
        self.scope = scope
        self.resolveClosure = resolveClosure
    }
}
