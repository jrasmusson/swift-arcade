//
//  HeaderView.swift
//  HeaderView
//
//  Created by jrasmusson on 2021-08-23.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let bundle = Bundle.init(for: HeaderView.self)
        bundle.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
    }
}
