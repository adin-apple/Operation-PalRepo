# PalRepo, The PalWorld Companion App

Welcome to the PalWorld companion app! This app serves as a companion to the PalWorld game, providing 
additional features and functionality to enhance your gaming experience. The app is built around SwiftUI and SwiftData.

## Features

- PalDeck: View the PalDeck database with options for filtering and sorting.
- Bases: Access information about your bases, Pals stationed there, and more.
- Settings: Customize your app settings, including account login, cloud saves, and more.

## Installation

- Clone the repository: git clone https://github.com/adin-apple/Operation-PalRepo
- Navigate to the project directory: cd PalRepo
- Install dependencies: pod install (if using CocoaPods)
- Open the project: open PalRepo.xcworkspace


## Requirements
- iOS 17.4+
- Xcode 12.0+
- Swift 5.3+

## Usage

- Launch the app on your iOS device or simulator.
- Use the buttons on the main screen to navigate to different features of the app.

## Contributing

- Fork the repository.
- Create a new branch (git checkout -b feature/my-feature).
- Make your changes.
- Commit your changes (git commit -am 'Add new feature').
- Push to the branch (git push origin feature/my-feature).
- Create a new Pull Request.

## Credits

Developer: Adin Donlagic
Email: adinapple@icloud.com
Website: N/A


# PalRepo App Code Overview

## Project Structure

The project is structured into several key components:

1. Views: SwiftUI views for different screens of the app, including the main menu, pal deck, bases view, settings view, and individual base views.
2. Models: Data models representing the various entities in the app, such as PalCharacter, Base, PalSkill, PalMap, PalBreeding, PalAura, etc.
3. Managers: Classes to manage Firebase authentication and Firestore database interactions, such as AuthManager and FirestoreManager.
4. Data: Classes to manage the app's data, such as BaseData to store base information and FirestoreData to manage Firestore-related data.
5.  Utilities: Utility functions and extensions used throughout the app.

## The App Itself

The PalRepo is built on a public API that the community put together that holds all the information the game has to offer. Here we see the structure of the main app file.

### An Introduction to SwiftData

In the app file, we see the main premise of SwiftData's structure. First we create our Schema which is defined by the main model of the app, `PalCharacter`. Then we creaate our container. The container is like our long term storage where all of our data will persist. THen below that we tag our `.modelContainer` to the main view. Each time we want to pull the data from the container, we are going to reference our model. Think of the model as the working memory. This is the data that we will pull out of the container, manipulate, and put back in.

```swift
@main
struct PalRepoApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    
    let palContainer: ModelContainer = {
        let schema = Schema([PalCharacter.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: PalCharacter.self) { result in
            do {
                let container = try result.get()

                // Check we haven't already added our users.
                let descriptor = FetchDescriptor<PalCharacter>()
                let existingUsers = try container.mainContext.fetchCount(descriptor)
                guard existingUsers == 0 else { return }

                // Load and decode the JSON.
                guard let url = Bundle.main.url(forResource: "pals", withExtension: "json") else {
                    fatalError("Failed to find users.json")
                }

                let data = try Data(contentsOf: url)
                let pals = try JSONDecoder().decode([PalCharacter].self, from: data)
                
                // Add all our data to the context.
                for pal in pals {
                    container.mainContext.insert(pal)
                }
            } catch {
                print("Failed to pre-seed database with error: \(error)")
            }
        }
    }
    
}
```

## Authentication and Firestore Integration

The app integrates Firebase for authentication and Firestore for data storage. Here's a brief overview of how it works:

