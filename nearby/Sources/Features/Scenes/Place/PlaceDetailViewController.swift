import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {
    private let placeDetailView = PlaceDetailView()
    
    private var viewModel = PlaceDetailViewModel()
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = placeDetailView
        getDetails()
        placeDetailView.goBackToHome = { [weak self] in self?.goBackToHome() }
    }
    
    private func getDetails() {
        guard let place = place else { return }
        
        viewModel.getCategories { [weak self] categories in
            guard let self = self else { return }
            guard let category = categories.first(where: { $0.id == place.categoryId }) else { return }
            self.placeDetailView.createPlaceContentView(place: place, category: category)
        }
        
        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.placeDetailView.placeImageView.coverImageView.image = image
                    }
                }
            }.resume()
        }
    }
    
    private func goBackToHome() {
        self.navigationController?.popViewController(animated: true)
    }
}
