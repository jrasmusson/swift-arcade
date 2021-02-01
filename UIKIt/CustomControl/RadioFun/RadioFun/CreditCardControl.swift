//
//  RadioButton.swift
//  RadioFun
//
//  Created by jrasmusson on 2021-02-01.
//

import UIKit

public class CreditCardControl: UIControl {
    
    let stackView = UIStackView()
    
    let title = UILabel()
    let icon = UIImageView()
    let ccIcon = UIImageView()
    
    var offBGColor = UIColor.radioButtonOff
    var onBGColor = UIColor.radioButtonOn
    
    var onBorderColor = UIColor.radioButtonBorderOn.cgColor
    var offBorderColor = UIColor.radioButtonBorderOff.cgColor
    
    let onImage = UIImage(named: "on")
    let offImage = UIImage(named: "off")
        
    @objc public var isOn = false {
        didSet {
            layer.borderColor = isOn ? onBorderColor : offBorderColor
            backgroundColor = isOn ? onBGColor : offBGColor
            title.textColor = isOn ? .shawPrimaryBlue : .shawAlmostBlack
            icon.image = isOn ? onImage : offImage
        }
    }

     init() {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        layer.borderWidth = 1
        layer.cornerRadius = 2

        title.textAlignment = .left
        contentHorizontalAlignment = .left
        
        isOn = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        stackView.layoutMargins.left = 16
        stackView.layoutMargins.right = 16
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func layout() {
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(ccIcon)
        stackView.addArrangedSubview(title)
        
        addSubview(stackView)

        icon.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        ccIcon.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 52),
        ])

    }
}

public extension NSLayoutConstraint {
    @objc func setActiveBreakable(priority: UILayoutPriority = UILayoutPriority(900)) {
        self.priority = priority
        isActive = true
    }

    @objc func activeBreakable(priority: UILayoutPriority = UILayoutPriority(900)) -> NSLayoutConstraint {
        self.priority = priority
        isActive = true
        return self
    }
}

public extension UIColor {

    private static let _shawAlmostBlack = UIColor(white: 51.0 / 255.0, alpha: 1.0)
    @objc class var shawAlmostBlack: UIColor {
        return _shawAlmostBlack
    }

    private static let _shawPrimaryBlue = UIColor(red: 0.0, green: 130.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0)
    @objc class var shawPrimaryBlue: UIColor { // siShawRoyalBlue in Zeplin
        return _shawPrimaryBlue
    }

    private static let _shawLightGrey = UIColor(red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    @objc static var shawLightGrey: UIColor {
        return _shawLightGrey
    }

    private static let _shawMiddleGreyColor = UIColor(red: 144.0 / 255.0, green: 144.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
    @objc static var shawMiddleGrey: UIColor {
        return _shawMiddleGreyColor
    }

    private static let _shawLightBlue = UIColor(red: 2.0/255.0, green: 127.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    @objc static var shawLightBlue: UIColor {
        return _shawLightBlue
    }

    private static let _usageLineGrey = UIColor(red: 194.0/255.0, green: 194.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    @objc static var usageLineGrey: UIColor {
        return _usageLineGrey
    }

    private static let _dimOverBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50)
    @objc static var dimOverBlack: UIColor {
        return _dimOverBlack
    }

    private static let _toolbarOffWhite = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    @objc static var toolbarOffWhite: UIColor {
        return _toolbarOffWhite
    }

    private static let _shawSelectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
    @objc static var shawSelectedColor: UIColor {
        return _shawSelectedColor
    }

    private static let _shawUnselectedColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
    @objc static var shawUnselectedColor: UIColor {
        return _shawUnselectedColor
    }

    private static let _shawNoSearchResultsColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
    @objc static var shawNoSearchResultsColor: UIColor {
        return _shawNoSearchResultsColor
    }
}

public extension UIColor {
    
    private static let _shawPlaceholder = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 206.0 / 255.0, alpha: 1.0)
    @objc static var shawPlaceholder: UIColor {
        return _shawPlaceholder
    }

    private static let _shawPaleBlue = UIColor(red: 245.0 / 255.0, green: 248.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    @objc static var radioButtonOn: UIColor {
        return _shawPaleBlue
    }

    @objc static var radioButtonOff: UIColor {
        return .shawLightGrey
    }

    @objc static var radioButtonBorderOn: UIColor {
        return .shawPrimaryBlue
    }

    @objc static var radioButtonBorderOff: UIColor {
        return .shawPlaceholder
    }
}


public struct StackViewStyle {
    
    public static let tile: ViewStyle<UIStackView> = ViewStyle { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.insetsLayoutMarginsFromSafeArea = false
    }
    
    public static let flexRow: ViewStyle<UIStackView> = ViewStyle { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.insetsLayoutMarginsFromSafeArea = false
    }
    
    public static let tileRow: ViewStyle<UIStackView> = ViewStyle { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.insetsLayoutMarginsFromSafeArea = false
    }
}

public struct ViewStyle<T: UIView> {
    
    let styling: (T) -> Void
    
    public init(styling: @escaping (T) -> Void) {
        self.styling = styling
    }
    
    static public func compose(_ styles: ViewStyle<T>...)-> ViewStyle<T> {
        
        return ViewStyle { view in
            for style in styles {
                style.styling(view)
            }
        }
    }
    
    public func apply(to view: T) {
        styling(view)
    }
    
}

