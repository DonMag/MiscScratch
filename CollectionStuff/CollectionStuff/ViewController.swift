//
//  ViewController.swift
//  CollectionStuff
//
//  Created by Don Mag on 6/26/22.
//

import UIKit

class FooterVC: UIViewController {
	
	let scrollView = UIScrollView()
	let headerStack = UIStackView()
	let footerStack = UIStackView()
	let scrollContentLabel = UILabel()
	
	var numLines: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .systemBackground
		
		// MARK: setup the header stack view with add/remove buttons
		let addButton = UIButton()
		addButton.setTitle("Add", for: [])
		addButton.setTitleColor(.white, for: .normal)
		addButton.setTitleColor(.lightGray, for: .highlighted)
		addButton.backgroundColor = .systemRed

		let removeButton = UIButton()
		removeButton.setTitle("Remove", for: [])
		removeButton.setTitleColor(.white, for: .normal)
		removeButton.setTitleColor(.lightGray, for: .highlighted)
		removeButton.backgroundColor = .systemRed
		
		headerStack.axis = .horizontal
		headerStack.alignment = .center
		headerStack.spacing = 20
		headerStack.backgroundColor = .systemYellow
		
		// a couple re-usable objects
		var vSpacer: UIView!

		vSpacer = UIView()
		vSpacer.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
		headerStack.addArrangedSubview(vSpacer)
		
		headerStack.addArrangedSubview(addButton)
		headerStack.addArrangedSubview(removeButton)

		vSpacer = UIView()
		vSpacer.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
		headerStack.addArrangedSubview(vSpacer)

		// MARK: setup the footer stack view
		footerStack.axis = .vertical
		footerStack.spacing = 8
		footerStack.backgroundColor = .systemGreen

		["Footer Stack View", "with Two Labels"].forEach { str in
			let vLabel = UILabel()
			vLabel.text = str
			vLabel.textAlignment = .center
			vLabel.font = .systemFont(ofSize: 24.0, weight: .regular)
			vLabel.textColor = .yellow
			footerStack.addArrangedSubview(vLabel)
		}
		
		// MARK: setup scroll content
		scrollContentLabel.font = .systemFont(ofSize: 44.0, weight: .light)
		scrollContentLabel.numberOfLines = 0
		scrollContentLabel.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

		// so we can see the scroll view
		scrollView.backgroundColor = .systemBlue
		
		[scrollContentLabel, footerStack].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
			scrollView.addSubview(v)
		}
		[headerStack, scrollView].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(v)
		}

		let g = view.safeAreaLayoutGuide
		let cg = scrollView.contentLayoutGuide
		let fg = scrollView.frameLayoutGuide
		
		NSLayoutConstraint.activate([
			
			// header stack at top of view
			headerStack.topAnchor.constraint(equalTo: g.topAnchor),
			headerStack.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			headerStack.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			headerStack.heightAnchor.constraint(equalToConstant: 72.0),
			// make buttons equal widths
			addButton.widthAnchor.constraint(equalTo: removeButton.widthAnchor),
			
			// scroll view Top to header stack Bottom
			scrollView.topAnchor.constraint(equalTo: headerStack.bottomAnchor),
			// other 3 sides
			scrollView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: g.bottomAnchor),
			
			// scroll content...
			// let's inset the content label 12-points on each side
			//	to make it easier to see the framing
			scrollContentLabel.leadingAnchor.constraint(equalTo: cg.leadingAnchor, constant: 12.0),
			scrollContentLabel.trailingAnchor.constraint(equalTo: cg.trailingAnchor, constant: -12.0),
			scrollContentLabel.widthAnchor.constraint(equalTo: fg.widthAnchor, constant: -24.0),
			// top and bottom to content layout guide
			scrollContentLabel.topAnchor.constraint(equalTo: cg.topAnchor, constant: 0.0),
			scrollContentLabel.bottomAnchor.constraint(equalTo: cg.bottomAnchor, constant: 0.0),

			// footer stack view - leading/trailing to frame layout guide
			footerStack.leadingAnchor.constraint(equalTo: fg.leadingAnchor),
			footerStack.trailingAnchor.constraint(equalTo: fg.trailingAnchor),

		])
		
		var tmpConstraint: NSLayoutConstraint!
		
		// now, we want the footer to stick to the bottom of the content,
		//	but allow auto-layout to break the constraint when needed
		
		tmpConstraint = footerStack.topAnchor.constraint(equalTo: scrollContentLabel.bottomAnchor)
		tmpConstraint.priority = .defaultLow
		tmpConstraint.isActive = true
		
		// and we want the footer to stop at the bottom of the scroll view frame
		//	default is .required, but we'll set it here for emphasis
		tmpConstraint = footerStack.bottomAnchor.constraint(lessThanOrEqualTo: fg.bottomAnchor)
		tmpConstraint.priority = .required
		tmpConstraint.isActive = true

		// actions for the buttons
		addButton.addTarget(self, action: #selector(addContent(_:)), for: .touchUpInside)
		removeButton.addTarget(self, action: #selector(removeContent(_:)), for: .touchUpInside)
		
		// add the first line to the content
		addContent(nil)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		// we need to set the bottom inset of the scroll view content
		//	so it can scroll up above the footer stack view
		let h: CGFloat = footerStack.frame.height
		scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: h, right: 0)
	}
	
	@objc func addContent(_ sender: Any?) {
		// add another line of text to the content
		numLines += 1
		scrollContentLabel.text = (1...numLines).map({"Line \($0)"}).joined(separator: "\n")

		// scroll newly added line into view
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
			let r = CGRect(x: 0, y: self.scrollView.contentSize.height - 1.0, width: 1.0, height: 1.0)
			self.scrollView.scrollRectToVisible(r, animated: true)
		})
	}
	@objc func removeContent(_ sender: Any?) {
		numLines -= 1
		numLines = max(1, numLines)
		scrollContentLabel.text = (1...numLines).map({"Line \($0)"}).joined(separator: "\n")
	}

}