1. Authentication: The AuthManager class handles user authentication. It checks if a user is logged in when the app starts and provides a method to sign out.
```swift
class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            print("User signed out successfully")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
```

   
2. Firestore Integration: The FirestoreManager class manages interactions with Firestore. It includes methods to store and fetch base data for each user. When a user logs in, their bases and pals are fetched from Firestore and displayed in the app.
```swift
class FirestoreManager {

    var palDictionary: [Int: PalCharacter] = [:]
    
    static let shared = FirestoreManager()

    let db: Firestore
    let usersCollection: CollectionReference

    private init() {
        db = Firestore.firestore()
        usersCollection = db.collection("users")
    }
    
    func setupPalDictionary(allPals: [PalCharacter]) {
        palDictionary = allPals.reduce(into: [:]) { dict, pal in
            dict[pal.palID] = pal
        }
    }

    func storeBaseData(base: Base, selectedPals: [Int], baseNumber: Int, userId: String) {
        let baseData: [String: Any] = [
            "name": base.name,
            "label": base.label,
            "pals": selectedPals
        ]

        usersCollection.document(userId).collection("bases").document("base\(baseNumber)").setData(baseData) { error in
            if let error = error {
                print("Error storing base data: \(error.localizedDescription)")
            } else {
                print("Base data stored successfully")
            }
        }
    }
    
    func getBaseData(userId: String, baseData: BaseData, completion: @escaping (Error?) -> Void) {

        usersCollection.document(userId).collection("bases").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching base data: \(error.localizedDescription)")
                completion(error)
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(nil)
                return
            }

            print("Fetched \(documents.count) documents")

            for document in documents {
                
                if let baseNumberString = document.documentID.components(separatedBy: "base").last,
                   let baseNumber = Int(baseNumberString),
                   let baseName = document["name"] as? String,
                   let baseLabel = document["label"] as? String,
                   let palIDs = document["pals"] as? [Int] {

                    var selectedPals: [PalCharacter] = []
                    for palID in palIDs {
                        if let pal = self.palDictionary[palID] {
                            selectedPals.append(pal)
                        } else {
                            print("No pal found for palID: \(palID)")
                        }
                    }

                    switch baseNumber {
                    case 1:
                        baseData.base1 = Base(id: baseNumber, name: baseName, label: baseLabel)
                        baseData.base1Pals = selectedPals
                    case 2:
                        baseData.base2 = Base(id: baseNumber, name: baseName, label: baseLabel)
                        baseData.base2Pals = selectedPals
                    case 3:
                        baseData.base3 = Base(id: baseNumber, name: baseName, label: baseLabel)
                        baseData.base3Pals = selectedPals
                    default:
                        break
                    }
                }
            }
            
            completion(nil)
        }
    }
}
```


## Main Menu: 
The entry point of the app, displaying options to navigate to the PalDeck, Bases, and Settings views.

<img width="376" alt="Screenshot 2024-04-22 at 8 16 56 AM" src="https://github.com/adin-apple/Operation-PalRepo/assets/157755690/54e3b2de-9e2c-40d6-8acf-90cb2b08e5d1">

### PalDeck View
Displays the user's collection of pals, allowing them to view details and manage their pals.

<img width="378" alt="Screenshot 2024-04-22 at 8 14 14 AM" src="https://github.com/adin-apple/Operation-PalRepo/assets/157755690/a98e8957-48a6-421e-aefa-9e443b7fcd0c">

**State Variables** are used when you want to persist data through views. You reference them in code by using a `$`.

```swift
struct PalDeckView: View {
    @State private var sortedSelection: sortOptions = .keyASC
    @State private var typePrimarySelection: typeOptions = .allTypes
    @State private var typeSecondarySelection: typeOptions = .allTypes
    @State private var workTypeSelection: workOptions = .allWork
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
```
#### SortFilterPalDeck
This view handles the grid that is displayed in PalDeckView. It handles sorting and filtering using SortDescriptors and Predicates to combine into a query for SwiftData to utilize. It takes in the values of the sorting and filters pickers and enacts a switch-case statement for each option.

```swift
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
```



### Bases View**:
Displays a list of bases, each leading to a separate view (BaseOneView, BaseTwoView, BaseThrView) for managing the pals in that base.

I create custom buttons that act as the base identifiers. These bases append a deeper navigation path to the navigation stack to allow the user to enter multiple levels of interfaces. Depending on which button was pressed, the data for the base gets passed through to the base views.

<img width="375" alt="Screenshot 2024-04-22 at 8 16 36 AM" src="https://github.com/adin-apple/Operation-PalRepo/assets/157755690/d394894f-b959-49c0-94b5-58f1fffde5b7">

