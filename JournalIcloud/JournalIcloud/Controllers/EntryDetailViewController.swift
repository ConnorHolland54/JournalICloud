//
//  EntryDetailViewController.swift
//  JournalIcloud
//
//  Created by Connor Holland on 6/29/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    var entry: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.delegate = self
        updateView()
    }
    
    
    func updateView() {
        if let entry = entry {
            titleLabel.text = entry.title
            bodyTextView.text = entry.body
        }
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titleLabel.resignFirstResponder()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleLabel.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleLabel.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else {return}
        EntryController.shared.createEntryWith(title: title, body: body) { (result) in
            switch (result) {
                
            case .success(let entry):
                EntryController.shared.entries.insert(entry, at: 0)
             DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleLabel.resignFirstResponder()
        return true
    }
}
