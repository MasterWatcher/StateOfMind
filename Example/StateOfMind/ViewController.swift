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

    @IBOutlet var contentLabel: UILabel!

    private lazy var stateMachine = StateMachine(displayable: self)

    @IBAction func loadContentPressed(_ sender: Any) {
        stateMachine.setState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.stateMachine.setState(.content("Content"))
        }
    }

    @IBAction func loadEmptyPressed(_ sender: Any) {
        stateMachine.setState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.stateMachine.setState(.empty)
        }
    }

    @IBAction func loadErrorPressed(_ sender: Any) {
        stateMachine.setState(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.stateMachine.setState(.error(Errors.someError))
        }
    }
}

extension ViewController: StateDisplayable {

    func showLoading() {
        contentLabel.text = "Loading..."
    }

    func showContent(_ content: String) {
        contentLabel.text = content
    }

    func showEmpty() {
        contentLabel.text = "Empty"
    }

    func showError(_ error: Error) {
        contentLabel.text = "Error"
    }
}

enum Errors: Error {
    case someError
}

