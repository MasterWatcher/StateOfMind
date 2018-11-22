//
//  ViewController.swift
//  StateOfMind
//
//  Created by MasterWatcher on 10/19/2018.
//  Copyright (c) 2018 MasterWatcher. All rights reserved.
//

import UIKit
import StateOfMind

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var delaySlider: UISlider!
    
    let service = MenuService()
    var menuItems = [MenuItem]()
    
    lazy var stateMachine = StateMachine(displayable: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMenuItems()
    }
    
    @IBAction func loadContentPressed(_ sender: Any) {
        service.resultType = .content
        loadMenuItems()
    }

    @IBAction func loadEmptyPressed(_ sender: Any) {
        service.resultType = .empty
        loadMenuItems()
    }

    @IBAction func loadErrorPressed(_ sender: Any) {
        service.resultType = .error
        loadMenuItems()
    }
    
    func loadMenuItems() {
        stateMachine.setState(.loading)
        service.loadMenu { [weak self] (menuItems, error) in
            if let menuItems = menuItems {
                guard !menuItems.isEmpty else {
                    self?.stateMachine.setState(.empty)
                    return
                }
                self?.stateMachine.setState(.content(menuItems))
            }
            if let error = error {
                self?.stateMachine.setState(.error(error))
            }
        }
    }
    
    func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        delayLabel.text = "Delay: \(service.delay)"
        delaySlider.value = Float(service.delay)
        delaySlider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged(sender: UISlider) {
        delayLabel.text = "Delay: \(sender.value)"
        service.delay = Double(sender.value)
    }
}

extension ViewController: StateDisplayable {

    func showLoading(_: String) {
       
    }

    func showContent(_ menuItems: [MenuItem]) {
        self.menuItems = menuItems
        tableView.reloadData()
    }

    func showEmpty(_: String) {
       
    }

    func showError(_ error: Error) {
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name + " $" + "\(menuItem.price)"
        return cell
    }
}
