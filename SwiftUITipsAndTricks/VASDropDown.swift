//
//  VASDropDown.swift
//  VAS
//
//  Created by Robert Andrzejczyk on 14/02/2024.
//

import UIKit

class VASDropDown: UIView {
    
    weak var delegate: VASDropDownDelegate?
    weak var anchorView: UIView?
    private var showDropDownAnimator: UIViewPropertyAnimator?
    private var showDropDownDelayTimer: Timer?
    private var isKeyboardVisible = false
    private var keyboardFrame = CGRect.zero
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubview(dismissableView)
        addSubview(tableViewContainer)
        tableViewContainer.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dismissableView: UIView = {
        let view = DropDownDismissingView { [weak self] _, _ in
            self?.hide()
            return UIWindow.current
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var tableViewContainer: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 0
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.autoresizingMask = []
        view.frame = .zero
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        view.layer.cornerRadius = 0
        view.separatorStyle = .singleLine
        return view
    }()
    
    private func isCurrentAnchorView(_ anchorView: UIView) -> Bool {
        guard let currentAnchorView = self.anchorView else { return false }
        return currentAnchorView === anchorView
    }
    
    func show(nextTo anchorView: UIView) {
        let animate = !isAddedToViewHierarchy
        let delayOfShowAnimation = isCurrentAnchorView(anchorView) ? 0.0 : 0.5
        
        if !isCurrentAnchorView(anchorView) {
            hide()
            self.anchorView = anchorView
        }
        if !isAddedToViewHierarchy {
            addToViewHierarchyAndLayout()
        }
        showDropDown(animate: animate, delay: delayOfShowAnimation)
    }
    
    func hide() {
        showDropDownDelayTimer?.invalidate()
        showDropDownDelayTimer = nil
        showDropDownAnimator?.stopAnimation(true)
        showDropDownAnimator = nil
        dropDownFrame = .zero
        self.anchorView = nil
        removeFromViewHierarchy()
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        tableView.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    private var isAddedToViewHierarchy: Bool {
        superview != nil
    }
    
    private func addToViewHierarchyAndLayout() {
        guard let window = UIWindow.current else { return }
        window.addSubview(self)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        frame = window.bounds
        window.bringSubviewToFront(self)
        dismissableView.frame = bounds
    }
    
    private var dropDownFrame: CGRect {
        get {
            tableViewContainer.frame
        }
        set {
            tableViewContainer.frame = newValue
            tableView.frame = tableViewContainer.bounds
        }
    }
    
    private func removeFromViewHierarchy() {
        removeFromSuperview()
    }
    
    private func showDropDown(animate: Bool, delay: TimeInterval) {
        guard let anchorView else { return }
        let dropDownLayout = calculateDropDownLayout()
        prepareTableView(offscreenHeight: dropDownLayout.offscreenHeight)
        layoutDropDown(using: dropDownLayout)
        
        func calculateDropDownLayout() -> DropDownLayout {
            tableView.reloadData()
            return DropDownLayoutCalculator.calculateDropDownLayout(
                desirableContainerHeight: calculateDesirableContainerHeight(),
                anchorViewFrame: anchorView.convert(anchorView.bounds, to: self),
                minYOfDropDown: minYOfDropDown,
                maxYOfDropDown: maxYOfDropDown)
        }
        
        func prepareTableView(offscreenHeight: CGFloat) {
            tableView.isScrollEnabled = offscreenHeight > 0.0
        }
        
        func layoutDropDown(using layout: DropDownLayout) {
            
            showDropDownAnimator?.stopAnimation(true)
            showDropDownAnimator = nil
            if animate {
                if dropDownFrame == .zero {
                    dropDownFrame = layout.initialFrame
                }
                showDropDownAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) { [weak self] in
                    self?.dropDownFrame = layout.finalFrame
                }
                showDropDownAnimator?.startAnimation(afterDelay: delay)
            } else {
                dropDownFrame = layout.finalFrame
            }
        }
    }
    
    private func calculateDesirableContainerHeight() -> CGFloat {
        tableView.sizeThatFits(bounds.size).height
    }
    
    private var verticalMargin: CGFloat {
        return 50.0
    }
    
    private var minYOfDropDown: CGFloat {
        return verticalMargin
    }
    
    private var maxYOfDropDown: CGFloat {
        if isKeyboardVisible {
            return keyboardFrame.minY - verticalMargin
        } else {
            return self.bounds.maxY - verticalMargin
        }
    }
    
    final class DropDownDismissingView: UIView {
        
        private let pointCallback: (CGPoint, UIEvent?) -> UIView?
        
        init(pointCallback: @escaping (CGPoint, UIEvent?) -> UIView?) {
            self.pointCallback = pointCallback
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            pointCallback(point, event)
        }
    }
}

// MARK: - Properties

extension VASDropDown {
    
