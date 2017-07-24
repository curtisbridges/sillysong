//
//  ViewController.swift
//  Silly Song
//
//  Created by Curtis Bridges on 7/24/17.
//  Copyright © 2017 Curtis Bridges. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if let name = nameField.text {
            let trimmed = name.trimmingCharacters(in: CharacterSet.whitespaces)
            if trimmed != "" {
                lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: trimmed)
            }
        }
    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - Pure Functions
func shortNameFromName(name: String) -> String {
    let lowercase = name.lowercased()
    let vowels = CharacterSet(charactersIn:"aeiou")

    if let range = lowercase.rangeOfCharacter(from: vowels) {
        return lowercase.substring(from: range.lowerBound)
    } else {
        return lowercase
    }
}

// just define constants for the template variables
let FULLNAME = "<FULL_NAME>"
let SHORTNAME = "<SHORT_NAME>"

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    return lyricsTemplate.replacingOccurrences(of: FULLNAME, with: fullName).replacingOccurrences(of: SHORTNAME, with: shortNameFromName(name: fullName))
}