class ScrollFooterVC: UIViewController {

	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var scLabel: UILabel!
	@IBOutlet var svFooter: UILabel!
	
	var n: Int = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		scLabel.text = "Line 1"
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let h = svFooter.frame.height
		scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: h, right: 0)
	}
	func addLine() {
		n += 1
		guard let t = scLabel.text else {
			scLabel.text = "Line 1"
			return
		}
		scLabel.text = t + "\nAnother Line \(n)"
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
			let r = CGRect(x: 0, y: self.scrollView.contentSize.height - 1.0, width: 10, height: 1.0)
			self.scrollView.scrollRectToVisible(r, animated: true)
		})
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		print("t")
		addLine()
	}
	
}

class WarningView: UIView {
	deinit {
		print("WV deinit")
	}
}
class TestAnimVC: UIViewController {

	let warningView = WarningView()
	var warningViewTopConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		warningView.translatesAutoresizingMaskIntoConstraints = false
		warningView.backgroundColor = .systemRed
		view.addSubview(warningView)
		let g = view.safeAreaLayoutGuide
		view.addSubview(warningView)
		warningViewTopConstraint = warningView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0)
		NSLayoutConstraint.activate([
			warningView.widthAnchor.constraint(equalToConstant: 240.0),
			warningView.heightAnchor.constraint(equalToConstant: 120.0),
			warningView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			warningViewTopConstraint,
		])

	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		showWarningView()
	}
	private func showWarningView() {
		
		DispatchQueue.main.async { [weak self] in
			
			guard let strongSelf = self else { return }
			
			var newConstant: CGFloat!
			
			if strongSelf.warningViewTopConstraint.constant == 0.0 {
				newConstant = 100.0
			} else {
				newConstant = 0.0
			}
			
			strongSelf.warningViewTopConstraint.constant = newConstant
			
			UIView.animate(withDuration: 4.25, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
				guard let self = self else { return }
				self.view.layoutIfNeeded()
			}, completion: nil)
			
		}
		
	}
	deinit {
		print("VC deinit")
	}
}

class stViewController: UIViewController {

	var myData: [String] = [
		//		"1", "2", "3",
		//		"1", "2", "3",
		//		"1", "2", "3",
		//		"1", "2", "3",
		//		"One", "Two", "Three",
		//		"Monday", "Tuesday", "Wednesday",
		//		"January", "February", "March",
		//		"A", "B", "Some Words",
		//		"Longer First Row", "Short", "Medium Bottom",
		"Dead Battery", "Screeching Noises", "Broken Windshield",
		"Saggy Clutch", "Dashboard Lights", "Hard Steering",
		"Low Mileage", "Dim Lights", "Low AC Cooling",
		"Rattling Sound", "Heat Not Working", "Pulls Left",
		"X", "Won't work",
	]
	
