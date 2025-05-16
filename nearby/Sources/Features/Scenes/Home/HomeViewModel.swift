import CoreLocation
import Foundation

class HomeViewModel {
    private let networkService = NetworkService()

    var userLatitude = -23.561187293883442
    var userLongitude = -46.656451388116494
    var categories: [Category] = []
    var places: [Place] = []
    var filteredPlaces: [Place] = []

    var didUpdateCategories: (() -> Void)?
    var didUpdatePlaces: (() -> Void)?

    func getInitialData(completion: @escaping ([Category]) -> Void) {
        getCategories { categories in
            completion(categories)
            if let foodCategory = categories.first(where: {
                $0.name == "Alimentação"
            }) {
                self.getPlaces(
                    for: foodCategory.id,
                    userLocation: CLLocationCoordinate2D(
                        latitude: self.userLatitude,
                        longitude: self.userLongitude
                    )
                )
            }
        }
    }

    func getCategories(completion: @escaping ([Category]) -> Void) {
        networkService.getData(
            from: networkService.getCategoriesApi(),
            decodeTo: [Category].self
        ) { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                DispatchQueue.main.async {
                    completion(categories)
                }
            case .failure(let error):
                print(
                    "❌ Erro ao buscar categorias: \(error.localizedDescription)"
                )
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }

    func getPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D)
    {
        networkService.getData(
            from: networkService.getPlacesApi(categoryID: categoryID),
            decodeTo: [Place].self
        ) { result in
            switch result {
            case .success(let places):
                self.places = places
                DispatchQueue.main.async {
                    self.didUpdatePlaces?()
                }
            case .failure(let error):
                print("❌ Erro ao buscar lugares: \(error.localizedDescription)")
            }
        }
    }

}
