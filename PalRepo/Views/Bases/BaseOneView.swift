/*:
    BaseOneView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI
import SwiftData
import Firebase

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct BaseOneView: View {
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @Environment(\.modelContext) private var context
    
    @Query var allPals: [PalCharacter]
    
    @ObservedObject var baseData: BaseData

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var selectedLabel = "Tag"
    @State private var showAddPalsSheet = false
    
    @Binding var base: Base
    @Binding var selectedPals: [PalCharacter]

    /*------------------------------------------------------------------------------------------------------*/
    /*  U I   H A N D L I N G                                                                               */
    /*------------------------------------------------------------------------------------------------------*/
    var body: some View {
        VStack {
            VStack {
                Text("\(base.name)")
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                Text(selectedLabel)
                    .font(.title3)
                    .padding(.bottom, 20)
                
                if isEditing {
                    VStack {
                        TextField("Enter a new name", text: $editedName)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                        
                        Picker(selection: $selectedLabel, label: Text("")) {
                            Text("Main").tag("Main")
                            Text("Farming").tag("Farming")
                            Text("Mining").tag("Mining")
                            Text("Breeding").tag("Breeding")
                            Text("PVP").tag("PVP")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                }
                
                Button(action: {
                    showAddPalsSheet.toggle()
                }) {
                    Text("Add Pals")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                .sheet(isPresented: $showAddPalsSheet) {
                    SelectPalsView(selectedPals: $selectedPals, allPals: allPals)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing.toggle()
                        if !isEditing {
                            /* Save the edited values to the base */
                            base.name = editedName
                            base.label = selectedLabel
                        }
                    }) {
                        Text(isEditing ? "Save" : "Edit")
                    }
                }
            }
            
            VStack {
                Text("Pals at this base")
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                        ForEach(selectedPals, id: \.id) { pal in
                            PalCharacterCard(pal: pal)
                                .contextMenu {
                                    Button("Remove") {
                                        if let index = selectedPals.firstIndex(of: pal) {
                                            selectedPals.remove(at: index)
                                        }
                                    }
                                }
                                .onTapGesture(count: 2) {
                                    
                                }
                                .gesture(LongPressGesture().onEnded { _ in
                                    if let index = selectedPals.firstIndex(of: pal) {
                                        selectedPals.remove(at: index)
                                    }
                                })
                        }
                    }
                }
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .onAppear {
            /* Print the initial state of base1Pals */
            print("Initial base1Pals:", baseData.base1Pals)
            
            /* Convert fetched pal IDs to PalCharacter objects */
            let fetchedPalIds = baseData.base1Pals.map { $0.palID }
            print("Fetched Pal IDs:", fetchedPalIds)
            
            selectedPals = allPals.filter { pal in
                fetchedPalIds.contains(pal.palID)
            }
            print("Filtered Pals:", selectedPals)
        }
        .onDisappear {
            if let userId = Auth.auth().currentUser?.uid {
                let selectedPalIds = selectedPals.map { $0.palID }
                FirestoreManager.shared.storeBaseData(base: base,
                                                      selectedPals: selectedPalIds,
                                                      baseNumber: 1,
                                                      userId: userId)
            }
        }

    }
}
