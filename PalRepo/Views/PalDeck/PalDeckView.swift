/*:
    PalDeckView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalDeckView: View {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @State private var sortedSelection: sortOptions = .keyASC
    @State private var typePrimarySelection: typeOptions = .allTypes
    @State private var typeSecondarySelection: typeOptions = .allTypes
    @State private var workTypeSelection: workOptions = .allWork
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  I N I T                                                                                             */
    /*------------------------------------------------------------------------------------------------------*/
    var body: some View {
        VStack {
            
            /* Filter and Sort UI */
            VStack {
                
                HStack{
                    /* Sorting UI */
                    VStack {
                        
                        /* Sorting Header */
                        Text("Sorting")
                            .font(.title2)
                            .bold()
                            .padding()
                        
                        
                        /* Sorting List */
                        Picker("", selection: $sortedSelection) {
                            ForEach(sortOptions.allCases, id: \.self) {
                                sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    /* Work Options Filter UI */
                    VStack {
                        
                        /* Work Options Header */
                        
                        Text("Work Types")
                            .font(.title2)
                            .bold()
                            .padding()
                        
                        
                        /* Work Options List */
                        Picker("", selection: $workTypeSelection) {
                            ForEach(workOptions.allCases, id: \.self) {
                                workOption in
                                Text(workOption.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                HStack {
                    /* Pal Type Filter UI */
                    VStack {
                        
                        /* Pal Type Header */
                            Text("Type One")
                                .font(.title2)
                                .bold()
                                .padding()
                        
                        /* Pal Type List */
                        Picker("", selection: $typePrimarySelection) {
                            ForEach(typeOptions.allCases, id: \.self) {
                                typeSelection in
                                Text(typeSelection.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        
                    }
                    
                    /* Pal Type Filter UI */
                    VStack {
                        
                        /* Pal Type Header */
                            Text("Type Two")
                                .font(.title2)
                                .bold()
                                .padding()

                        /* Pal Type List */
                        Picker("", selection: $typeSecondarySelection) {
                            ForEach(typeOptions.allCases, id: \.self) {
                                typeSelection in
                                Text(typeSelection.rawValue)
                            }
                        }
                        .pickerStyle(.menu) 
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            /* Pal Cards Scroll UI */
            SortFilterPalDeck(sortSelection: sortedSelection, typeSelection: typePrimarySelection)
        }
        .background(Color.white)
    }
}

/*----------------------------------------------------------------------------------------------------------*/
/*  E N U M S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
/* Options for Pal Deck Sorting */
enum sortOptions: String, CaseIterable {
    case nameASC = "A-Z"
    case keyASC = "123"
    case palHealthASC = "HP : Low -> High"
    case palMeleeAttASC = "MAT : Low -> High"
    case palRangeAttASC = "RAT : Low -> High"
    case palDefenseASC = "DEF : Low -> High"
    case palStaminaASC = "STA : Low -> High"
    case palSupportASC = "SUP : Low -> High"
    case palWalkSpdASC = "WALK : Low -> High"
    case palRunSpdASC = "RUN : Low -> High"
    case palRideSpdASC = "RIDE : Low -> High"
    case palFoodUsageASC = "FOOD : Low -> High"
    
    case nameDSC = "Z-A"
    case keyDSC = "321"
    case palHealthDSC = "HP : High -> Low"
    case palMeleeAttDSC = "MAT : High -> Low"
    case palRangeAttDSC = "RAT : High -> Low"
    case palDefenseDSC = "DEF : High -> Low"
    case palStaminaDSC = "STA : High -> Low"
    case palSupportDSC = "SUP : High -> Low"
    case palWalkSpdDSC = "WALK : High -> Low"
    case palRunSpdDSC = "RUN : High -> Low"
    case palRideSpdDSC = "RIDE : High -> Low"
    case palFoodUsageDSC = "FOOD : High -> Low"
}

/* Options to Filter PalDeck by PalType*/
enum typeOptions: String, CaseIterable {
    case allTypes
    case dark
    case dragon
    case electric
    case fire
    case grass
    case ground
    case ice
    case neutral
    case water
}

/* Options to Filter PalDeck by Work Suitability */
enum workOptions: String, CaseIterable {
    case allWork
    case cooling
    case farming
    case gathering
    case generatingElectricity
    case handiwork
    case kindling
    case lumbering
    case medicineProduction
    case mining
    case planting
    case transporting
    case watering
}