    var cornerRadius: CGFloat {
        get {
            tableViewContainer.layer.cornerRadius
        }
        set {
            tableViewContainer.layer.cornerRadius = newValue
            tableView.layer.cornerRadius = newValue
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            tableViewContainer.layer.shadowRadius
        }
        set {
            tableViewContainer.layer.shadowRadius = newValue
        }
    }
    
    var shadowOffset: CGSize {
        get {
            tableViewContainer.layer.shadowOffset
        }
        set {
            tableViewContainer.layer.shadowOffset = newValue
        }
    }
    
    var shadowColor: CGColor? {
        get {
            tableViewContainer.layer.shadowColor
        }
        set {
            tableViewContainer.layer.shadowColor = newValue
        }
    }
    
    var shadowOpacity: Float {
        get {
            tableViewContainer.layer.shadowOpacity
        }
        set {
            tableViewContainer.layer.shadowOpacity = newValue
        }
    }
    
    var separatorStyle: UITableViewCell.SeparatorStyle {
        get {
            tableView.separatorStyle
        }
        set {
            tableView.separatorStyle = newValue
        }
    }
}

// MARK: - UITableViewDelegate

extension VASDropDown: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        delegate?.dropDown(self, heightForRowAt: indexPath) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dropDown(self, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        hide()
    }
}

// MARK: - UITableViewDataSource

extension VASDropDown: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        delegate?.dropDown(self, cellForRowAt: indexPath) ?? UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfRows(in: self) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        delegate?.dropDown(self, canEditRowAt: indexPath) ?? false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        delegate?.dropDown(self, commit: editingStyle, forRowAt: indexPath)
    }
}

// MARK: - Keyboard Notifications

extension VASDropDown {
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        isKeyboardVisible = true
        keyboardFrame = keyboardFrame(fromNotification: notification) ?? .zero
        let showDropDownDelay = (keyboardAnimationDuration(fromNotification: notification) ?? Self.defaultKeyboardAnimationDuration) + 0.05
        showDropDownAnimator?.stopAnimation(true)
        showDropDownDelayTimer?.invalidate()
        showDropDownDelayTimer = Timer.scheduledTimer(withTimeInterval: showDropDownDelay, repeats: false) { [weak self] _ in
            self?.showDropDown(animate: true, delay: 0.0)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        isKeyboardVisible = false
        keyboardFrame = keyboardFrame(fromNotification: notification) ?? .zero
    }
    
    private static var defaultKeyboardAnimationDuration: TimeInterval {
        0.25
    }
    
