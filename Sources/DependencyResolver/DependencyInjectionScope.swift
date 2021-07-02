//
//  DependencyInjectionScope.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 14/08/2021.
//

import Foundation

/// The scope associated to a dependency
public enum DependencyInjectionScope {
    /// A dependency with an instance created once and kept in memory for reuse
    case singleton
    /// A dependency with an instance created each time it is resolved and thus temporary in time
    case transient
}
