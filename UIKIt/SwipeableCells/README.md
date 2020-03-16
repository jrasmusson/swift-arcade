# Swipeable Cells

## Edit Mode

### Delete

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/UIKIt/SwipeableCells/images/edit-mode-delete.gif)

By adding the built in _editButton_ to the _rightBarButtonItem_ we get some built in _Edit_ _Done_ button transformations which automatically call _setEditing_ for us which in turn enables us to put the `UITableView` into edit mode.

```swit
func setupViews() {
    navigationItem.title = "Classic Arcade"
    navigationItem.rightBarButtonItem = editButtonItem // magic!

    view = tableView
}

override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.setEditing(editing, animated: animated)
}
```

We can then react to the style of the cell row returned (`.delete` by default).

```swift
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            addGame("Ms Pacman")
        }
    }

```

### Insert

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/UIKIt/SwipeableCells/images/edit-mode-insert.gif)

If we want to insert we need to override the default `.delete` editting style and return an `.insert` one.

```swift
// To trigger single action insert mode.
func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .insert
}
```

Which can then in turn insert a row.

```swift
private func addGame(_ game: String) {
    games.append(game)

    let indexPath = IndexPath(row: games.count - 1, section: 0)

    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .fade)
    tableView.endUpdates()
}
```


## Swipeable

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/UIKIt/SwipeableCells/images/swipeable.gif)

To make cells swipeable, return a collection of swipe actions for either the trailing or leading side.

```swift
func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in
        self.games.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    })
    action.image = makeSymbolImage(systemName: "trash")

    let configuration = UISwipeActionsConfiguration(actions: [action])

    return configuration
}

func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let action = UIContextualAction(style: .normal, title: "Document", handler: { (action, view, completionHandler) in
        // Do something with documents...
    })
    action.image = makeSymbolImage(systemName: "paperclip")

    let configuration = UISwipeActionsConfiguration(actions: [action])

    return configuration
}
```


### Swipeable Add

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/UIKIt/SwipeableCells/images/swipeable-add.gif)

You can either do an add on the view itself.

```swift
@objc
func addButtonPressed() {
    guard let text = textField.text else { return }
    games.append(text)

    let indexPath = IndexPath(row: games.count - 1, section: 0)

    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .fade)
    tableView.endUpdates()
}
```

### Modal Add

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/UIKIt/SwipeableCells/images/modal-add.gif)

Or you can create a dedicated modal and present it from there. Communication back can be _protocol delegate_.

```swift
@objc
func addGameTapped() {
    present(saveGameViewController, animated: true, completion: nil)
}
```

### Video

- [Swipeable TableView Cells](https://www.youtube.com/watch?v=ND6uLMEbb0c)

### Links that help

- [Inserting and Deleting Rows](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html)

