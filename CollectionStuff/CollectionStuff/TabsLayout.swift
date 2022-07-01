//
//  TabsLayout.swift
//  CollectionStuff
//
//  Created by Don Mag on 6/28/22.
//

import UIKit

class TabsLayout: NSObject {

}

class SomeView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		initViews()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initViews()
	}
	
	func initViews(){
		let containerStack = UIStackView()
		addSubview(containerStack)
		containerStack.axis = .vertical
		containerStack.distribution = .equalCentering
		containerStack.distribution = .fillEqually
		containerStack.isLayoutMarginsRelativeArrangement = true
		containerStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		
		
		let scrollView = UIScrollView()
		let scrolledStack = UIStackView()
		containerStack.addArrangedSubview(scrollView)
		scrollView.addSubview(scrolledStack)
		scrolledStack.distribution = .fill
		scrolledStack.isLayoutMarginsRelativeArrangement = true
		scrolledStack.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
		
		scrolledStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		scrolledStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		scrolledStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		scrolledStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		scrolledStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		
		
		let otherStack = UIStackView()
		containerStack.addArrangedSubview(otherStack)
		otherStack.distribution = .equalCentering
		otherStack.isLayoutMarginsRelativeArrangement = true
		otherStack.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
		
		
		containerStack.translatesAutoresizingMaskIntoConstraints = false
		containerStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
		containerStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		containerStack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		containerStack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		
		
		for number in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]{
			let text = UITextView()
			text.font = UIFont.boldSystemFont(ofSize: 14)
			text.text = number
			text.isScrollEnabled = false
			text.backgroundColor = .cyan
			
			scrolledStack.addArrangedSubview(text)
		}
		for number in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]{
			let text = UITextView()
			text.font = UIFont.boldSystemFont(ofSize: 14)
			text.text = number
			text.isScrollEnabled = false
			text.backgroundColor = .green
			
			otherStack.addArrangedSubview(text)
		}
		
		scrolledStack.translatesAutoresizingMaskIntoConstraints = false

		scrollView.backgroundColor = .red
		scrolledStack.backgroundColor = .lightGray
		otherStack.backgroundColor = .systemBlue
		containerStack.backgroundColor = .systemGreen
		
		
		
	}

}

class AnotherStackVC: UIViewController {
	
	@IBOutlet var someView: SomeView!
	
	var subView1: UIStackView!
	var container: UIStackView!
	var subView2: UIStackView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		someView.isHidden = true
		initLayout()
	}
	fileprivate func initLayout() {
		subView1 = UIStackView()
		subView1.axis = .vertical
		// same for subView2
		subView2 = UIStackView()
		subView2.axis = .vertical

		container = UIStackView()
		container.axis = .vertical
		container.distribution = .fillEqually
		view.addSubview(container!)
		
		container.translatesAutoresizingMaskIntoConstraints = false
		subView1.translatesAutoresizingMaskIntoConstraints = false
		subView2.translatesAutoresizingMaskIntoConstraints = false
		
		container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		container.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		container.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		
		container.addArrangedSubview(subView1)
		container.addArrangedSubview(subView2)
		
		container.backgroundColor = .systemBlue
		subView1.backgroundColor = .systemRed
		subView2.backgroundColor = .systemGreen
	}
	
}

class ToolTipTextView: UITextView {

	var tipView: UIView!
	var btn: UIButton!
	var seg: UISegmentedControl!

	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	func commonInit(){
		
		// we need to see the view outside our bounds
		self.clipsToBounds = false
		
		tipView = UIView()
		tipView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

		btn = UIButton()
		btn.setTitle("Tap Me", for: [])
		btn.setTitleColor(.white, for: .normal)
		btn.setTitleColor(.lightGray, for: .highlighted)
		btn.backgroundColor = .systemBlue
		
		seg = UISegmentedControl(items: ["One", "Two", "Three"])
		
		[tipView, btn, seg].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
		}

		tipView.addSubview(btn)
		tipView.addSubview(seg)
		self.addSubview(tipView)

