//
//  MainViewController.swift
//  Challenge74
//
//  Created by Евгений Карпов on 08.01.2022.
//

import UIKit

class MainViewController: UITableViewController {
  
  // MARK: - Properties
  var notes = [Note]()
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    notes = StorageManager.shared.fetchData()
    notes.sort {
      $0.name > $1.name
    }
    tableView.reloadData()
  }
  
  // MARK: - Module functions
  @objc private func addNote() {
    let ac = UIAlertController(title: "Add note name", message: nil, preferredStyle: .alert)
    ac.addTextField { textField in
      textField.placeholder = "Name"
    }
    ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
      guard let noteName = ac.textFields?.first?.text, noteName != "" else {
        return
      }
      let note = Note(name: noteName, text: "")
      self?.notes.append(note)
      self?.tableView.reloadData()
      StorageManager.shared.saveData(note: note)
    }))
    ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    present(ac, animated: true)
  }
  
  private func setupNavigationController() {
    title = "Notes"
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
    navBarAppearance.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 1, alpha: 1)
    navigationController?.navigationBar.standardAppearance = navBarAppearance
    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    navigationController?.isToolbarHidden = false
    navigationController?.toolbar.tintColor = #colorLiteral(red: 1, green: 0.7620360255, blue: 0, alpha: 1)
    
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let add = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil") ?? UIImage(),
                              style: .done,
                              target: self,
                              action: #selector(addNote))
    

    toolbarItems = [spacer, add]
  }
  
  // MARK: - TableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard var cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") else {
      var cell = UITableViewCell(style: .default, reuseIdentifier: "noteCell")
      configure(cell: &cell, indexPath: indexPath)
      return cell
    }
    configure(cell: &cell, indexPath: indexPath)
    return cell
  }
  
  private func configure( cell: inout UITableViewCell, indexPath: IndexPath) {
    var configurator = cell.defaultContentConfiguration()
    configurator.text = notes[indexPath.row].name
    cell.contentConfiguration = configurator
    cell.contentView.layer.cornerRadius = 5
    cell.contentView.layer.masksToBounds = true
  }
  
  // MARK: - TableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "ShowDetails", sender: indexPath)
  }

  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
      notes.remove(at: indexPath.row)
      self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
      StorageManager.shared.deleteData(at: indexPath)
    }
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let detailVC = segue.destination as? DetailViewController,
          let indexPath = sender as? IndexPath else {
            return
    }
    detailVC.note = notes[indexPath.row]
    StorageManager.shared.deleteData(at: indexPath)
  }
}

