/*:
 BaseFireStoreData.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData
import Firebase


/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
class BaseData: ObservableObject {
    @Published var base1: Base
    @Published var base2: Base
    @Published var base3: Base
    @Published var base1Pals: [PalCharacter]
    @Published var base2Pals: [PalCharacter]
    @Published var base3Pals: [PalCharacter]
    
    init() {
        self.base1 = Base(id: 1, name: "Initial Name", label: "Initial Label")
        self.base2 = Base(id: 2, name: "Initial Name", label: "Initial Label")
        self.base3 = Base(id: 3, name: "Initial Name", label: "Initial Label")
        self.base1Pals = []
        self.base2Pals = []
        self.base3Pals = []
    }
}
