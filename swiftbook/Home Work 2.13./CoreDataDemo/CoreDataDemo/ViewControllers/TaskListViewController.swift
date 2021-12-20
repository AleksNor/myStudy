//
//  TaskListViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Карпов on 17.12.2021.
//

import UIKit

class TaskListViewController: UITableViewController{
    
    // MARK: - Prperties
    
    private let cellID = "cell"
    private var tasks: [Task] = []
    private var storageManager: StorageManagerProtocol!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        storageManager = StorageManager.shared
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = storageManager.fetchData()
    }
    // MARK: - Private methods
    
    @objc private func addNewTask() {
        showAlert()
    }
    
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.configureWithOpaqueBackground()
        navBarApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 191/255,
            alpha: 194/255)
        
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "New Task",
            message: "Вы хотите добавить новую задачу?",
            preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New Task"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let taskName = alert.textFields?.first?.text, !taskName.isEmpty  else { return }
            guard let task = self.storageManager.saveData(with: taskName) else { return }
            self.tasks.append(task)
            let cellIndex = IndexPath(row: self.tasks.count - 1, section: 0)
            self.tableView.insertRows(at: [cellIndex], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - TableViewSetup

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = tasks[indexPath.row]

        var configuartion = cell.defaultContentConfiguration()
        configuartion.text = task.name
        cell.contentConfiguration = configuartion
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSwipeInstance = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.storageManager.removeDate(at: indexPath)
            self.tasks.remove(at: indexPath.row)
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
}

