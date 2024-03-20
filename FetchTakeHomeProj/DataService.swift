import Foundation

class DataService: ObservableObject {
    @Published var items: [Int: [Item]] = [:] // Grouped by listId

    func fetchData() {
        guard let url = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                var fetchedItems = try JSONDecoder().decode([Item].self, from: data)
                    .filter { $0.name?.isEmpty == false } // Filter out items without a name
                    .sorted() // Sort by listId and name
                
                // Group by listId
                DispatchQueue.main.async {
                    self.items = Dictionary(grouping: fetchedItems, by: { $0.listId })
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

