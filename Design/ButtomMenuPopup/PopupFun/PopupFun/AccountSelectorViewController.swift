//
//  AccountSelectorViewController.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-09.
//

import UIKit

protocol AccountSelectorDelegate: AnyObject {
    func didTap(_ account: String)
}

class AccountSelectorViewController: UIViewController {
        
    let backgroundOverlayView = UIView()
    let stackView = UIStackView()
    let headerView = AccountSelectorHeaderView()
    let topSpacerHeight: CGFloat
    
    weak var delegate: AccountSelectorDelegate?
    
    // table view
    let accounts = [
        "Checking",
        "Savings",
        "Expenses",
        "Investing",
        "Retirement",
        "Travel"
    ]
    
    let cellId = "cellId"
    var tableView = UITableView()
    
    init(height: CGFloat) {
        self.topSpacerHeight = height
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setup()
        layout()
    }
}

extension AccountSelectorViewController {
    
    func style() {
        backgroundOverlayView.translatesAutoresizingMaskIntoConstraints = false
        backgroundOverlayView.backgroundColor = .black
        backgroundOverlayView.alpha = 0.3
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOverlay))
        backgroundOverlayView.addGestureRecognizer(tap)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    func layout() {
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(tableView)
        
        view.addSubview(backgroundOverlayView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            backgroundOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpacerHeight),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension AccountSelectorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTap(accounts[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

extension AccountSelectorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = accounts[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

// MARK: - Actions

extension AccountSelectorViewController {
    @objc func tappedOverlay() {
        dismiss(animated: true, completion: nil)
    }
}
