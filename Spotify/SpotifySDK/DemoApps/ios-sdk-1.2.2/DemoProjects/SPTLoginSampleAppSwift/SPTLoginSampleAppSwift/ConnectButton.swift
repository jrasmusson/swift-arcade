import UIKit

class ConnectButton: UIButton {

    fileprivate let buttonBackgroundColor =
        UIColor(red:(29.0 / 255.0), green:(185.0 / 255.0), blue:(84.0 / 255.0), alpha:1.0)
    fileprivate let titleAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .heavy),
        .foregroundColor: UIColor.white,
        .kern: 2.0
    ]

    init(title: String) {
        super.init(frame: CGRect.zero)
        backgroundColor = buttonBackgroundColor
        contentEdgeInsets = UIEdgeInsets(top: 11.75, left: 32.0, bottom: 11.75, right: 32.0)
        layer.cornerRadius = 20.0
        translatesAutoresizingMaskIntoConstraints = false
        let title = NSAttributedString(string: title, attributes: titleAttributes)
        setAttributedTitle(title, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