		NSLayoutConstraint.activate([
			// button at top of tipView, centerX
			btn.topAnchor.constraint(equalTo: tipView.topAnchor, constant: 4.0),
			btn.centerXAnchor.constraint(equalTo: tipView.centerXAnchor),
			
			// seg control below button
			seg.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 4.0),
			seg.bottomAnchor.constraint(equalTo: tipView.bottomAnchor, constant: -4.0),
			seg.leadingAnchor.constraint(equalTo: tipView.leadingAnchor, constant: 4.0),
			seg.trailingAnchor.constraint(equalTo: tipView.trailingAnchor, constant: -4.0),

			// tipView above self, centerX
			tipView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -4.0),
			tipView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
		])
		
		// targets for btn and seg
		btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
		seg.addTarget(self, action: #selector(segSelected(_:)), for: .valueChanged)
		
	}
	
	@objc func btnTapped(_ sender: Any?) {
		let str = self.text ?? ""
		self.text = str + " Button Tapped! "
	}
	@objc func segSelected(_ sender: Any?) {
		guard let ctrl = sender as? UISegmentedControl,
			  let t = ctrl.titleForSegment(at: ctrl.selectedSegmentIndex)
		else { return }
		let str = self.text ?? ""
		self.text = str + " Segment \(t) Selected! "
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

		print(point)
		// convert the touch to the tipView coordinate space
		let cvtPoint = self.convert(point, to: tipView)

		if btn.frame.contains(cvtPoint) {
			return btn
		}
		
		if seg.frame.contains(cvtPoint) {
			return seg
		}

		return super.hitTest(point, with: event)

	}
	
}

class TipTestVC: UIViewController {
	
	let myView = ToolTipTextView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		myView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(myView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			myView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			myView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			myView.heightAnchor.constraint(equalToConstant: 160.0),
			myView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
		])
		
		myView.font = .systemFont(ofSize: 20.0, weight: .light)
		myView.text = "This is text in the text view."

		// so we can see the text view frame
		myView.backgroundColor = .green
		
	}
	
}

extension UIButton {
	func angledCorners() {
		let maskLayer1 = CAShapeLayer()
		maskLayer1.frame = bounds
		
		let pt1: CGPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
		let pt2: CGPoint = CGPoint(x: bounds.minX, y: bounds.midY)
		let pt3: CGPoint = CGPoint(x: bounds.minX + bounds.midY, y: bounds.minY)
		let pt4: CGPoint = CGPoint(x: bounds.maxX, y: bounds.minY)
		let pt5: CGPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
		let pt6: CGPoint = CGPoint(x: bounds.maxX - bounds.midY, y: bounds.maxY)

		let maskPath1: UIBezierPath = UIBezierPath()
		
		maskPath1.move(to: pt1)
		maskPath1.addLine(to: pt2)
		maskPath1.addLine(to: pt3)
		maskPath1.addLine(to: pt4)
		maskPath1.addLine(to: pt5)
		maskPath1.addLine(to: pt6)
		maskPath1.close()

		maskLayer1.path = maskPath1.cgPath
		layer.mask = maskLayer1
	}
}

class InputMenuVC: UIViewController {

	@IBOutlet var b1: UIButton!
	@IBOutlet var b2: UIButton!
	
	@IBAction func b1Tap(_ sender: Any) {
		let vc = InputVC()
		navigationController?.pushViewController(vc, animated: true)
	}
	@IBAction func b2Tap(_ sender: Any) {
		let vc = CVInputViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		b1.angledCorners()
		b2.angledCorners()
	}
}

class InputVC: UIViewController, UITextFieldDelegate {
	
	let stackView: UIStackView = {
		let v = UIStackView()
		v.spacing = 8
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	
	let numDigits: Int = 6
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		view.addSubview(stackView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			stackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
		])
		
		for _ in 0..<numDigits {
			let t = UITextField()
			t.borderStyle = .roundedRect
			t.textAlignment = .center
			t.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
			t.keyboardType = .numberPad
			t.addTarget(self, action: #selector(textEdited(_:)), for: .editingChanged)
			t.delegate = self
			stackView.addArrangedSubview(t)
		}
		
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// don't allow paste of more than one character
		if string.count > 1 {
			return false
		}
		// allow backspace
		if string.isEmpty {
			return true
		}
		// only allow digits
		let str = string.filter("0123456789".contains)
		if str.isEmpty {
			return false
		}
		textField.text = str
		// .editingChanged is not triggered when setting the .text property
		//	so we call it from here
		textEdited(textField)
		return false
	}
	
