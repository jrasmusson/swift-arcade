//
//  ViewController.swift
//  BellAnimation1
//
//  Created by Rasmusson, Jonathan on 2021-05-25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bellView: NotificationBadgeView!
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var offsetSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func durationChanged(_ sender: UISlider) {
        bellView.duration = Double(sender.value)*2
    }

    @IBAction func angleChanged(_ sender: UISlider) {
        let normalized = CGFloat(sender.value) * .pi/2
        bellView.angle = normalized
    }

    @IBAction func offsetChanged(_ sender: UISlider) {
        bellView.yOffset = CGFloat(sender.value)
    }

    @IBAction func reset(_ sender: UIButton) {
        durationSlider.value = 0.5
        angleSlider.value = 0.5
        offsetSlider.value = 0.5

        bellView.duration = Double(1)
        bellView.angle = .pi/8
        bellView.yOffset = 0.5
    }
}
