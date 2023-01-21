//
//  CoreTextField.swift
//  Aldar-Entertainer
//
//  Created by Muhammad Usman on 18/04/22.
//
import UIKit

class CoreTextField: UITextField, UITextFieldDelegate {
    
    //MARK: - Properties
    @IBInspectable var fontFamily: Int = 0 {
        didSet {
            setFont()
        }
    }
    @IBInspectable var fontSize: CGFloat = 15 {
        didSet {
            setFont()
        }
    }
    @IBInspectable var fieldBorderColor: UIColor = .lightGray {
        didSet {
            setupBorder()
        }
    }
    @IBInspectable var localizePlaceholderKey: String = "" {
        didSet {
            placeholder = localizePlaceholderKey.localized
        }
    }
    @IBInspectable var localizeTextKey: String = "" {
        didSet {
            
        }
    }
    @IBInspectable var leftImage: UIImage? = nil {
        didSet {
            setupLeftImage()
        }
    }
    @IBInspectable var placehoderColor: UIColor = .lightGray {
        didSet {
            changePlaceholderTextColor()
        }
    }
    @IBInspectable var rightImage: UIImage? = nil {
        didSet {
            setupRightImage()
        }
    }
    @IBInspectable var leftRightImageWidth: CGFloat = 44 {
        didSet {
            rightView?.frame = CGRect(x: 0, y: 0, width: leftRightImageWidth, height: frame.size.height)
            leftView?.frame = CGRect(x: 0, y: 0, width: leftRightImageWidth, height: frame.size.height)
        }
    }
    
    @IBInspectable var skyFloating: Bool = true {
        didSet {
            commonInit()
        }
    }
    
    @IBInspectable var doneButtonTitle: String = "Done"
    @IBInspectable var doShowBorder: Bool = true {
        didSet {
            setupBorder()
        }
    }
    
    static let defaultRightPadding: CGFloat = 10
    static let defaultLeftPadding: CGFloat = 10
    private var initialPadding = UIEdgeInsets(top: 0, left: CoreTextField.defaultLeftPadding, bottom: 0, right: CoreTextField.defaultRightPadding)
    var padding = UIEdgeInsets(top: 0, left: CoreTextField.defaultLeftPadding, bottom: 0, right: CoreTextField.defaultRightPadding)
    var blockForShouldReturn: (()->Bool)?
    var blockForEndEditting: ENTALDVoidCompletion?
    var blockForShouldBeginEditing: (()->Bool)?
    var blockForShouldChangeCharacters: ((_ range: NSRange, _ replacementString: String)->Bool)?
    var blockForTextChange: ((_ newText: String)->Void)? {
        didSet {
            if blockForTextChange != nil {
                addTarget(self, action: #selector(textFieldEditingChange(_:)), for: .editingChanged)
            }
        }
    }
    var blockForRightViewTouch: ENTALDVoidCompletion? {
        didSet {
            if blockForRightViewTouch != nil && rightView != nil {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRightViewTouch(_:)))
                rightView?.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    //MARK: - Setup Methods
    func commonInit() {
        setupBorder()
        changePlaceholderTextColor()
        delegate = self
        enablesReturnKeyAutomatically = true
    }
    
    private func setFont () {
    }
    
    private func changePlaceholderTextColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: placehoderColor])
    }
    
    private func setupLeftImage() {
        if let img = self.leftImage {
            padding = initialPadding
            leftView = getViewWithImageView(img: img)
            leftViewMode = .always
            updatePadding()
        } else {
            leftViewMode = .always
        }
    }
    
    private func setupRightImage() {
        if let img = self.rightImage {
            padding = initialPadding
            rightView = getViewWithImageView(img: img)
            rightViewMode = .always
            updatePadding()
        } else {
            rightViewMode = .never
        }
    }
    
    private func getViewWithImageView(img: UIImage) -> UIView {
        let rightVw = UIView(frame: CGRect(x: 0, y: 0, width: leftRightImageWidth, height: frame.size.height))
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
        rightVw.addSubview(imgView)
        rightVw.addConstraintsWithFormat("H:|-\(padding.left)-[v0]-\(padding.right)-|", views: imgView)
        rightVw.addConstraintsWithFormat("V:|-6-[v0]-6-|", views: imgView)
        return rightVw
    }
    
    private func updatePadding() {
        if let rightVw = rightView {
            padding.right = rightVw.frame.size.width
        } else {
            padding.right = CoreTextField.defaultRightPadding
        }
        
        if let rightVw = leftView {
            padding.left = rightVw.frame.size.width
        } else {
            padding.left = CoreTextField.defaultLeftPadding
        }
    }
    
    private func setupBorder() {
        layer.borderWidth = doShowBorder ? 1 : 0
        layer.cornerRadius = 10
        layer.borderColor = fieldBorderColor.cgColor
    }
    
    @objc func textFieldEditingChange(_ sender: UITextField) {
        blockForTextChange?(sender.text!)
    }
    
    func bind(callback :@escaping (String) -> ()) {
        self.blockForTextChange = callback
    }
    
    //MARK: - UITextFieldDelegate Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let returnBlock = blockForShouldBeginEditing {
            return returnBlock()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let returnBlock = blockForShouldReturn {
            return returnBlock()
        }
        self.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let returnBlock = blockForEndEditting {
            return returnBlock()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return blockForShouldChangeCharacters?((range), string) ?? true
    }
    
    // MARK: - Handle Gestures
    @objc private func handleRightViewTouch(_ sender: UITapGestureRecognizer) {
        blockForRightViewTouch?()
    }
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        commonInit()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
}



public class CoreTextView: UITextView {
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    private let placeholderLabel: UILabel = UILabel()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    @IBInspectable public var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = CoreTextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override public var font: UIFont! {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    override public var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override public var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override public var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override public var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
                                                            options: [],
                                                            metrics: nil,
                                                            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
                                                         options: [],
                                                         metrics: nil,
                                                         views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    @objc private func textDidChange() {
        invalidateIntrinsicContentSize()
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidChangeNotification,
                                                  object: nil)
    }
    
    var maxHeight: CGFloat = 0.0
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        
        if size.height == UIView.noIntrinsicMetric {
            // force layout
            layoutManager.glyphRange(for: textContainer)
            size.height = layoutManager.usedRect(for: textContainer).height + textContainerInset.top + textContainerInset.bottom
        }
        
        if maxHeight > 0.0 && size.height > maxHeight {
            size.height = maxHeight
            
            if !isScrollEnabled {
                isScrollEnabled = true
            }
        } else if isScrollEnabled {
            isScrollEnabled = false
        }
        
        return size
    }
}
