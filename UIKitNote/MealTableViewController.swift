//
//  MealTableViewController.swift
//  UIKitNote
//
//  Created by HuangSenhui on 2020/12/20.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let meals = Meal.read() {
            self.meals = meals
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell

        let meal = meals[indexPath.row]
        
        cell.photoImageView.image = meal.image
        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addItem":
            guard let mealVC = segue.destination as? MealViewController else { return }
            mealVC.meal = nil
        case "showDetail":
            guard let mealVC = segue.destination as? MealViewController else { return }
            guard let cell = sender as? MealTableViewCell else { return }
            
            guard let selectedIndexPath = tableView.indexPath(for: cell) else { return }
            let meal = meals[selectedIndexPath.row]
            mealVC.meal = meal
        default:
            fatalError("未实现Segue ：\(String(describing: segue.identifier))")
        }
    }
    
    @IBAction func unwindToMealTabVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        if let vc = sourceViewController as? MealViewController {
            if let seletedIndex = tableView.indexPathForSelectedRow {
                meals[seletedIndex.row] = vc.meal!
                tableView.reloadRows(at: [seletedIndex], with: .none)
                Meal.save(meals: meals)
            } else {
                let meal = vc.meal!
                let indexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [indexPath], with: .automatic)
                Meal.save(meals: meals)
            }
        }
    }

    
}
