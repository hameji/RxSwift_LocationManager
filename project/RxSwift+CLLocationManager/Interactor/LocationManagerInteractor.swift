//
//  LocationManagerUserCase.swift
//  RxSwift+CLLocationManager
//
//  Created by Hajime Taniguchi on 2021/12/10.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationManagerUsecase: AnyObject {
    func getCoordinate() -> Observable<CLLocation>
}

final class LocationManagerInteractor {
    private let locationManager = CLLocationManager()
}

extension LocationManagerInteractor: LocationManagerUsecase {
    func getCoordinate() -> Observable<CLLocation> {
        return self.locationManager.rx.getCurrentLocation()
    }
}