	@objc func textEdited(_ tf: UITextField) {
		guard let t = tf.text,
			  t.count == 1,
			  let idx = stackView.arrangedSubviews.firstIndex(of: tf)
		else { return }
		
		if idx + 1 == self.numDigits {
			tf.resignFirstResponder()
			// call the verification func
		} else {
			// get a reference to the next text field
			if let nextTF = stackView.arrangedSubviews[idx + 1] as? UITextField {
				// "activate" it
				nextTF.becomeFirstResponder()
			}
		}
	}
	
}


class SingleCharCell: UICollectionViewCell, UITextFieldDelegate {
	
	// "callback" closure
	var textChanged: ((UICollectionViewCell, String) -> ())?
	
	let textField: UITextField = {
		let t = UITextField()
		t.borderStyle = .roundedRect
		t.textAlignment = .center
		t.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
		t.keyboardType = .numberPad
		return t
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		textField.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(textField)
		
		let v = UIView()
		v.backgroundColor = .lightGray
		v.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(v)
		
		NSLayoutConstraint.activate([
			
			v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
			v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
			v.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
			v.heightAnchor.constraint(equalToConstant: 1.0),

			
			// add 4-points "padding" on label top and bottom
			textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.0),
			textField.bottomAnchor.constraint(equalTo: v.topAnchor, constant: -2.0),
			// add 8-points "padding" on label leading/trailing
			//textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
			//textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
			textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
		])

		textField.addTarget(self, action: #selector(textEdited(_:)), for: .editingChanged)
		textField.delegate = self
		
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// don't allow paste of more than one character
		if string.count > 1 {
			return false
		}
		// allow backspace
		if string.isEmpty {
			return true
		}
		// only allow digits
		let str = string.filter("0123456789".contains)
		if str.isEmpty {
			return false
		}
		textField.text = str
		// .editingChanged is not triggered when setting the .text property
		//	so we call it from here
		textEdited(textField)
		return false
	}
	
	@objc func textEdited(_ tf: UITextField) {
		guard let t = tf.text,
			  t.count == 1
		else { return }
		textChanged?(self, t)
	}
	
}

class CVInputViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	// we should never use changed properties of a cell to track user input
	//	so we'll save the entered digits in an array
	var myData: [String] = []
	
	let numDigits: Int = 6
	
	var collectionView: UICollectionView!
	var cellSize: CGSize!
	var cvWidth: CGFloat = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		// get the size of a cell to use for the
		//	flow layout itemSize as well as the
		//	collection view width and height
		let v = SingleCharCell()
		v.textField.text = "0"
		cellSize = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		cellSize.width = 40.0
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .vertical
		fl.itemSize = cellSize
		fl.minimumLineSpacing = 8
		fl.minimumInteritemSpacing = 8
		
		//let cvWidth = CGFloat(numDigits) * cellSize.width + CGFloat(numDigits - 1) * fl.minimumLineSpacing
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			
			collectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			collectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			
//			collectionView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
//			collectionView.widthAnchor.constraint(equalToConstant: cvWidth),
			
			collectionView.heightAnchor.constraint(equalToConstant: cellSize.height),
		])
		
		collectionView.register(SingleCharCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// init array to hold the entered values
		myData = Array(repeating: "", count: numDigits)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if cvWidth != collectionView.frame.width {
			cvWidth = collectionView.frame.width
			let spc: CGFloat = CGFloat((numDigits - 1) * 8)
			let cw: CGFloat = (cvWidth - spc) / CGFloat(numDigits)
			if let fl = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
				fl.itemSize.width = cw
			}
		}
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numDigits
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! SingleCharCell
		c.textField.text = myData[indexPath.item]
		
		// set the "callback" closure
		c.textChanged = { [weak self] theCell, theText in
			guard let self = self,
				  let idx = collectionView.indexPath(for: theCell),
				  let thisCell = theCell as? SingleCharCell
			else { return }
			
			// update array of entered digits
			self.myData[idx.item] = theText
			
			// if this was the last cell
			if idx.item + 1 == self.numDigits {
				// stop editing
				thisCell.textField.resignFirstResponder()
				// call the verification func
			} else {
				// get a reference to the next cell
				if let nextCell = collectionView.cellForItem(at: IndexPath(item: idx.item + 1, section: 0)) as? SingleCharCell {
					// "activate" the text field in that cell
					nextCell.textField.becomeFirstResponder()
				}
			}
		}
		return c
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		setOnVc(whereToAdd: self, text: "abc", color: .red, heightMultiplier: 1.0)
	}
	public func setOnVc(whereToAdd: UIViewController, text: String, color: UIColor?, heightMultiplier: CGFloat){

		let whatToAdd = aWarningView(colorOfGradient: color)
		//...
	}
	public func showWarningOfFutureDate1(_ vc: UIViewController){
		setOnVc(whereToAdd: vc, text: "⛔️lalala⛔️", color: .red, heightMultiplier: 0.06)
	}

}