<img width="370" alt="Screenshot 2024-04-22 at 8 16 01 AM" src="https://github.com/adin-apple/Operation-PalRepo/assets/157755690/ba71731f-c33a-4268-ac4c-de07307e10bf">

<img width="375" alt="Screenshot 2024-04-22 at 8 16 19 AM" src="https://github.com/adin-apple/Operation-PalRepo/assets/157755690/3dc6092f-dfe6-4fd9-8fdf-c9923ef0aa9e">

```swift
struct BasesView: View {
    @ObservedObject var baseData: BaseData
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Spacer()

            Text("Select A Base!")
                .bold()
                .font(.title)

            Spacer()

            HStack {
                Spacer()
                VStack {
                    myCircleButton(number: 1) {
                        path.append(1)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()

                VStack {
                    myCircleButton(number: 2) {
                        path.append(2)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()

                VStack {
                    myCircleButton(number: 3) {
                        path.append(3)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()
            }
            .navigationDestination(for: Int.self) { view in
                switch view {
                case 1:
                    BaseOneView(baseData: baseData, base: $baseData.base1, selectedPals: $baseData.base1Pals)

                case 2:
                    BaseTwoView(baseData: baseData, base: $baseData.base2, selectedPals: $baseData.base2Pals)

                case 3:
                    BaseThrView(baseData: baseData, base: $baseData.base3, selectedPals: $baseData.base3Pals)

                default:
                    MainView()
                }
            }
            Spacer()
            Spacer()
        }
    }
}
```

#### Base Number View

Base One, Two, and Three all have the same code.

We use `ObservedObject` to pase the `baseData` through the views. `@Environment` and `@Query` are SwiftData features; we are setting our model context from the app file as our environment and we are querying the data in that environment and pulling our pal information.

From there we handle UI feature such as an edit button to save a text field and another picker value.

We then utilize the same grid from `SortAndFilterPalDeck` but modifiy it to only have the Pals a user defines to be apart of that base. Clicking and holding a `PalCharacterCard` on the grid will mark it to be removed.

When this view appears, we fetch our data from the Firestore Database, always ensuring that we are at the most current information.

```swift
struct BaseOneView: View {
    @ObservedObject var baseData: BaseData
    @Environment(\.modelContext) private var context
    @Query var allPals: [PalCharacter]

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var selectedLabel = "Tag"

    @Binding var base: Base
    @Binding var selectedPals: [PalCharacter]

    @State private var showAddPalsSheet = false

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
                    SelectPalsView(allPals: allPals, selectedPals: $selectedPals)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing.toggle()
                        if !isEditing {
                            // Save the edited values to the base
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
                                    // Double tap action
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
            // Print the initial state of base1Pals
            print("Initial base1Pals:", baseData.base1Pals)
            
            // Convert fetched pal IDs to PalCharacter objects
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
                FirestoreManager.shared.storeBaseData(base: base, selectedPals: selectedPalIds, baseNumber: 1, userId: userId)
            }
        }

    }
}
```

### Settings View
Allows the user to sign in/out, view account information, and manage app settings.
  
<img width="379" alt="Screenshot 2024-04-22 at 8 17 19 AM" src="https://github.com/adin-apple/Operation-PalRepo/assets/157755690/9994f371-9ce1-49fc-bf39-c34f70a34929">

