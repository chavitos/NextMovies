//
//  CategoriesTableViewController.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit
import CoreData

protocol CategoriesListProtocol:class {
    func saveCategories(categories:[Category])
}

class CategoriesTableViewController: UITableViewController {

    var categories:[Category] = []
    var categoriesToSave:[Category] = []
    weak var delegate:CategoriesListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetch:NSFetchRequest<Category> = Category.fetchRequest()
        do{
            let categories = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(fetch)
            self.categories = categories
            
            tableView.reloadData()
        }catch{
            print("Erro ao tentar recuperar categorias: \(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name ?? "-"
        
        if categoriesToSave.contains(category){
            
            cell.accessoryType = .checkmark
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let category = categories[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if cell.accessoryType == .none {
            
            categoriesToSave.append(category)
            cell.accessoryType = .checkmark
        }else{
            
            categoriesToSave = categoriesToSave.filter { $0 != category }
            cell.accessoryType = .none
        }
    }

    @IBAction func done(_ sender: Any) {
    
        delegate?.saveCategories(categories: self.categoriesToSave)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
