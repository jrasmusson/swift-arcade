# Moveable Cells

There are two ways you can move _UITableViewCells_ around in UIKit.

1. Edit Mode
2. Long Press

## Edit Mode

![demo](images/edit-mode.gif)

Edit mode is a mode you put a _UITableView_ in when you call.

```swift
tableView.setEditing(true, animated: true)
```

This animates the table making the red delete buttons pop up, and when you click out of edit mode, they disappear.

To support edit you need to implement these two methods. _canEditRowAt_ make each row edittable. And commit is what gets called when your changes are committed. In this example is is a Diffable Data Source.

```swift
// MARK: editing support

override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
}

override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // when deleting a row...
    if editingStyle == .delete {
        if let identifierToDelete = itemIdentifier(for: indexPath) {
            var snapshot = self.snapshot()
            snapshot.deleteItems([identifierToDelete])
            apply(snapshot)
        }
    }
}
```

### Making the cells moveable

When in edit mode you also get the grabble hamburger menu items on the right hand side of each cell that you can grab and move.

The way this works is pointers, or source/destinationIdentifiers keep track of which row is selected, and where it is being asked to be moved to. Once there, the Diffable Data Source updates itself, and handles all the animations to make the move happen. If we weren't using a Diffable Data source we would have to do all that logic ourselves. Like in our next example with Long Press.

```swift
// MARK: reordering support
    
override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
}
    
override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

    // get our source & destination (from & to)
    guard let sourceIdentifier = itemIdentifier(for: sourceIndexPath) else { return }
    guard sourceIndexPath != destinationIndexPath else { return }
    let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
    
    // take snapshot before
    var snapshot = self.snapshot()

    // if moving within a section
    if let destinationIdentifier = destinationIdentifier {
        
        guard let sourceIndex = snapshot.indexOfItem(sourceIdentifier) else { return }
        guard let destinationIndex = snapshot.indexOfItem(destinationIdentifier) else { return }

        // delete it
        snapshot.deleteItems([sourceIdentifier])

        // figure out if before or after (and double check same section)
        let isAfter = destinationIndex > sourceIndex &&
            snapshot.sectionIdentifier(containingItem: sourceIdentifier) ==
            snapshot.sectionIdentifier(containingItem: destinationIdentifier)
                        
        // insert back either before or after
        if isAfter {
            snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
        } else {
            snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
        }

    }
    // move between sections
    else {
        // get the new destination section
        let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
        // delete where it was
        snapshot.deleteItems([sourceIdentifier])
        // add to where it is going
        snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
    }
    
    apply(snapshot, animatingDifferences: false)
}
```


## Long Press

![demo](images/long-press.gif)

Long Press uses a `UILongPressGestureRecognizer` to detect when the user has pressed a row in the table.

```swift
let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
tableView.addGestureRecognizer(longpress)
```

And then does a whole bunch of magic to take a picture (build a `UIView`) of the cell that was tapped, animates it up above the _UITableView_, moves it around with the gesture, and then animates/fades it back into the table.


## Source Edit Mode

