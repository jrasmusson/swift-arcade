//
//  ViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

class TableViewController: UITableViewController {
    
    let animations = ["Implement drawRect on UIView", "Load via UIImageView", "The Coordinate System"]
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Core Animation Intro"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = animations[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(DrawRectViewController(), animated: true)
        }
        else if indexPath.row == 1 {
            navigationController?.pushViewController(LoadViaImageViewController(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(CoordinateSystemViewController(), animated: true)
        }
    }
}