	var numRows: Int = 3

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let scrollView = UIScrollView()
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .top
		stackView.spacing = 8
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		scrollView.addSubview(stackView)
		view.addSubview(scrollView)
		
		let g = view.safeAreaLayoutGuide
		let cg = scrollView.contentLayoutGuide
		let fg = scrollView.frameLayoutGuide
		
		NSLayoutConstraint.activate([

			scrollView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			scrollView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			scrollView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			scrollView.heightAnchor.constraint(equalToConstant: 120.0),

			stackView.topAnchor.constraint(equalTo: cg.topAnchor, constant: 8.0),
			stackView.leadingAnchor.constraint(equalTo: cg.leadingAnchor, constant: 12.0),
			stackView.trailingAnchor.constraint(equalTo: cg.trailingAnchor, constant: -12.0),
			stackView.bottomAnchor.constraint(equalTo: cg.bottomAnchor, constant: 0.0),

		])

		var columnStack: UIStackView!
		for (i, s) in myData.enumerated() {
			if i % numRows == 0 {
				columnStack = UIStackView()
				columnStack.axis = .vertical
				//columnStack.distribution = .equalSpacing
				columnStack.alignment = .center
				columnStack.spacing = 8.0
				stackView.addArrangedSubview(columnStack)
			}
			let v = OneLabelView()
			v.label.text = s
			columnStack.addArrangedSubview(v)
		}
		if myData.count % numRows != 0 {
//			columnWidths.append(mxW)
		}

		// so we can see the collection view frame
		scrollView.backgroundColor = UIColor(red: 0.999, green: 0.976, blue: 0.972, alpha: 1.0)

		
	}
}

class OneLabelView: UIView {
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		backgroundColor = .white
		layer.borderColor = UIColor.red.cgColor
		layer.borderWidth = 1
		layer.cornerRadius = 4
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12.0, weight: .bold)
		label.textAlignment = .center
		label.backgroundColor = .clear
		label.setContentHuggingPriority(.required, for: .horizontal)
		label.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		addSubview(label)
		
		let g = self
		let vPadding: CGFloat = 4
		let hPadding: CGFloat = 12
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: g.topAnchor, constant: vPadding),
			label.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -vPadding),
			label.leadingAnchor.constraint(greaterThanOrEqualTo: g.leadingAnchor, constant: hPadding),
			label.trailingAnchor.constraint(lessThanOrEqualTo: g.trailingAnchor, constant: -hPadding),
			label.centerXAnchor.constraint(equalTo: g.centerXAnchor),
		])
		backgroundColor = .yellow
	}
}


class xOneLabelView: UIView {
	let borderView = UIView()
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		borderView.translatesAutoresizingMaskIntoConstraints = false
		borderView.backgroundColor = .white
		borderView.layer.borderColor = UIColor.red.cgColor
		borderView.layer.borderWidth = 1
		borderView.layer.cornerRadius = 4
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12.0, weight: .bold)
		label.textAlignment = .center
		label.backgroundColor = .clear
		label.setContentHuggingPriority(.required, for: .horizontal)
		label.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		borderView.addSubview(label)
		addSubview(borderView)

		let g = self
		
		let lc = borderView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 16.0)
		let tc = borderView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -16.0)
		lc.priority = .required - 1
		tc.priority = .required - 1
		
		NSLayoutConstraint.activate([
			//label.topAnchor.constraint(equalTo: g.topAnchor, constant: 16.0),
			//label.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 16.0),
			label.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			label.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			//label.widthAnchor.constraint(greaterThanOrEqualToConstant: 44.0),
			lc, tc,
			
			borderView.topAnchor.constraint(equalTo: g.topAnchor, constant: 8.0),
			borderView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -8.0),
			borderView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			borderView.centerXAnchor.constraint(equalTo: g.centerXAnchor),

		])
		backgroundColor = .yellow
	}
}

class onViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var myData: [String] = [
		"1", "2", "3",
		"One", "Two", "Three",
		"Monday", "Tuesday", "Wednesday",
		"January", "February", "March",
		"Dead Battery", "Screeching Noises",  "Broken Windshield",
//		"Saggy Clutch", "Dashboard Lights", "Hard Steering",
//		"Low Mileage", "Dim Lights", "Low AC Cooling",
//		"Rattling Sound", "Heat Not Working", //"Pulls Left",
	]

	let numRows: Int = 3
	let lineSpacing: CGFloat = 16
	let itemSpacing: CGFloat = 4
	let vPadding: CGFloat = 8
	
	var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let v = OneLabelCell()
		v.text = "A"
		let sz = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		let h = sz.height * CGFloat(numRows) + itemSpacing * CGFloat(numRows - 1) + vPadding * 2.0
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .horizontal
		fl.estimatedItemSize = CGSize(width: 220.0, height: 33.0)
		fl.minimumLineSpacing = lineSpacing
		fl.minimumInteritemSpacing = itemSpacing
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			collectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			collectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			collectionView.heightAnchor.constraint(equalToConstant: h),
		])
		
		collectionView.backgroundColor = UIColor(red: 0.999, green: 0.976, blue: 0.972, alpha: 1.0)
		
		collectionView.register(OneLabelCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Int(ceil(Double(myData.count) / Double(numRows))) * numRows
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! OneLabelCell
		c.text = indexPath.item < myData.count ? myData[indexPath.item] : ""
		return c
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//		let numCols: Int = (myData.count + (myData.count % numRows)) / numRows
//		let contentWidth: CGFloat = collectionView.contentSize.width
//		let r: CGFloat = 1
		
		let numCols = collectionView.numberOfItems(inSection: 0) / numRows
		let n = CGFloat(numCols - 1)
		let r = n * lineSpacing
		print(r)
		return UIEdgeInsets(top: vPadding, left: 0, bottom: vPadding, right: r - 28)
//		return UIEdgeInsets(top: vPadding, left: 12, bottom: vPadding, right: 16 + 12)
//		return UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 24)
	}
}

class OneLabelCell: UICollectionViewCell {
	public var text: String = "" {
		didSet {
			label.text = text.isEmpty ? " " : text
			contentView.backgroundColor = text.isEmpty ? .clear : .white
			contentView.layer.borderWidth = text.isEmpty ? 0 : 1
		}
	}
	
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		// round-corner-outline
		contentView.backgroundColor = .white
		contentView.layer.borderColor = UIColor.red.cgColor
		contentView.layer.borderWidth = 1
		contentView.layer.cornerRadius = 4
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12.0, weight: .bold)
		label.textAlignment = .center
		
		contentView.addSubview(label)
		
		NSLayoutConstraint.activate([
			// add 4-points "padding" on label top and bottom
			label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0),
			// add 8-points "padding" on label leading/trailing
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
		])
		
	}
}


class bOneLabelCell: UICollectionViewCell {
	
	public var text: String = "" {
		didSet {
			label.text = text.isEmpty ? " " : text
			borderView.backgroundColor = text.isEmpty ? .clear : .white
			borderView.layer.borderWidth = text.isEmpty ? 0 : 1
		}
	}
	public var vPadding: CGFloat = 0 {
		didSet {
			topC.constant = vPadding * 0.5
			bottomC.constant = -vPadding * 0.5
		}
	}
	public var hPadding: CGFloat = 0 {
		didSet {
			leadingC.constant = hPadding * 0.5
			trailingC.constant = -hPadding * 0.5
		}
	}

	private let borderView = UIView()
	private let label = UILabel()
	
	private var leadingC: NSLayoutConstraint!
	private var trailingC: NSLayoutConstraint!
	private var topC: NSLayoutConstraint!
	private var bottomC: NSLayoutConstraint!

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		borderView.translatesAutoresizingMaskIntoConstraints = false
		borderView.backgroundColor = .white
		borderView.layer.borderColor = UIColor.red.cgColor
		borderView.layer.borderWidth = 1
		borderView.layer.cornerRadius = 4
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12.0, weight: .bold)
		label.textAlignment = .center
		label.backgroundColor = .clear
		label.setContentHuggingPriority(.required, for: .horizontal)
		label.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		borderView.addSubview(label)
		contentView.addSubview(borderView)
		
		let g = contentView
		
		leadingC = borderView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: hPadding)
		trailingC = borderView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -hPadding)
		topC = borderView.topAnchor.constraint(equalTo: g.topAnchor, constant: vPadding)
		bottomC = borderView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -vPadding)
		
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 4.0),
			label.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -4.0),
			label.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 8.0),
			label.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -8.0),
			
			topC, bottomC, leadingC, trailingC,
		])
		
		//contentView.layer.borderColor = UIColor.green.cgColor
		//contentView.layer.borderWidth = 1

	}
}


