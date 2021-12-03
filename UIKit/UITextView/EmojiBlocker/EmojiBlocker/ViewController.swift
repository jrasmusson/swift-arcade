//
//  ViewController.swift
//  EmojiBlocker
//
//  Created by Rasmusson, Jonathan on 2021-12-03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        textView.keyboardType = .asciiCapable
        textView.delegate = self
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        textView.resignFirstResponder()
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if containsValidCharacters(text) {
            errorLabel.isHidden = true
            return true
        }

        errorLabel.isHidden = false
        return false
    }

    private func containsValidCharacters(_ text: String) -> Bool {
        let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/# \n"
        let invalidSet = CharacterSet(charactersIn: validChars).inverted

        return text.rangeOfCharacter(from: invalidSet) == nil
    }
}
