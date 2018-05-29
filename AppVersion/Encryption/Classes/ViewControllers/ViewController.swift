//
//  ViewController.swift
//  Extensions
//
//  Created by Gene Backlin on 1/15/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

let secureKey = "12345678901234567890123456789012"
let secureSalt16 = "iv-salt-string--"

class ViewController: UIViewController {
    
    @IBOutlet weak var entryTextField: UITextField!
    @IBOutlet weak var encryptedTextView: UITextView!
    @IBOutlet weak var aesEncryptLabel: UILabel!
    @IBOutlet weak var aesDecryptLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        encryptedTextView.text = ""
        aesEncryptLabel.text = ""
        aesDecryptLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Utility methods
    
    func encrypt() {
        let textToEncrypt = entryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let clearText = textToEncrypt {
            encryptedTextView.text = clearText.sha256()
            aesEncryptDecrypt(text: clearText, key: secureKey, salt16: secureSalt16)
        } else {
            encryptedTextView.text = ""
            aesEncryptLabel.text = ""
            aesDecryptLabel.text = ""
        }
    }
    
    func aesEncryptDecrypt(text: String, key: String, salt16: String) {
        let encryptedString = text.aesEncrypt(key: key, iv: salt16)
        let clearText = encryptedString?.aesDecrypt(key: key, iv: salt16)
        
        aesEncryptLabel.text = encryptedString!
        aesDecryptLabel.text = clearText!
    }
    
    // MARK: - @IBAction methods
    
    @IBAction func encrypt(_ sender: UIBarButtonItem) {
        encrypt()
   }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        encrypt()
        
        return true
    }
}