class aOneLabelCell: UICollectionViewCell {
	let borderView = UIView()
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		borderView.translatesAutoresizingMaskIntoConstraints = false
		borderView.backgroundColor = .white
		borderView.layer.borderColor = UIColor.red.cgColor
		borderView.layer.borderWidth = 1
		borderView.layer.cornerRadius = 4
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12.0, weight: .bold)
		label.textAlignment = .center
		label.backgroundColor = .clear
		label.setContentHuggingPriority(.required, for: .horizontal)
		label.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		contentView.addSubview(borderView)
		contentView.addSubview(label)

		let g = contentView.layoutMarginsGuide
		
		let lc = label.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 8.0)
		let tc = label.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -8.0)
		lc.priority = .required - 1
		tc.priority = .required - 1
		
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
			label.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -0.0),
			label.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			lc, tc,
			
			borderView.topAnchor.constraint(equalTo: label.topAnchor, constant: -4.0),
			borderView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8.0),
			borderView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8.0),
			borderView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 4.0),

		])

		contentView.layer.borderColor = UIColor.green.cgColor
		contentView.layer.borderWidth = 1
	}
}


class auViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var myData: [String] = [
		//		"1", "2", "3",
		//		"1", "2", "3",
		//		"1", "2", "3",
		"1", "2", "3",
		"One", "Two", "Three",
		"Monday", "Tuesday", "Wednesday",
		"January", "February", "March",
		"A", "B", "Some Words",
		"Longer First Row", "Short", "Medium Bottom",
		"Dead Battery", "Screeching Noises", "Broken Windshield",
		"Saggy Clutch", "Dashboard Lights", "Hard Steering",
		"Low Mileage", "Dim Lights", "Low AC Cooling",
		"Rattling Sound", "Heat Not Working", "Pulls Left",
		"X", "Won't work",
	]
	var collectionView: UICollectionView!
	var columnWidths: [CGFloat] = []
	var numRows: Int = 3
	var cellHeight: CGFloat = 0
	var cvHeight: CGFloat = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .horizontal
		fl.estimatedItemSize = CGSize(width: 120.0, height: 40.0)
		//fl.itemSize = CGSize(width: 120.0, height: 40.0)
		fl.minimumLineSpacing = 0
		fl.minimumInteritemSpacing = 0
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			collectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			collectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			collectionView.heightAnchor.constraint(equalToConstant: 120.0),
		])
		
		// so we can see the collection view frame
		collectionView.backgroundColor = UIColor(red: 0.999, green: 0.976, blue: 0.972, alpha: 1.0)
		
		collectionView.register(OneLabelCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		let v = OneLabelCell()
		var mxW: CGFloat = 0.0
		for (i, s) in myData.enumerated() {
			v.text = s
			let sz = v.systemLayoutSizeFitting(CGSize(width: .greatestFiniteMagnitude, height: 40.0), withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required)
			mxW = max(mxW, sz.width)
			if i % numRows == numRows - 1 {
				columnWidths.append(mxW)
				mxW = 0
			}
		}
		if myData.count % numRows != 0 {
			columnWidths.append(mxW)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if cvHeight != collectionView.frame.height {
			cvHeight = collectionView.frame.height
			cellHeight = floor(cvHeight / CGFloat(numRows))
		}
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return myData.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! OneLabelCell
		c.text = myData[indexPath.item]
		return c
	}
	//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
	//		return CGSize(width: columnWidths[indexPath.item / numRows], height: cellHeight)
	//	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(columnWidths)
	}
}

class bViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var myData: [String] = [
//		"1", "2", "3",
//		"One", "Two", "Three",
//		"Monday", "Tuesday", "Wednesday",
//		"January", "February", "March",
		"Dead Battery", "Screeching Noises", "Broken Windshield",
		"Saggy Clutch", "Dashboard Lights", "Hard Steering",
		"Low Mileage", "Dim Lights", "Low AC Cooling",
		"Rattling Sound", "Heat Not Working", //"Pulls Left",
	]
	
	let numRows: Int = 3
	
	let lineSpacing: CGFloat = 8
	let itemSpacing: CGFloat = 16
	
	let vPadding: CGFloat = 5
	
	var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let v = bOneLabelCell()
		v.vPadding = lineSpacing
		v.hPadding = itemSpacing
		v.text = "A"
		let sz = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		//let h = sz.height * CGFloat(numRows) + lineSpacing * CGFloat(numRows - 1) + vPadding * 2.0
		let h = sz.height * CGFloat(numRows) + vPadding * 2.0

		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .horizontal
		fl.estimatedItemSize = CGSize(width: 220.0, height: 33.0)
		fl.minimumLineSpacing = 0
		fl.minimumInteritemSpacing = 0
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			collectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			collectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			collectionView.heightAnchor.constraint(equalToConstant: h),
		])
		
		collectionView.backgroundColor = UIColor(red: 0.999, green: 0.976, blue: 0.972, alpha: 1.0)
		
		collectionView.register(bOneLabelCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return myData.count
		//return Int(ceil(Double(myData.count) / Double(numRows))) * numRows
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! bOneLabelCell
		c.text = indexPath.item < myData.count ? myData[indexPath.item] : ""
		c.vPadding = lineSpacing
		c.hPadding = itemSpacing
		return c
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		//		let numCols: Int = (myData.count + (myData.count % numRows)) / numRows
		//		let contentWidth: CGFloat = collectionView.contentSize.width
		//		let r: CGFloat = 1
		
		let numCols = collectionView.numberOfItems(inSection: 0) / numRows
		let n = CGFloat(numCols - 1)
		let r = n * lineSpacing
		print(r)
		//return UIEdgeInsets(top: vPadding, left: 0, bottom: vPadding, right: r - 28)
		//		return UIEdgeInsets(top: vPadding, left: 12, bottom: vPadding, right: 16 + 12)
		return UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
	}
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var myData: [String] = [
		//		"1", "2", "3",
		//		"One", "Two", "Three",
		//		"Monday", "Tuesday", "Wednesday",
		//		"January", "February", "March",
		"Dead Battery", "Screeching Noises", "Broken Windshield",
		"Saggy Clutch", "Dashboard Lights", "Hard Steering",
		"Low Mileage", "Dim Lights", "Low AC Cooling",
		"Rattling Sound", "Heat Not Working", //"Pulls Left",
	]
	
	let numRows: Int = 3
	
	var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let v = SimpleOneLabelCell()
		v.label.text = "A"
		let sz = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		//let h = sz.height * CGFloat(numRows) + lineSpacing * CGFloat(numRows - 1) + vPadding * 2.0
		let h = sz.height * CGFloat(numRows)
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .horizontal
		fl.estimatedItemSize = CGSize(width: 120.0, height: 33.0)
		fl.minimumLineSpacing = 0
		fl.minimumInteritemSpacing = 0
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			collectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			collectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			collectionView.heightAnchor.constraint(equalToConstant: h),
		])
		
		collectionView.backgroundColor = UIColor(red: 0.999, green: 0.976, blue: 0.972, alpha: 1.0)
		
		collectionView.register(SimpleOneLabelCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return myData.count
		//return Int(ceil(Double(myData.count) / Double(numRows))) * numRows
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! SimpleOneLabelCell
		c.label.text = indexPath.item < myData.count ? myData[indexPath.item] : ""
		return c
	}

}


class SimpleOneLabelCell: UICollectionViewCell {

	let borderView = UIView()
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		borderView.translatesAutoresizingMaskIntoConstraints = false
		borderView.backgroundColor = .white
		borderView.layer.borderColor = UIColor.red.cgColor
		borderView.layer.borderWidth = 1
		borderView.layer.cornerRadius = 4
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12.0, weight: .regular)
		label.textAlignment = .center
		label.backgroundColor = .clear
		label.setContentHuggingPriority(.required, for: .horizontal)
		label.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		contentView.addSubview(borderView)
		contentView.addSubview(label)

		let g = contentView
		
		NSLayoutConstraint.activate([
			
			label.topAnchor.constraint(equalTo: g.topAnchor, constant: 8.0),
			label.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -8.0),
			label.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			label.leadingAnchor.constraint(greaterThanOrEqualTo: g.leadingAnchor, constant: 16.0),
			label.trailingAnchor.constraint(lessThanOrEqualTo: g.trailingAnchor, constant: -16.0),
			
			borderView.topAnchor.constraint(equalTo: label.topAnchor, constant: -4.0),
			borderView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8.0),
			borderView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8.0),
			borderView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 4.0),
			
		])
		
	}
}
