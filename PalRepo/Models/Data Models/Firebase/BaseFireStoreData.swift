/*:
    BaseFireStoreData.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
class BaseData: ObservableObject {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @Published var base1: Base
    @Published var base2: Base
    @Published var base3: Base
    @Published var base1Pals: [PalCharacter]
    @Published var base2Pals: [PalCharacter]
    @Published var base3Pals: [PalCharacter]
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  I N I T                                                                                             */
    /*------------------------------------------------------------------------------------------------------*/
    init() {
        self.base1 = Base(id: 1, name: "Initial Name", label: "Initial Label")
        self.base2 = Base(id: 2, name: "Initial Name", label: "Initial Label")
        self.base3 = Base(id: 3, name: "Initial Name", label: "Initial Label")
        self.base1Pals = []
        self.base2Pals = []
        self.base3Pals = []
    }
}
