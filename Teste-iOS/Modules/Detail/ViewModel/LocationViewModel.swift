//
//  LocationViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation
import RxSwift
import CoreLocation

class LocationViewModel {
    
    // MARK: - Public Variable(s)
    
    var locationFormatted = PublishSubject<String>()
    
    
    //MARK: - Private Variable(s)
    
    private let bag = DisposeBag()
    private var latitude: Float
    private var longitude: Float
    
    
    // MARK: - Init
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
        self.formatLocation()
    }
    
    
    // MARK: - Formating Function(s)
    
    private func formatLocation() {
        self.findLocationWithCoordinates()
            .subscribe(
                onNext: { placemark in
                    
                    let components = [placemark.thoroughfare, placemark.subThoroughfare,
                                      placemark.subLocality, placemark.postalCode, placemark.locality,
                                      placemark.country]
                    
                    let local = components.compactMap({ $0 }).joined(separator: ", ")
                    self.locationFormatted.onNext(local)
                    
                }).disposed(by: bag)
    }
    
    
    // MARK: - CoreLocation Function(s)
    
    private func findLocationWithCoordinates() -> Observable<CLPlacemark> {
        return Observable<CLPlacemark>.create { (observer) in
            if let latitude = CLLocationDegrees(exactly: self.latitude),
               let longitude = CLLocationDegrees(exactly: self.longitude) {
                
                let location = CLLocation(latitude: latitude, longitude: longitude)
                CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                    if let error = error {
                        observer.onError(error)
                    } else if let firstLocation = placemarks?[0] {
                        observer.onNext(firstLocation)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
}