```swift
struct SettingsView: View {
    @ObservedObject var baseData: BaseData
    @Environment(\.modelContext) private var context
    @State private var email = ""
    @State private var password = ""
    @StateObject var authManager = AuthManager()
    @State private var showLogoutAlert = false
    @State private var showAnotherUserAlert = false

    var body: some View {
        VStack {
            Text(authManager.isLoggedIn ? "Currently logged in!" : "Create an Account!")
                .padding()

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .padding(.horizontal)

            Button("Sign Up") {
                if authManager.isLoggedIn {
                    showAnotherUserAlert = true
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("Error signing up: \(error.localizedDescription)")
                        } else {
                            print("User signed up successfully")
                            email = ""
                            password = ""
                            authManager.isLoggedIn = true
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")

                            // Fetch base data after signing up
                            if let userId = Auth.auth().currentUser?.uid {
                                FirestoreManager.shared.getBaseData(userId: userId, baseData: baseData) { error in
                                    if let error = error {
                                        print("Error fetching base data: \(error.localizedDescription)")
                                    } else {
                                        print("Base data fetched successfully")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()

            Button("Sign In") {
                if authManager.isLoggedIn {
                    showAnotherUserAlert = true
                } else {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("Error signing in: \(error.localizedDescription)")
                        } else {
                            print("User signed in successfully")
                            email = Auth.auth().currentUser?.email ?? ""
                            password = ""
                            authManager.isLoggedIn = true
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")

                            // Fetch base data after signing in
                            if let userId = Auth.auth().currentUser?.uid {
                                FirestoreManager.shared.getBaseData(userId: userId, baseData: baseData) { error in
                                    if let error = error {
                                        print("Error fetching base data: \(error.localizedDescription)")
                                    } else {
                                        print("Base data fetched successfully")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()

            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    print("User signed out successfully")
                    authManager.isLoggedIn = false
                    showLogoutAlert = true
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }
            .padding()
            .alert(isPresented: $showLogoutAlert) {
                Alert(title: Text("Logged Out"), message: Text("You have been logged out."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showAnotherUserAlert) {
                Alert(title: Text("Another User Logged In"), message: Text("Another user is currently logged in. Please sign out first."), dismissButton: .default(Text("OK")))
            }
        }
    }
}
```


## Data Management and Persistence

The app uses various techniques to manage and persist data: 
1. Data Models: Models like Base, PalCharacter, and others represent the app's data structure.
2. Observable Objects: BaseData and other observable objects are used to manage and update data across views.
3. Firestore Database: Firestore is used to store and fetch user-specific data, such as bases and pals, ensuring data persistence across app launches.

### PalCharacter

It might look like a lot, but don't worry, it won't bite.

PalCharacter is the heart of the application where we take in all our information from the API and store it into our defined model.

For nested JSON files we have to adhere our variables a little different. Each value that had a nested attribute/object in the JSON required that we make a custom struct for it.

The structs all had to adhere to `Codable` protocol.

After matching the structs with the JSON using enum CodingKeys, we then need to tell the app to decode the information.

We go back to our SwiftData containers and create custom containers for each of the custom structs we defined.

After decoding, we then need to encode our data. Similarly, we need to make custom encoding containers for our data to be properly validated.

