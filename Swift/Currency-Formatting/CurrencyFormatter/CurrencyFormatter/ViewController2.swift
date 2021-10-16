//
//  ViewController.swift
//  CurrencyFormatter
//
//  Created by jrasmusson on 2021-10-16.
//

import UIKit

class ViewController2: UIViewController {
    
    let amount: Decimal = 929466.01
    let label = UILabel()
    
    // 1
    var amountAttributed: NSAttributedString {
        let parts = formattedDollarsAndCents // tuple
        let dollarPart = parts.0
        let centPart = parts.1
        return makeFormattedBalance(dollars: dollarPart, cents: centPart)
    }
        
    // 2
    var formattedDollarsAndCents: (String, String) {
        let parts = modf(amount.doubleValue)
        
        let dollarsWithDecimal = dollarsFormatted(parts.0) // $100,000.01
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator!
        let dollarParts = dollarsWithDecimal.components(separatedBy: decimalSeparator)
        var dollars = dollarParts.first! // $100,000
        dollars.removeFirst() // 100,000
        
        var cents = String(format: "%.2f", parts.1) // .01
        cents.removeFirst() // 01
        
        return (dollars, cents)
    }
    
    // 3
    private func dollarsFormatted(_ dollars: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: dollars as NSNumber) {
            return result
        }
        
        return ""
    }

    // 4
    func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController2 {
    func style() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = amountAttributed
    }
    
    func layout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
