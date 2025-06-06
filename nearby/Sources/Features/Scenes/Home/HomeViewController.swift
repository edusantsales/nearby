import Foundation
import MapKit
import UIKit

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private var homeViewModel = HomeViewModel()
    private var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        homeView.mapView.delegate = self
        homeView.configureTableViewDelegate(self, dataSource: self)
        defineInitialLocation()
        
        homeViewModel.getInitialData { [weak self] categories in
            guard let self = self else { return }
            self.homeView.updateFilterButtons(with: categories) { selectedCategory in
                self.filterPlaces(by: selectedCategory)
            }
        }
        
        self.addAnnotationsToMap()
        homeViewModel.didUpdatePlaces = { [weak self] in
            DispatchQueue.main.async {
                self?.places = self?.homeViewModel.places ?? []
                self?.homeView.reloadTableViewData()
                self?.addAnnotationsToMap()
            }
        }
    }
    
    // Set initial location
    private func defineInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: -23.561187293883442, longitude: -46.656451388116494)
        homeView.mapView.setRegion(
            MKCoordinateRegion(center: initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)),
            animated: true
        )
    }
    
    // Add map pin on map
    private func addAnnotationsToMap() {
        homeView.mapView.removeAnnotations(homeView.mapView.annotations)
        let annotations = places.map { PlaceAnnotation(place: $0) }
        
        homeView.mapView.addAnnotations(annotations)
        if let firstAnnotation = annotations.first {
            homeView.mapView.setRegion(
                MKCoordinateRegion(center: firstAnnotation.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
                animated: true
            )
        }
    }
    
    // Filter places
    private func filterPlaces(by category: Category) {
        let currentCenter = homeView.mapView.region.center
        homeViewModel.getPlaces(for: category.id, userLocation: currentCenter)
    }
}

// Configure table view
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: places[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Navigate to Place Detail View
        let placeDetail = PlaceDetailViewController()
        placeDetail.place = places[indexPath.row]
        navigationController?.pushViewController(placeDetail, animated: true)
    }
}

// Customize map pin
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier
        )
        if annotationView == nil {
            annotationView = MKAnnotationView(
                annotation: annotation, reuseIdentifier: identifier
            )
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(
                type: .detailDisclosure
            )
            if let pinImage = UIImage(named: "locationPinIcon") {
                annotationView?.image = pinImage
                annotationView?.frame.size = CGSize(width: 32, height: 48)
            }

        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard view.annotation is PlaceAnnotation else { return }
    }
}
