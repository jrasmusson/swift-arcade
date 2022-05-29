//
//  PreviewExtentions.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-29.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
        return
    }
}

@available(iOS 13, *)
public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    public let view: View

    public init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable
    public func makeUIView(context: Context) -> UIView {
        return view
    }

    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

#endif

#if canImport(SwiftUI) && DEBUG
import SwiftUI

let deviceNames: [String] = [
    "iPhone SE",
    "iPhone 11 Pro Max",
    "iPad Pro (11-inch)"
]

//@available(iOS 13.0, *)
//struct ViewController_Preview: PreviewProvider {
//  static var previews: some View {
//    ForEach(deviceNames, id: \.self) { deviceName in
//      UIViewControllerPreview {
//        ViewController()
//      }.previewDevice(PreviewDevice(rawValue: deviceName))
//        .previewDisplayName(deviceName)
//    }
//  }
//}
#endif

#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct SimpleView_Preview: PreviewProvider {
//  static var previews: some View {
//    UIViewPreview {
//      let button = SimpleView()
//      return button
//    }.previewLayout(.sizeThatFits)
//     .padding(10)
//  }
//}
#endif