```swift
@Model
class PalCharacter: Codable {
    var palID: Int
    var palKey: String
    var palName: String
    var palImage: String
    var palTyping: [PalTyping]
    var palWiki: URL
    var palImageWiki: URL
    var palWork: [PalWork]
    var palDrops: [String]
    var palAura: PalAura?
    var palDetails: String
    var palSkills: [PalSkill]
    var palStats: PalStats
    var palAsset: String
    var palGenus: String
    var palRarity: Int
    var palPrice: Int
    var palSize: String
    var palMaps: PalMap
    var palBreeding: PalBreeding
    
    enum CodingKeys: String, CodingKey {
        case palID = "id"
        case palKey = "key"
        case palName = "name"
        case palImage = "image"
        case palTyping = "types"
        case palWiki = "wiki"
        case palImageWiki = "imageWiki"
        case palWork = "suitability"
        case palDrops = "drops"
        case palAura = "aura"
        case palDetails = "details"
        case palSkills = "skills"
        case palStats = "stats"
        case palAsset = "asset"
        case palGenus = "genus"
        case palRarity = "rarity"
        case palPrice = "price"
        case palSize = "size"
        case palMaps = "maps"
        case palBreeding = "breeding"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.palID = try container.decode(Int.self, forKey: .palID)
        self.palKey = try container.decode(String.self, forKey: .palKey)
        self.palName = try container.decode(String.self, forKey: .palName)
        self.palImage = try container.decode(String.self, forKey: .palImage)
        self.palDrops = try container.decode([String].self, forKey: .palDrops)
        
        if let auraContainer = try? container.nestedContainer(keyedBy: AuraCodingKeys.self, forKey: .palAura) {
            let name = try auraContainer.decode(String.self, forKey: .auraName)
            let details = try auraContainer.decode(String.self, forKey: .auraDetails)
            let tech = try auraContainer.decodeIfPresent(String.self, forKey: .auraTech)
            self.palAura = PalAura(auraName: name, auraDetails: details, auraTech: tech)
        } else {
            self.palAura = nil
        }
        
        self.palDetails = try container.decode(String.self, forKey: .palDetails)
        
        let statsContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .palStats)
        let statHP = try statsContainer.decode(Int.self, forKey: .statHP)
        let statATT = try statsContainer.decode(Attack.self, forKey: .statAttack)
        let statDEF = try statsContainer.decode(Int.self, forKey: .statDefense)
        let statSTA = try statsContainer.decode(Int.self, forKey: .statStamina)
        let statSUP = try statsContainer.decode(Int.self, forKey: .statSupport)
        let statSPD = try statsContainer.decode(Speed.self, forKey: .statSpeed)
        let statFOD = try statsContainer.decode(Int.self, forKey: .statFood)
        self.palStats = PalStats(statHP: statHP,
                                 statAttack: statATT,
                                 statDefense: statDEF,
                                 statSpeed: statSPD,
                                 statStamina: statSTA,
                                 statSupport: statSUP,
                                 statFood: statFOD)
        
        self.palAsset = try container.decode(String.self, forKey: .palAsset)
        self.palGenus = try container.decode(String.self, forKey: .palGenus)
        self.palRarity = try container.decode(Int.self, forKey: .palRarity)
        self.palPrice = try container.decode(Int.self, forKey: .palPrice)
        self.palSize = try container.decode(String.self, forKey: .palSize)
        
        let mapContainer = try? container.nestedContainer(keyedBy: MapsCodingKeys.self, forKey: .palMaps)
        let day = try? mapContainer?.decode(String.self, forKey: .spawnDay)
        let night = try? mapContainer?.decode(String.self, forKey: .spawnNit)
        self.palMaps = PalMap(spawnDay: day ?? "", spawnNit: night ?? "")

        let breedingContainer = try container.nestedContainer(keyedBy: BreedingCodingKeys.self,
                                                              forKey: .palBreeding)
        let breedRank = try breedingContainer.decode(Int.self, forKey: .breedRank)
        let breedOrder = try breedingContainer.decode(Int.self, forKey: .breedOrder)
        let childEligble = try breedingContainer.decode(Bool.self, forKey: .childEligble)
        let maleProbability = try breedingContainer.decode(Double.self, forKey: .maleProbability)
        self.palBreeding = PalBreeding(breedRank: breedRank, breedOrder: breedOrder,
                                       childEligble: childEligble, maleProbability: maleProbability)
        
        palWiki = try container.decode(URL.self, forKey: .palWiki)
        palImageWiki = try container.decode(URL.self, forKey: .palImageWiki)
        
        var typingContainer = try container.nestedUnkeyedContainer(forKey: .palTyping)
        var typingArray: [PalTyping] = []
        
        while !typingContainer.isAtEnd {
            let typeContainer = try typingContainer.nestedContainer(keyedBy: TypingCodingKeys.self)
            let name = try typeContainer.decode(String.self, forKey: .typeName)
            let image = try typeContainer.decode(String.self, forKey: .typeImage)
            
            let typing = PalTyping(typeName: name, typeImage: image)
            typingArray.append(typing)
        }
        self.palTyping = typingArray
        
        
        var workingContainer = try container.nestedUnkeyedContainer(forKey: .palWork)
        var workArray: [PalWork] = []
        
        while !workingContainer.isAtEnd {
            let workContainer = try workingContainer.nestedContainer(keyedBy: WorkCodingKeys.self)
            let workType    = try workContainer.decode(String.self, forKey: .workType)
            let workImage   = try workContainer.decode(String.self, forKey: .workImage)
            let workLevel   = try workContainer.decode(Int.self, forKey: .workLevel)
            
            let working = PalWork(workType: workType, workImage: workImage, workLevel: workLevel)
            workArray.append(working)
        }
        self.palWork = workArray
        
        var skillingContainer = try container.nestedUnkeyedContainer(forKey: .palSkills)
        var skillArray: [PalSkill] = []
        
        while !skillingContainer.isAtEnd {
            let skillContainer  = try skillingContainer.nestedContainer(keyedBy: SkillCodingKeys.self)
            let skillLevel      = try skillContainer.decode(Int.self, forKey: .skillLevel)
            let skillName       = try skillContainer.decode(String.self, forKey: .skillName)
            let skillType       = try skillContainer.decode(String.self, forKey: .skillType)
            let skillCooldown   = try skillContainer.decode(Int.self, forKey: .skillCooldown)
            let skillPower      = try skillContainer.decode(Int.self, forKey: .skillPower)
            let skillDetails    = try skillContainer.decode(String.self, forKey: .skillDetails)
            
            let skilling = PalSkill(skillLevel: skillLevel, skillName: skillName, skillType: skillType,
                                    skillCooldown: skillCooldown, skillPower: skillPower,
                                    skillDetails: skillDetails)
            skillArray.append(skilling)
        }
        self.palSkills = skillArray
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(palID, forKey: .palID)
        try container.encode(palKey, forKey: .palKey)
        try container.encode(palName, forKey: .palName)
        try container.encode(palImage, forKey: .palImage)
        try container.encode(palWiki, forKey: .palWiki)
        try container.encode(palImageWiki, forKey: .palImageWiki)
        try container.encode(palWork, forKey: .palWork)
        try container.encode(palDrops, forKey: .palDrops)
        
        if let palAura = palAura {
            var auraContainer = container.nestedContainer(keyedBy: AuraCodingKeys.self, forKey: .palAura)
            try auraContainer.encode(palAura.auraName, forKey: .auraName)
            try auraContainer.encode(palAura.auraDetails, forKey: .auraDetails)
            try auraContainer.encode(palAura.auraTech, forKey: .auraTech)
        }
        
        try container.encode(palDetails, forKey: .palDetails)
        try container.encode(palSkills, forKey: .palSkills)
        try container.encode(palAsset, forKey: .palAsset)
        try container.encode(palGenus, forKey: .palGenus)
        try container.encode(palRarity, forKey: .palRarity)
        try container.encode(palPrice, forKey: .palPrice)
        try container.encode(palSize, forKey: .palSize)
        try container.encode(palMaps, forKey: .palMaps)
        
        var mapContainer = container.nestedContainer(keyedBy: MapsCodingKeys.self, forKey: .palMaps)
        try mapContainer.encode(palMaps.spawnDay, forKey: .spawnDay)
        try mapContainer.encode(palMaps.spawnNit, forKey: .spawnNit)
        
        
        try container.encode(palBreeding, forKey: .palBreeding)
        var breedingContainer = container.nestedContainer(keyedBy: BreedingCodingKeys.self, forKey: .palBreeding)
        try breedingContainer.encode(palBreeding.breedRank, forKey: .breedRank)
        try breedingContainer.encode(palBreeding.breedOrder, forKey: .breedOrder)
        try breedingContainer.encode(palBreeding.childEligble, forKey: .childEligble)
        try breedingContainer.encode(palBreeding.maleProbability, forKey: .maleProbability)
        
        var typingContainer = container.nestedUnkeyedContainer(forKey: .palTyping)
        for type in palTyping {
            var typeContainer = typingContainer.nestedContainer(keyedBy: TypingCodingKeys.self)
            try typeContainer.encode(type.typeName, forKey: .typeName)
            try typeContainer.encode(type.typeImage, forKey: .typeImage)
        }
        
        var workingContainer = container.nestedUnkeyedContainer(forKey: .palTyping)
        for work in palWork {
            var workContainer = workingContainer.nestedContainer(keyedBy: WorkCodingKeys.self)
            try workContainer.encode(work.workType, forKey: .workType)
            try workContainer.encode(work.workImage, forKey: .workImage)
            try workContainer.encode(work.workLevel, forKey: .workType)
        }
        
        var skillingContainer = container.nestedUnkeyedContainer(forKey: .palSkills)
        for skill in palSkills {
            var skillContainer = skillingContainer.nestedContainer(keyedBy: SkillCodingKeys.self)
            try skillContainer.encode(skill.skillLevel, forKey: .skillLevel)
            try skillContainer.encode(skill.skillName, forKey: .skillName)
            try skillContainer.encode(skill.skillType, forKey: .skillType)
            try skillContainer.encode(skill.skillCooldown, forKey: .skillCooldown)
            try skillContainer.encode(skill.skillPower, forKey: .skillPower)
            try skillContainer.encode(skill.skillDetails, forKey: .skillDetails)
        }
        
        var statContainer = container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .palStats)
        try statContainer.encode(palStats.statHP, forKey: .statHP)
        try statContainer.encode(palStats.statAttack, forKey: .statAttack)
        try statContainer.encode(palStats.statDefense, forKey: .statDefense)
        try statContainer.encode(palStats.statStamina, forKey: .statStamina)
        try statContainer.encode(palStats.statSupport, forKey: .statSupport)
        try statContainer.encode(palStats.statSpeed, forKey: .statSpeed)
        try statContainer.encode(palStats.statFood, forKey: .statFood)
        
    }
}

```

