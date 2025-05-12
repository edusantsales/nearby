import Foundation

class PlaceDetailViewModel {
    private let baseURL = "http://127.0.0.1:3333"
    
    var categories: [Category] = []
    
    func getCategories(completion: @escaping ([Category]) -> Void) {
        guard let url = URL(string: "\(baseURL)/categories") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Deu erro")
                return
            }

            guard let data = data else {
                completion([])
                return
            }

            do {
                let categories = try JSONDecoder().decode(
                    [Category].self, from: data)
                DispatchQueue.main.async {
                    completion(categories)
                }
            } catch {
                print("Deu erro ao pegar categorias de data")
                completion([])
            }
        }.resume()
    }
}
