//
//  ViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-17.
//

import UIKit

class TableViewController: UITableViewController {
    
    let animations = ["Basic", "Shake", "Fly"]
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
            navigationController?.pushViewController(SlideViewController(), animated: true)
        } else if indexPath.row == 1 {
            navigationController?.pushViewController(ShakeViewController(), animated: true)
        } else if indexPath.row == 2 {
            navigationController?.pushViewController(FlyViewController(), animated: true)
        }
    }
}
