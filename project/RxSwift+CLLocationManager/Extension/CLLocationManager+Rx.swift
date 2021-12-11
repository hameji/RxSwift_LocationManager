//
//  CLLocationManager+Rx.swift
//  RxSwift+CLLocationManager
//
//  Created by Hajime Taniguchi on 2021/12/10.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

extension CLLocationManager: HasDelegate {
    
}

class RxCLLocationManagerDelegateProxy:
    DelegateProxy<CLLocationManager, CLLocationManagerDelegate>,
    DelegateProxyType, CLLocationManagerDelegate {
    weak public private(set) var locationManager: CLLocationManager?
    
    public init(locationManager: ParentObject) {
        self.locationManager = locationManager
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        register { RxCLLocationManagerDelegateProxy(locationManager:  $0) }
    }
}

extension Reactive where Base: CLLocationManager {
    var didUpdateLocations: Observable<[CLLocation]> {
        delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map { param in
                param[1] as! [CLLocation]
            }
    }
    
    var authorizationStatus: Observable<CLAuthorizationStatus> {
        delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:)))
            .map { parameters in
                CLAuthorizationStatus(rawValue: parameters[1] as! Int32)!
            }
            .startWith(CLLocationManager.authorizationStatus())
    }
    
    func getCurrentLocation() -> Observable<CLLocation> {
        let location = authorizationStatus.filter {
            $0 == .authorizedAlways || $0 == .authorizedWhenInUse }
            .flatMap { _ in
                self.didUpdateLocations.compactMap(\.first)
            }
            .take(1)
            .do(onDispose: { [weak base] in
                base?.stopUpdatingLocation()
            })
        
        base.requestWhenInUseAuthorization()
        base.startUpdatingLocation()
        return location
    }
    
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
}
