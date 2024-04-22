/*:
    Base.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData
import Combine

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
class Base: ObservableObject {
    var id: Int
    @Published var name: String
    @Published var label: String
    
    init(id: Int, name: String, label: String) {
        self.id = id
        self.name = name
        self.label = label
    }
}