#### PalDetailView
This is used inside of `PalDeckView`. This defines the individual data of all the Pals in the app. It calls to all different types of cards which mostly handle the UI design behind the view.

I also made some custom string function to format the data that came from the JSON to be a little nicer on the eyes here.

```swift
struct PalDetailView: View {
    @Environment(\.modelContext) private var context
    
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        ScrollView {
            VStack {
                PalGeneralInfo(pal: pal)
                
                PalDetailCard(pal: pal)
                
                PalStatsCard(pal: pal)
                
                PalMiscInfoCard(pal: pal)
                
                PalDropCard(pal: pal)
                
                PalAuraCard(pal: pal)

                PalWorkCard(pal: pal)
                
                PalSkillCard(pal: pal)
                
                PalBreedingCard(pal: pal)
                
                PalMapCard(pal: pal)
            }
        }
        .padding()
    }
}

func imageName(from imagePath: String) -> String {
    return URL(fileURLWithPath: imagePath)
        .deletingPathExtension()
        .lastPathComponent
}

extension String {
    func insertSpacesBeforeCapitals() -> String {
        var result = ""
        var isFirstChar = true
        for char in self {
            if char.isUppercase {
                if !isFirstChar {
                    result.append(" ")
                }
                isFirstChar = false
            }
            result.append(char)
        }
        return result
    }
}

extension String {
    func formatCapitalAndUnderscore() -> String {
        let words = self.components(separatedBy: "_")
        let capitalizedWords = words.map { $0.capitalized }
        return capitalizedWords.joined(separator: " ")
    }
}

```