    private func keyboardFrame(fromNotification notification: Notification) -> CGRect? {
        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    private func keyboardAnimationDuration(fromNotification notification: Notification) -> TimeInterval? {
        (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }
}

struct DropDownLayout {
    let initialFrame: CGRect
    let finalFrame: CGRect
    let offscreenHeight: CGFloat
}

struct DropDownLayoutCalculator {
    
    static func calculateDropDownLayout(desirableContainerHeight: CGFloat,
                                        anchorViewFrame: CGRect,
                                        minYOfDropDown: CGFloat,
                                        maxYOfDropDown: CGFloat) -> DropDownLayout {
        
        let layoutAboveAnchorView = calculateTopDrowDownLayout(desirableContainerHeight,
                                                               anchorViewFrame,
                                                               minYOfDropDown)
        
        let layoutBelowAnchorView = calculateBottomDrowDownLayout(desirableContainerHeight,
                                                                  anchorViewFrame,
                                                                  maxYOfDropDown)
        let shouldPlaceBelowAnchorView = layoutBelowAnchorView.offscreenHeight <= layoutAboveAnchorView.offscreenHeight
        if shouldPlaceBelowAnchorView {
            return DropDownLayout(initialFrame: layoutBelowAnchorView.finalFrame.foldedUp,
                                  finalFrame: layoutBelowAnchorView.finalFrame,
                                  offscreenHeight: layoutBelowAnchorView.offscreenHeight)
        } else {
            return DropDownLayout(initialFrame: layoutAboveAnchorView.finalFrame.foldedDown,
                                  finalFrame: layoutAboveAnchorView.finalFrame,
                                  offscreenHeight: layoutAboveAnchorView.offscreenHeight)
        }
    }
    
    private static func calculateTopDrowDownLayout(_ desirableContainerHeight: CGFloat,
                                                   _ anchorViewFrame: CGRect,
                                                   _ minYOfDropDown: CGFloat) -> DropDownLayout {
        let dropDownDesirableMinY = anchorViewFrame.minY - desirableContainerHeight
        let dropDownOffscreenHeight = abs(min(0, dropDownDesirableMinY-minYOfDropDown))
        let dropDownContainerHeight = desirableContainerHeight - dropDownOffscreenHeight
        let dropDownFrame = CGRect(x: anchorViewFrame.minX,
                                   y: anchorViewFrame.minY - dropDownContainerHeight,
                                   width: anchorViewFrame.width,
                                   height: dropDownContainerHeight)
        return DropDownLayout(initialFrame: .zero, finalFrame: dropDownFrame, offscreenHeight: dropDownOffscreenHeight)
    }
    
    private static func calculateBottomDrowDownLayout(_ desirableContainerHeight: CGFloat,
                                                      _ anchorViewFrame: CGRect,
                                                      _ maxYOfDropDown: CGFloat) -> DropDownLayout {
        let dropDownDesirableMinY = anchorViewFrame.maxY
        let dropDownDesirableMaxY = dropDownDesirableMinY + desirableContainerHeight
        let dropDownOffscreenHeight = max(0, dropDownDesirableMaxY-maxYOfDropDown)
        let dropDownContainerHeight = desirableContainerHeight - dropDownOffscreenHeight
        let dropDownFrame = CGRect(x: anchorViewFrame.minX,
                                   y: dropDownDesirableMinY,
                                   width: anchorViewFrame.width,
                                   height: dropDownContainerHeight)
        return DropDownLayout(initialFrame: .zero, finalFrame: dropDownFrame, offscreenHeight: dropDownOffscreenHeight)
    }
}

protocol VASDropDownDelegate: AnyObject {
    func dropDown(_ dropDown: VASDropDown, heightForRowAt indexPath: IndexPath) -> CGFloat
    func dropDown(_ dropDown: VASDropDown, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func dropDown(_ dropDown: VASDropDown, didSelectRowAt indexPath: IndexPath)
    func numberOfRows(in dropDown: VASDropDown) -> Int
    
    func dropDown(_ dropDown: VASDropDown, canEditRowAt indexPath: IndexPath) -> Bool
    func dropDown(_ dropDown: VASDropDown, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
}

extension VASDropDownDelegate {
    func dropDown(_ dropDown: VASDropDown, canEditRowAt indexPath: IndexPath) -> Bool { false }
    func dropDown(_ dropDown: VASDropDown, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}
}

