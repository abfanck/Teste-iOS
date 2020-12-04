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
    
    
    // MARK: - Init
    
    init(coordinates: PublishSubject<(latitude: Float, longitude: Float)>) {
        coordinates
            .subscribe(
                onNext: { (coordinates) in
                    self.formatLocation(from: coordinates)
                })
            .disposed(by: bag)
    }
    
    
    // MARK: - Formating Function(s)
    
    private func formatLocation(from coordinates: (latitude: Float, longitude: Float)) {
        self.findLocation(with: coordinates)
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
    
    private func findLocation(with coordinates: (latitude: Float, longitude: Float)) -> Observable<CLPlacemark> {
        return Observable<CLPlacemark>.create { (observer) in
            if let latitude = CLLocationDegrees(exactly: coordinates.latitude),
               let longitude = CLLocationDegrees(exactly: coordinates.longitude) {
                
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
