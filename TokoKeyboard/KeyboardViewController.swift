//
//  KeyboardViewController.swift
//  TokoKeyboard
//
//  Created by kapilrathore-mbp on 24/01/20.
//  Copyright © 2020 Kapil Rathore. All rights reserved.
//

import UIKit

var proxy : UITextDocumentProxy!

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet var changeCaseButton: UIButton!
    @IBOutlet var spacerButton: UIButton!
    @IBOutlet var nextLineButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var changenumberPad: UIButton!
    @IBOutlet var changeKeyBoard: UIButton!

    var keys: [UIButton] = []
    
    var keyboardView: UIView!
    
    var shiftButtonState = ShiftButtonState.normal
    
    enum ShiftButtonState {
        case normal
        case shift
        case caps
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        keyboardView.frame.size = view.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proxy = textDocumentProxy as UITextDocumentProxy
        
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as? UIView
        view.addSubview(keyboardView)
        
        setupKeyboardUI()
    }
    
    private func setupKeyboardUI() {
        letterButtons.forEach { button in
            
            let key = button.titleLabel?.text ?? ""
            let capsKey = key.capitalized
            let keyToDisplay = shiftButtonState == .normal ? key : capsKey

            button.layer.setValue(key, forKey: "original")
            button.layer.setValue(keyToDisplay, forKey: "keyToDisplay")
            button.layer.setValue(false, forKey: "isSpecial")

            button.setTitle(keyToDisplay, for: .normal)
            button.backgroundColor = .clear
            

            button.addTarget(self, action: #selector(keyPressedTouchUp), for: .touchUpInside)
            button.addTarget(self, action: #selector(keyTouchDown), for: .touchDown)
            button.addTarget(self, action: #selector(keyUntouched), for: .touchDragExit)
        }
    }
    
    @objc func keyTouchDown(_ sender: UIButton){
        sender.backgroundColor = .lightGray
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderColor = keyboardView.backgroundColor?.cgColor
        sender.layer.borderWidth = 4
        sender.layer.cornerRadius = 5
    }
    
    @objc func keyUntouched(_ sender: UIButton){
        sender.backgroundColor = keyboardView.backgroundColor
        sender.setTitleColor(.darkGray, for: .normal)
        sender.layer.borderWidth = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    @objc private func keyPressedTouchUp(_ sender: UIButton) {
        sender.backgroundColor = .clear
        sender.setTitleColor(.darkGray, for: .normal)
        
        guard let originalKey = sender.layer.value(forKey: "original") as? String,
              let keyToDisplay = sender.layer.value(forKey: "keyToDisplay") as? String else {return}
        proxy.insertText(keyToDisplay)
        let asdf = UserDefaults(suiteName: "asdf")?.string(forKey: "asdf")
        proxy.insertText(asdf ?? "na")
    }
}
