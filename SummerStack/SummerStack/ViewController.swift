//
//  ViewController.swift
//  SummerStack
//
//  Created by Don Mag on 6/6/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

class MyBaseVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let v = UILabel()
		v.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
		v.textAlignment = .center
		v.text = String(describing: type(of: self))
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		NSLayoutConstraint.activate([
			v.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
}
class MachineStatusBarNewViewController: MyBaseVC {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
	}
}
class NewStatusBarViewController: MyBaseVC {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
	}
}
class IPadViewWithTableMainViewController: MyBaseVC {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
	}
}
class IPadViewWithTableCenterDetailViewController: MyBaseVC {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
	}
}
class IPadViewWithTableBottomDetailViewController: MyBaseVC {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}
}
