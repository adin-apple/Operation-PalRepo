/*:
    SortFilterPalDeck.swift
 */

import Foundation
import SwiftUI
import SwiftData

struct SortFilterPalDeck: View {
    @Environment(\.modelContext) private var context
    @Query var pals: [PalCharacter]
    let sortSelection: sortOptions
    let typeSelection: typeOptions
    
    init(sortSelection: sortOptions, typeSelection: typeOptions) {
        
        self.sortSelection = sortSelection
        self.typeSelection = typeSelection
        
        let sortDescriptors: [SortDescriptor<PalCharacter>] = switch sortSelection {
        case .nameASC:
            [SortDescriptor(\PalCharacter.palName)]
        case .keyASC:
            [SortDescriptor(\PalCharacter.palKey)]
        case .palHealthASC:
            [SortDescriptor(\PalCharacter.palStats.statHP)]
        case .palMeleeAttASC:
            [SortDescriptor(\PalCharacter.palStats.statAttack.melee)]
        case .palRangeAttASC:
            [SortDescriptor(\PalCharacter.palStats.statAttack.ranged)]
        case .palDefenseASC:
            [SortDescriptor(\PalCharacter.palStats.statDefense)]
        case .palStaminaASC:
            [SortDescriptor(\PalCharacter.palStats.statStamina)]
        case .palSupportASC:
            [SortDescriptor(\PalCharacter.palStats.statSupport)]
        case .palWalkSpdASC:
            [SortDescriptor(\PalCharacter.palStats.statSpeed.walk)]
        case .palRunSpdASC:
            [SortDescriptor(\PalCharacter.palStats.statSpeed.run)]
        case .palRideSpdASC:
            [SortDescriptor(\PalCharacter.palStats.statSpeed.ride)]
        case .palFoodUsageASC:
            [SortDescriptor(\PalCharacter.palStats.statFood)]
        case .nameDSC:
            [SortDescriptor(\PalCharacter.palName, order: .reverse)]
        case .keyDSC:
            [SortDescriptor(\PalCharacter.palKey, order: .reverse)]
        case .palHealthDSC:
            [SortDescriptor(\PalCharacter.palStats.statHP, order: .reverse)]
        case .palMeleeAttDSC:
            [SortDescriptor(\PalCharacter.palStats.statAttack.melee, order: .reverse)]
        case .palRangeAttDSC:
            [SortDescriptor(\PalCharacter.palStats.statAttack.ranged, order: .reverse)]
        case .palDefenseDSC:
            [SortDescriptor(\PalCharacter.palStats.statDefense, order: .reverse)]
        case .palStaminaDSC:
            [SortDescriptor(\PalCharacter.palStats.statStamina, order: .reverse)]
        case .palSupportDSC:
            [SortDescriptor(\PalCharacter.palStats.statSupport, order: .reverse)]
        case .palWalkSpdDSC:
            [SortDescriptor(\PalCharacter.palStats.statSpeed.walk, order: .reverse)]
        case .palRunSpdDSC:
            [SortDescriptor(\PalCharacter.palStats.statSpeed.run, order: .reverse)]
        case .palRideSpdDSC:
            [SortDescriptor(\PalCharacter.palStats.statSpeed.ride, order: .reverse)]
        case .palFoodUsageDSC:
            [SortDescriptor(\PalCharacter.palStats.statFood, order: .reverse)]
        }
        





        
        _pals = Query(sort: sortDescriptors)
    }


    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                ForEach(pals, id: \.id) { pal in
                    PalCharacterCard(pal: pal)
                }
            }
        }
        .padding(.top, 10)
    }
}
