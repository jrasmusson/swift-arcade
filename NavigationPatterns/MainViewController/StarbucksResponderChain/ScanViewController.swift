//
//  ScanViewController.swift
//  StarbucksResponderChain
//
//  Created by jrasmusson on 2020-12-12.
//

import Foundation
import UIKit

class ScanViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        title = "Scan"
        view.backgroundColor = .systemIndigo
        setTabBarImage(imageName: "qrcode", title: "Scan")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

