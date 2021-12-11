//
//  ViewController.swift
//  RxSwift+CLLocationManager
//
//  Created by Hajime Taniguchi on 2021/12/10.
//

import UIKit
import RxSwift
import RxCocoa

protocol TopView: AnyObject {
    func bindViewModel()
}

class TopViewController: UIViewController {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var startGPSButton: UIButton!
    
    var presenter: TopPresenter!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
}

extension TopViewController: TopView {
    func bindViewModel() {
        let input = TopPresenter.Input(gpsTrigger: startGPSButton.rx.tap)
        let output = presenter.transform(input: input)
        output.latitude.bind(to: latitudeLabel.rx.text).disposed(by: bag)
        output.longitude.bind(to: longitudeLabel.rx.text).disposed(by: bag)
    }
}
