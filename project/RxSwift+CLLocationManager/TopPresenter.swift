//
//  TopPresenter.swift
//  RxSwift+CLLocationManager
//
//  Created by Hajime Taniguchi on 2021/12/10.
//

import Foundation

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
extension TopPresenter: TopPresentation {
    
}
