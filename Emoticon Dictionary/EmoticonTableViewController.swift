//
//  EmoticonTableTableViewController.swift
//  Emoticon Dictionary
//
//  Created by Juliana Nielson on 3/7/23.
//

import UIKit

class EmoticonTableViewController: UITableViewController {
    
    var emoticons = [Emoticon]() {
        didSet {
            emoticonController.saveDictionary(dictionary: emoticons)
        }
    }
    var emoticonController = EmoticonController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        if emoticonController.retrieveDictionary() != [] {
              emoticons = (emoticonController.retrieveDictionary())
        } else {
            emoticons = emoticonController.sampleEmoticons()
        }
        
        
    }
    
    @IBAction func unwindToEmoticonTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? AddEditEmoticonTableViewController, let emoticon = sourceViewController.emoticon else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emoticons[selectedIndexPath.row] = emoticon
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emoticons.count, section: 0)
            emoticons.append(emoticon)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    @IBSegueAction func AddEditEmoticon(_ coder: NSCoder, sender: Any?) -> AddEditEmoticonTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let emoticonToEdit = emoticons[indexPath.row]
            return AddEditEmoticonTableViewController(coder: coder, emoticon: emoticonToEdit)
        } else {
            return AddEditEmoticonTableViewController(coder: coder, emoticon: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoticons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emoticon Cell", for: indexPath) as! EmoticonTableViewCell
        
        let emoticon = emoticons[indexPath.row]
        cell.emoticon = emoticon
        cell.showsReorderControl = true
        
        return cell
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoticon = emoticons.remove(at: sourceIndexPath.row)
        emoticons.insert(movedEmoticon, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emoticons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
