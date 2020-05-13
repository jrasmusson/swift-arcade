//
//  MVPComplex.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

///
/// Model
///

struct MVPUser {
    let firstName: String
    let lastName: String
    let age: Int
}

///
/// View
///

class MVPComplexViewController: UIViewController {

    lazy var userPresenter = UserPresenter(userService: MVPUserService(), userView: self)

    let cellId = "mvpCellId"
    var tableView = UITableView()
    var usersToDisplay = [MVPUserViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        userPresenter.getUsers()
    }

    override func loadView() {
        view = tableView
    }
}

extension MVPComplexViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellId)

        let userViewData = usersToDisplay[indexPath.row]
        cell.textLabel?.text = userViewData.name
        cell.detailTextLabel?.text = userViewData.age

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToDisplay.count
    }
}

extension MVPComplexViewController: MVPUserView {

    func setUsers(users: [MVPUserViewData]) {
        usersToDisplay = users
        tableView.reloadData()
    }

    func setEmptyUsers() {
        view.backgroundColor = .systemRed
    }
}


///
/// Presenter
///

// UI friendly model for the view.
struct MVPUserViewData {
    let name: String
    let age: String
}

// A UIKit agnostic protocol to talk to the View.
protocol MVPUserView: AnyObject {
    func setUsers(users: [MVPUserViewData])
    func setEmptyUsers()
}

class UserPresenter {

    private let userService: MVPUserService
    weak var userView: MVPUserView?

    init(userService: MVPUserService, userView: MVPUserView) {
        self.userService = userService
        self.userView = userView
    }

    func getUsers(){

        userService.getUsers{ [weak self] users in
            if users.count == 0 {
                self?.userView?.setEmptyUsers()
            } else {
                let mappedUsers = users.map {
                    return MVPUserViewData(name: "\($0.firstName) \($0.lastName)", age: "\($0.age) years")
                }
                self?.userView?.setUsers(users: mappedUsers)
            }
        }
    }
}

class MVPUserService {

    func getUsers(callBack: @escaping ([MVPUser]) -> Void){
        let users = [MVPUser(firstName: "Kevin", lastName: "Flynn", age: 36),
                     MVPUser(firstName: "Alan", lastName: "Bradley", age: 24),
                     MVPUser(firstName: "Ed", lastName: "Dilinger", age: 39)
                    ]
//        let users = [MVPUser]()

        let dispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            callBack(users)
        })
    }
}
