//
//  TopPresenter.swift
//  RxSwift+CLLocationManager
//
//  Created by Hajime Taniguchi on 2021/12/10.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

protocol TopPresentation: AnyObject {
    
}

class TopPresenter {
    private weak var view: TopViewController?
    private let router: TopWireframe
    private let locationManagerInteractor: LocationManagerUsecase
    
    init(view: TopViewController,
         router: TopWireframe,
         locationManagerInteractor: LocationManagerInteractor) {
        self.view = view
        self.router = router
        self.locationManagerInteractor = locationManagerInteractor
    }
}

extension TopPresenter: PresenterType {

    struct Input {
        let gpsTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let latitude: Observable<String>
        let longitude: Observable<String>
    }
    
    struct State {
    }
    
    func transform(input: TopPresenter.Input) -> TopPresenter.Output {
        let location = input.gpsTrigger.flatMapLatest { _ in
            self.locationManagerInteractor.getCoordinate()
        }
        let latitude = location.map { String($0.coordinate.latitude) }
        let longitude = location.map { String($0.coordinate.longitude) }
        return TopPresenter.Output(latitude: latitude, longitude: longitude)
    }
}

extension TopPresenter: TopPresentation {
    
}