We can preview one of the cards to get an idea of what's going on, this is `PalSkillCard`


Most of the code here is UI based, with the funnest part being the custom background colors for the pal move element type.

```swift
struct PalSkillCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Pal Skills")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            ForEach(pal.palSkills, id: \.self) { skill in
                VStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Spacer()
                            
                            HStack {
                                Text(skill.skillName.formatCapitalAndUnderscore())
                                    .font(.headline)
                                    .bold()
                                Spacer()
                                Text("LvL: \(skill.skillLevel)")
                                    .bold()
                                Spacer()
                                Image(imageName(from: skill.skillType))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .background(backgroundColor(for: imageName(from: skill.skillType)))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            
                            Spacer()
                        }
                        .padding(.top)

                        HStack {
                            Spacer()
                            
                            VStack{
                                Text("Power")
                                    .bold()
                                Text("\(skill.skillPower)")
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                            VStack{
                                Text("Cooldown")
                                    .bold()
                                Text("\(skill.skillCooldown)")
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            
                            Spacer()
                        }
                        
                        Text(skill.skillDetails)
                            .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

func backgroundColor(for skillType: String) -> Color {
    switch skillType {
    case "fire":
        return Color.red
    case "water":
        return Color.blue.opacity(0.8)
    case "grass":
        return Color.green
    case "electric":
        return Color.yellow
    case "ground":
        return Color.brown
    case "ice":
        return Color.cyan
    case "dragon":
        return Color.purple
    case "dark":
        return Color.gray
    case "neutral":
        return Color.white
    default:
        return Color.black
    }
}
```