class aSingleCharCell: UICollectionViewCell, UITextFieldDelegate {
	
	// "callback" closure
	var textChanged: ((UICollectionViewCell, String) -> ())?
	
	let textField: UITextField = {
		let t = UITextField()
		t.borderStyle = .roundedRect
		t.textAlignment = .center
		t.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
		t.keyboardType = .numberPad
		return t
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		textField.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(textField)
		
		NSLayoutConstraint.activate([
			// add 4-points "padding" on label top and bottom
			textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
			textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
			// add 8-points "padding" on label leading/trailing
			textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
			textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
		])
		
		textField.addTarget(self, action: #selector(textEdited(_:)), for: .editingChanged)
		textField.delegate = self
		
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// don't allow paste of more than one character
		if string.count > 1 {
			return false
		}
		// allow backspace
		if string.isEmpty {
			return true
		}
		// only allow digits
		let str = string.filter("0123456789".contains)
		if str.isEmpty {
			return false
		}
		textField.text = str
		// .editingChanged is not triggered when setting the .text property
		//	so we call it from here
		textEdited(textField)
		return false
	}
	
	@objc func textEdited(_ tf: UITextField) {
		guard let t = tf.text,
			  t.count == 1
		else { return }
		textChanged?(self, t)
	}
	
}

class aCVInputViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	// we should never use changed properties of a cell to track user input
	//	so we'll save the entered digits in an array
	var myData: [String] = []
	
	let numDigits: Int = 10
	
	var collectionView: UICollectionView!
	var cellSize: CGSize!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		// get the size of a cell to use for the
		//	flow layout itemSize as well as the
		//	collection view width and height
		let v = SingleCharCell()
		v.textField.text = "0"
		cellSize = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .horizontal
		fl.itemSize = cellSize
		fl.minimumLineSpacing = 8
		fl.minimumInteritemSpacing = 8
		
		let cvWidth = CGFloat(numDigits) * cellSize.width + CGFloat(numDigits - 1) * fl.minimumLineSpacing
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			collectionView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			collectionView.widthAnchor.constraint(equalToConstant: cvWidth),
			collectionView.heightAnchor.constraint(equalToConstant: cellSize.height),
		])
		
		collectionView.register(SingleCharCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// init array to hold the entered values
		myData = Array(repeating: "", count: numDigits)
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numDigits
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! SingleCharCell
		c.textField.text = myData[indexPath.item]
		
		// set the "callback" closure
		c.textChanged = { [weak self] theCell, theText in
			guard let self = self,
				  let idx = collectionView.indexPath(for: theCell),
				  let thisCell = theCell as? SingleCharCell
			else { return }
			
			// update array of entered digits
			self.myData[idx.item] = theText
			
			// if this was the last cell
			if idx.item + 1 == self.numDigits {
				// stop editing
				thisCell.textField.resignFirstResponder()
				// call the verification func
			} else {
				// get a reference to the next cell
				if let nextCell = collectionView.cellForItem(at: IndexPath(item: idx.item + 1, section: 0)) as? SingleCharCell {
					// "activate" the text field in that cell
					nextCell.textField.becomeFirstResponder()
				}
			}
		}
		return c
	}

}

class aWarningView: UIView {
	// give it a default value
	var colorOfGradient: UIColor = .blue
	