```swift
//
//  EditMode.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

/*
Abstract:
Sample demonstrating UITableViewDiffableDataSource using editing, reordering and header/footer titles support
*/

import UIKit

class EditMode: UIViewController {

    enum Section: Int {
        case visited = 0, bucketList
        func description() -> String {
            switch self {
            case .visited:
                return "Visited"
            case .bucketList:
                return "Bucket List"
            }
        }
        func secondaryDescription() -> String {
            switch self {
            case .visited:
                return "Trips I've made!"
            case .bucketList:
                return "Need to do this before I go!"
            }
        }
    }
    
    typealias SectionType = Section
    typealias ItemType = MountainsController.Mountain
    
    let reuseIdentifier = "reuse-id"
    
    // Subclassing our data source to supply various UITableViewDataSource methods
    
    class MoveableCellDataSource: UITableViewDiffableDataSource<SectionType, ItemType> {
        
        // MARK: header/footer titles support
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.secondaryDescription()
        }
        
        // MARK: reordering support
        
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

            // get our source & destination (from & to)
            guard let sourceIdentifier = itemIdentifier(for: sourceIndexPath) else { return }
            guard sourceIndexPath != destinationIndexPath else { return }
            let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
            
            // take snapshot before
            var snapshot = self.snapshot()

            // if moving within a section
            if let destinationIdentifier = destinationIdentifier {
                
                guard let sourceIndex = snapshot.indexOfItem(sourceIdentifier) else { return }
                guard let destinationIndex = snapshot.indexOfItem(destinationIdentifier) else { return }

                // delete it
                snapshot.deleteItems([sourceIdentifier])

                // figure out if before or after (and double check same section)
                let isAfter = destinationIndex > sourceIndex &&
                    snapshot.sectionIdentifier(containingItem: sourceIdentifier) ==
                    snapshot.sectionIdentifier(containingItem: destinationIdentifier)
                                
                // insert back either before or after
                if isAfter {
                    snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
                } else {
                    snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
                }

            }
            // move between sections
            else {
                // get the new destination section
                let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
                // delete where it was
                snapshot.deleteItems([sourceIdentifier])
                // add to where it is going
                snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
            }
            
            apply(snapshot, animatingDifferences: false)
        }
        
        // MARK: editing support

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            // when deleting a row...
            if editingStyle == .delete {
                if let identifierToDelete = itemIdentifier(for: indexPath) {
                    var snapshot = self.snapshot()
                    snapshot.deleteItems([identifierToDelete])
                    apply(snapshot)
                }
            }
        }
    }
    
    var dataSource: MoveableCellDataSource!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        configureNavigationItem()
    }
}

extension EditMode {
    func configureHierarchy() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        let formatter = NumberFormatter()
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        
        // data source
        
        dataSource = MoveableCellDataSource(tableView: tableView) { (tableView, indexPath, mountain) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: self.reuseIdentifier)
            }

            cell.textLabel?.text = mountain.name

            if let formattedHeight = formatter.string(from: NSNumber(value: mountain.height)) {
                cell.detailTextLabel?.text = "\(formattedHeight)M"
            }

            return cell
        }
        
        // initial data
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func initialSnapshot() -> NSDiffableDataSourceSnapshot<SectionType, ItemType> {
        let mountainsController = MountainsController()
        let limit = 8
        let mountains = mountainsController.filteredMountains(limit: limit)
        let bucketList = Array(mountains[0..<limit / 2])
        let visited = Array(mountains[limit / 2..<limit])

        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.visited])
        snapshot.appendItems(visited)
        snapshot.appendSections([.bucketList])
        snapshot.appendItems(bucketList)
        return snapshot
    }
    
    func configureNavigationItem() {
        navigationItem.title = "Edit Mode"
        let editingItem = UIBarButtonItem(title: tableView.isEditing ? "Done" : "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItems = [editingItem]
    }
    
    @objc
    func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        configureNavigationItem()
    }
}
```


## Source Long Press

```swift
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
```

### Video

- [Swift Arcade Moveable Cells](https://www.youtube.com/watch?v=pC4H4rm70FI)
- [Swift Arcade Diffable Data Sources](https://www.youtube.com/watch?v=SCpqBqCX-vg)

### Links that help

- [Move Row At](https://developer.apple.com/videos/play/wwdc2019/220/)
- [WWDC Sample Source Code](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/using_collection_view_compositional_layouts_and_diffable_data_sources)
- [WWDC Apple Diffable Data Source 2019](https://developer.apple.com/videos/play/wwdc2019/220/)
- [Example Reordering TableView Cells using UIGestureRecognizer](https://medium.com/@ehsanzaman/reordering-tableview-cells-using-uigesturerecognizer-745ff627714a)
- [Apple Article Handling Long-Press Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_long-press_gestures)