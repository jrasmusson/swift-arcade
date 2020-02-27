//
//  TextFieldViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {

    let textField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = UIFont.preferredFont(forTextStyle: .body)
            textField.textAlignment = .center
            textField.backgroundColor = .systemFill

            return textField
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPublishers()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(textField)

        textField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 3).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    var subscriber: Any?

    func setupPublishers() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)

        subscriber = publisher.sink { (notification) in
            print(123)
        }


//        extension UITextField {
//            var textPublisher: AnyPublisher<String, Never> {
//                NotificationCenter.default
//                    .publisher(for: UITextField.textDidChangeNotification, object: self)
//                    .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
//                    .map { $0.text ?? "" } // mapping UITextField to extract text
//                    .eraseToAnyPublisher()
//            }
//        }

        // subscribe
//        let sub = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
//        .sink(receiveCompletion: { print ($0) },
//              receiveValue: { print ($0) })

        // convert to the output type we want
//        let sub = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
//            .map( { ($0.object as! UITextField).text! } )
//            .sink(receiveCompletion: { print ($0) },
//                  receiveValue: { print ($0) })

        // then assign that value to a model
//        let sub = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
//            .map( { ($0.object as! UITextField).text! } )
//            .assign(to: \MyViewModel.filterString, on: myViewModel)

//        struct MyViewModel {
//            let filterString: String
//        }
//
//        let myViewModel = MyViewModel(filterString: "")
//
//        let sub = NotificationCenter.default
//        .publisher(for: UITextField.textDidChangeNotification, object: textField)
//        .map( { ($0.object as! UITextField).text! } )
//        .filter( { $0.unicodeScalars.allSatisfy({CharacterSet.alphanumerics.contains($0)}) } )
//        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
//        .receive(on: RunLoop.main)
//        .assign(to:\MyViewModel.filterString, on: myViewModel)

    }

    // MARK: - Textfield

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true) // gives up keyboard on touch
//    }
}


//extension TextFieldViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true;
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("Check textfield")
//    }
//}
