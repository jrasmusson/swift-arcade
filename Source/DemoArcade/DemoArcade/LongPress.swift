//
//  LongPress.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

/*
Abstract:
Sample demonstrating UILongPressGestureRecognizer to move cells within a UITableView.
*/

import UIKit

class LongPress: UIViewController {
    
    var games = ["Space Invaders",
                "Dragon Slayer",
                "Disks of Tron",
                "Moon Patrol",
                "Galaga"]

    let cellId = "cellId"
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "UITableView"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        view = tableView
        
        ///
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
        ///
    }

}

// MARK: - LongPress

///
/// The way this works is
///  - the gestureRecognizer figure out where in the tableView we are (i.e. which row)
///  - it then creates an image of that row, and if the gesture moves enough to warrant a reorder, it
///     - adds it to the view
///     - pops it off the screen
///     - tells the tableView to move the cell
///     - and updates our data source

extension LongPress {
    
    @objc func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        
        // Figure out where we are in the tableView (i.e. which row was selected)
        let longPress = gestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: locationInView)
        
        // Create some inhouse data structures to track state and where we are
        struct My {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        
        switch state {
            
        case UIGestureRecognizerState.began:
            
            // if we have have a row
            if indexPath != nil {
                
                // Take a snap shot (build a UIView) of selected row
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!)
                My.cellSnapshot  = snapshotOfCell(cell!)
                
                // Add snap shot as a subview to the current cell, centered and faded out
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                tableView.addSubview(My.cellSnapshot!)
                
                // Animate the snapshot in, while fading the original cell out.
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    // Offset for gesture location
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    
                    // Scale up our cell to make it look slightly bigger
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    
                    // Fade out
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    // Once finished
                    if finished {
                        // Animiate original cell back in
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            // Keep original cell hidden
                            cell?.isHidden = true
                        }
                    }
                })
            }
            
        case UIGestureRecognizerState.changed:
            // As long as the user is dragging the cell
            if My.cellSnapshot != nil {
                // Move the cell with the drag
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                
                // If moves enough to warrant a new index
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    // update data source
                    games.insert(games.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    // tell table to move the row
                    tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                    // update index so in sync with UI changes
                    Path.initialIndexPath = indexPath
                }
            }
        default:
            // Finally, when the gesture either ends or cancels,
            // both the table view and data source are up to date.
            // All you have to do is remove the snapshot from the table view and revert the fadeout.
            
            // For a better user experience, fade out the snapshot and make it smaller to match the size of the cell.
            // It appears as if the cell drops back into place.
            
            // If our cellSnapShot is still around
            if Path.initialIndexPath != nil {
                // Get the tableViewCell
                let cell = tableView.cellForRow(at: Path.initialIndexPath!)
                
                // Check whether we are in the middle of animating (remember we are in a big gesture touch loop).
                
                if My.cellIsAnimating {
                    // Either show our snapshot cell
                    My.cellNeedToShow = true
                } else {
                    // Or show the original cell if we are done
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                }
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell?.center)!
                    // Undo the scaling we did earlier
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0  // fade out our cell
                    cell?.alpha = 1.0             // fade in the real one
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
                })
            }
        }
    }
    
    // Create an offset image of the cell you just selected
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
}

// MARK: - UITableView

extension LongPress: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension LongPress: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
