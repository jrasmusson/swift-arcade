//
//  StarbucksResponder.swift
//  StarbucksResponderChain
//
//  Created by jrasmusson on 2020-12-12.
//

import Foundation
import UIKit

/*
 This is where we can capture all the responder chain events for our app.
 */

@objc protocol StarBucksResponder {
    @objc optional func didTapScan(sender: UIButton?)
}
