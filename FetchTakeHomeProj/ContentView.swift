import SwiftUI

struct ContentView: View {
    @ObservedObject var dataService = DataService()

    var body: some View {
        NavigationView {
            List {
                ForEach(dataService.items.sorted(by: { $0.key < $1.key }), id: \.key) { listId, items in
                    Section(header: Text("List ID: \(listId)")) {
                        ForEach(items) { item in
                            Text("\(item.name ?? "No name")")
                        }
                    }
                }
            }
            .navigationTitle("Items")
            .onAppear {
                dataService.fetchData()
            }
        }
    }
}

