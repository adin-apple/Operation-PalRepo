#  Understanding SwiftData

## Purpose
Tto introduce and understand how SwiftData works. Understanding SwiftData is the core of this project.

## Context
Given a JSON file, decode and transfer the information into SwiftData framework.

## References
- SwiftData Basics in 15 mintes
    CodeWithChris
    https://www.youtube.com/watch?v=krRkm8w22A8
- Intro to SwiftData - Model, Container, Fetch, Create, Update, & Delete
    Sean Allen
    https://www.youtube.com/watch?v=mvXFGikltPc

# Key Notes
- SwiftData is only available in iOS 17.0+


# SwiftData in 5 Steps

## Create the Data Model
```swift
/* Step 1 - Creating the Data Model */
/* Create a new file for the @Model class */

@Model
class DataItem: Identifiable{
    
    var id: String
    var name: String
    
    init(name: String) {
        
        self.id = UUID().uuidString
        self.name = name
        
    }
}

```

## Create the Model Container
```swift
/* Step 2 - Creating the Model Container */
/* Go to the App.swift to place the modelContainer*/

@main
struct SwiftDataDemoApp: App {

    /* This would be used when using containers across different ViewModels */
    let container: ModelContainer = {
        let schema = Schema([DataItem.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
        //.modelContainer(for: DataItem.self)
    }
}
```

## Get a Reference to the Context
```swift
/* Step 3 - Environment Object for the Context */
/* Go to the MainView */

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    
    var body: some View {
        VStack {
            Image(Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, World")
        }.padding()
    }
}

#Preview {
    ContentView()
}
```

## Add Data to the Persistent Store and Retrieve the Data
```swift
/* Step 4 - Add Objects and Query to Get the Data */

struct ContentView: View {
    @Environment(\.modelContext) private var context

    @Query private var items: [DataItem]
    
    var body: some View {
        VStack {
            Text("Add item below ")
            Button("Add an item") {
                
            }
            
            List {
                ForEach (items) { item in
                    Text(item.name)
                }
            }
            
        }.padding()
    }
    
    func addItem() {
        // Create the item
        let item = DataItem(name: "Test Item")
        
        // Add the item to the data context
        context.insert(item)
    }
}
```

## Update and Delete the Data
```swift
/* Step 5 - Update/Remove Objects from or save the context */

struct ContentView: View {
    @Environment(\.modelContext) private var context

    @Query private var items: [DataItem]
    
    var body: some View {
        VStack {
            Text("Add item below ")
            Button("Add an item") {
                
            }
            
            List {
                ForEach (items) { item in
                    HStack{
                        Text(item.name)
                        Spacer()
                        Button {
                            updateItem(item)
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                        
                    }
                }
            }
            .onDelete { indexes in
                for index in index {
                    deleteItem(items[index])
                }
            }
            
        }.padding()
    }
    
    func addItem() {
        // Create the item
        let item = DataItem(name: "Test Item")
        
        // Add the item to the data context
        context.insert(item)
    }
    
    func deleteItem(_ item: DataItem) {
        context.delete(item)
    }
    
    func updateItem(_ item: DataItem) {
        // Edit the item data
        item.name = "Updated Test Item"
        
        // save the context
        try? context.save()
        
    }
}

```
