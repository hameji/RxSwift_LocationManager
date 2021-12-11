//
//  TopRouter.swift
//  RxSwift+CLLocationManager
//
//  Created by Hajime Taniguchi on 2021/12/10.
//

import UIKit

protocol TopWireframe: AnyObject {
    
}

final class TopRouter {
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // DependencyInjection
    static func assembleModules() -> UIViewController {
        let topStoryboard = UIStoryboard(name: "TopView", bundle: nil)
        guard let view = topStoryboard.instantiateInitialViewController() as? TopViewController else {
            return UIViewController()
        }
        let router = TopRouter(viewController: view)
        let locationManagerInteractor = LocationManagerInteractor()
        let presenter = TopPresenter(view: view,
                                     router: router,
                                     locationManagerInteractor: locationManagerInteractor)
        view.presenter = presenter
        return view
    }
}

extension TopRouter: TopWireframe {
    
}