	convenience init(colorOfGradient: UIColor?) {
		self.init(frame: CGRect.zero)
		
		// unwrap optional
		if let c = colorOfGradient {
			self.colorOfGradient = c
		}
		print(self.colorOfGradient as Any)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		print(colorOfGradient as Any)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
//...

class BoxView: UIView {
	
	public var fillColor: UIColor = .red {
		didSet {
			shapeLayer.fillColor = fillColor.cgColor
		}
	}
	public var strokeColor: UIColor = .black {
		didSet {
			shapeLayer.strokeColor = strokeColor.cgColor
		}
	}

	private let shapeLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		layer.addSublayer(shapeLayer)
		shapeLayer.fillColor = fillColor.cgColor
		shapeLayer.strokeColor = strokeColor.cgColor
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		let oneThirdHeight: CGFloat = bounds.height / 3.0
		let bez: UIBezierPath = UIBezierPath()
		var pt: CGPoint = .zero
		
		pt.x = bounds.minX
		pt.y = bounds.maxY
		bez.move(to: pt)

		pt.y = bounds.maxY - oneThirdHeight
		bez.addLine(to: pt)
		
		pt.x = bounds.minX + oneThirdHeight * 2.0
		pt.y = bounds.minY
		bez.addLine(to: pt)

		pt.x = bounds.maxX
		bez.addLine(to: pt)

		pt.y = bounds.minY + oneThirdHeight
		bez.addLine(to: pt)
		
		pt.x = bounds.maxX - oneThirdHeight * 2.0
		pt.y = bounds.maxY
		bez.addLine(to: pt)
		
		bez.close()

		shapeLayer.path = bez.cgPath
	}
}

class SomeTableCell: UITableViewCell {
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var genderLabel: UILabel!
	@IBOutlet var passedOutLabel: UILabel!
	@IBOutlet var commentsLabel: UILabel!

}
class SomeTableVC: UITableViewController {

	var myData: [[String]] = []
	
	let dataSource = ContactEmailDataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let sampleComments: [String] = [
			"This is a one line comment.",
			"This comment should be long enough to wrap onto two or more lines.",
			"This comment\nHas newline breaks\nto give us\nFour lines.",
			"This comment will be long enough to word wrap, and we will add some newlines.\nLike this.\n\nAnd a double-newline to leave a blank line in the paragraph.",
		]
		
		// create some sample data
		for (i, str) in sampleComments.enumerated() {
			var strings: [String] = []
			strings.append("Name \(i)")
			strings.append("Gender \(i)")
			strings.append("Passed Out \(i)")
			strings.append(str)
			myData.append(strings)
		}
		
		print("")
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "someCell", for: indexPath) as! SomeTableCell
		let strs = myData[indexPath.row]
		c.nameLabel.text = strs[0]
		c.genderLabel.text = strs[1]
		c.passedOutLabel.text = strs[2]
		c.commentsLabel.text = strs[3]
		
		if indexPath.row < dataSource.countOfEmails() {
			let cellContact = dataSource.emailAtIndex(index: indexPath.row)
			//cell.textLabel?.text = cellContact.emailAddress
			c.nameLabel.text = cellContact.emailAddress
		}

		
		return c
	}
	
}

class ContactEmail: NSObject
{
	var emailAddress: String
	
	override init ()
	{
		emailAddress = "example@email.com"
		super.init()
	}
	
	init(emailAddress email: String)
	{
		emailAddress = email
		super.init()
	}
}

class ContactEmailDataSource: NSObject
{
	let emailAddresses = NSMutableArray()
	
	override init()
	{
		super.init()
		loadEmailAddresses()
	}
	func loadEmailAddresses()
	{
		let sample1 = ContactEmail()
		emailAddresses.add(sample1)
		let sample2 = ContactEmail(emailAddress: "example@example.com")
		addEmail(contact: sample2)
	}
	func addEmail(contact c: ContactEmail)
	{
		emailAddresses.add(c)
	}
	func countOfEmails() -> Int
	{
		return emailAddresses.count
	}
	func emailAtIndex(index i: Int) -> ContactEmail
	{
		return emailAddresses.object(at: i) as! ContactEmail
	}
}

class AddressBookTableViewController: UITableViewController {
	let dataSource = ContactEmailDataSource()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar
		//for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return dataSource.countOfEmails()
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
		
		let cellContact = dataSource.emailAtIndex(index: indexPath.row)
		cell.textLabel?.text = cellContact.emailAddress
		
		return cell
	}
	
	
	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */
	
	/*
	 // Override to support editing the table view.
	 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	 if editingStyle == .delete {
	 // Delete the row from the data source
	 tableView.deleteRows(at: [indexPath], with: .fade)
	 } else if editingStyle == .insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */
	
	/*
	 // Override to support rearranging the table view.
	 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	 
	 }
	 */
	
	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}
