//
//  ViewController.swift
//  UsingSnapKit
//
//  Created by Don Mag on 6/1/22.
//

import UIKit

class BottomPaddingViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let safeAreaView = UIView()
		safeAreaView.backgroundColor = .red
		safeAreaView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(safeAreaView)
		
		let btn = UIButton()
		btn.backgroundColor = .systemBlue
		btn.setTitle("Button", for: [])
		btn.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(btn)
		
		let g = view.safeAreaLayoutGuide
		
		// bottom constraint for the button
		//	to the safe area bottom
		//	with less-than-required priority
		let bConstraint = btn.bottomAnchor.constraint(equalTo: g.bottomAnchor)
		bConstraint.priority = .required - 1
		
		NSLayoutConstraint.activate([
			
			// constrain the red view to the safe area bottom
			safeAreaView.bottomAnchor.constraint(equalTo: g.bottomAnchor),
			safeAreaView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			safeAreaView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			safeAreaView.heightAnchor.constraint(equalToConstant: 40.0),
			
			// constrain button 200-pts wide, centered horizontally
			btn.widthAnchor.constraint(equalToConstant: 200.0),
			btn.heightAnchor.constraint(equalToConstant: 40.0),
			btn.centerXAnchor.constraint(equalTo: g.centerXAnchor),

			// and bottom AT LEAST 20-points from the bottom of the VIEW
			btn.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20.0),
			
			// activate the button's safe area bottom constraint
			bConstraint,
		])
	}
	
}

final class CanvasView: UIView {
	
	// closure to get the tool bar view frame
	var getToolbarFrame: (() ->(CGRect))?
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		
		let currentPoint = touch.location(in: self)
		print("touch began \(currentPoint)")
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		
		let currentPoint = touch.location(in: self)
		
		// unwrap the optional closure to get the toolbar view frame
		if let r = getToolbarFrame?() {
			// convert that rect to self's coordinate space
			let rr = self.superview!.convert(r, to: self)
			//	if the frame contains this touch point,
			//	return
			if rr.contains(currentPoint) {
				return
			}
		}
		
		// toobar view frame did not contain the touch, so
		//	do what you want with the moved touch
		print("touch move \(currentPoint)")
	}

}

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBlue
		
		let canvasView = CanvasView()
		canvasView.backgroundColor = .white
		view.addSubview(canvasView)
		
		canvasView.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(40)
		}
		
		let toolbarView = UIView()
		toolbarView.backgroundColor = .black.withAlphaComponent(0.7)
		view.addSubview(toolbarView)
		
		toolbarView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview().inset(80)
			make.height.equalTo(200.0)
		}
		
		// set the closure
		canvasView.getToolbarFrame = {
			return toolbarView.frame
		}
	}
	
}


enum Side {
	case top, left, right, bottom
}
class xViewController: UIViewController {

	public lazy var contentView = UIView()
	public lazy var scrollView = UIScrollView()
	
	func addScrollView(insets: UIEdgeInsets, safeAreaRelatedSides: [Side]) {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaRelatedSides.contains(where: { $0 == .top }) ? view.safeAreaLayoutGuide.snp.top : view.snp.top)
			make.left.equalTo(safeAreaRelatedSides.contains(where: { $0 == .left }) ? view.safeAreaLayoutGuide.snp.left : view.snp.left)
			make.right.equalTo(safeAreaRelatedSides.contains(where: { $0 == .right }) ? view.safeAreaLayoutGuide.snp.right : view.snp.right)
			make.bottom.equalTo(safeAreaRelatedSides.contains(where: { $0 == .bottom }) ? view.safeAreaLayoutGuide.snp.bottom : view.snp.bottom)
		}
		contentView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 300.0),
		])
//		contentView.snp.makeConstraints { make in
//			make.top.equalToSuperview().inset(insets.top)
//			make.left.equalToSuperview().inset(insets.left)
//			make.right.equalToSuperview().inset(insets.right)
//			make.bottom.equalToSuperview().inset(insets.bottom).priority(250)
//			make.centerX.equalToSuperview()
//			make.centerY.equalToSuperview().priority(250)
//		}
		scrollView.contentInsetAdjustmentBehavior = .never
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		view.backgroundColor = .lightGray
		scrollView.backgroundColor = .systemBlue
		contentView.backgroundColor = .systemYellow
		
		addScrollView(insets: .zero, safeAreaRelatedSides: [.top, .left, .right])
//		scrollView.contentInset.bottom = UIApplication.shared.safeAreaInsets.bottom
		
	}


}

