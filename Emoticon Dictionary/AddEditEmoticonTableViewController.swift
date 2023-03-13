//
//  AddEditEmoticonTableViewController.swift
//  Emoticon Dictionary
//
//  Created by Juliana Nielson on 3/8/23.
//

import UIKit

class AddEditEmoticonTableViewController: UITableViewController {

    var emoticon: Emoticon?
    
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    init?(coder: NSCoder, emoticon: Emoticon?) {
        self.emoticon = emoticon
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoticon {
            symbolTextField.text = emoticon.symbol
            nameTextField.text = emoticon.name
            descriptionTextField.text = emoticon.description
            usageTextField.text = emoticon.usage
            title = "Edit Emoticon"
        } else {
            title = "Add Emoticon"
        }
        
        updateSaveButtonState()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) &&
        !nameText.isEmpty && !descriptionText.isEmpty &&
        !usageText.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue,
       sender: Any?) {
    
        guard segue.identifier == "saveUnwind" else { return }
    
        let symbol = symbolTextField.text!
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoticon = Emoticon(symbol: symbol, name: name,
           description: description, usage: usage)
    }
    
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        
        let isEmoji = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isEmoji
    }
}
