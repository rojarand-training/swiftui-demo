//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension UITableView {
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue tableview cell with identifier: \(T.self)")
        }
        return cell
    }

    public func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
}

class DropDownTableViewCell: UITableViewCell {

    private lazy var button: UIButton = {
        let button = UIButton()
        if let image = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal) {
            button.setImage(image, for: .normal)
        }
//        button.setTitle("Helloo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var buttonCallback: ((String) -> Void)?
    @objc private func onButtonTapped() {
        buttonCallback?(textLabel?.text ?? "empty")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .lightGray.withAlphaComponent(0.4)
        self.contentView.addSubview(button)
        let indexLabelConstraints = [
            button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(indexLabelConstraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(countryName: String) {
        textLabel?.text = countryName
    }
}

class SampleTableViewCell: UITableViewCell {

    private lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray.withAlphaComponent(0.4)
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .yellow.withAlphaComponent(0.4)
        self.contentView.addSubview(indexLabel)
        let indexLabelConstraints = [
            indexLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            indexLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(indexLabelConstraints)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textField)
        let textViewContraints = [
            textField.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(textViewContraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(countryName: String, index: Int) {
        textLabel?.text = countryName
        indexLabel.text = "\(index+1)"
    }
}

extension ViewController: VASDropDownDelegate {
    
    func dropDown(_ dropDown: VASDropDown, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //40//UITableView.automaticDimension
        //UITableView.automaticDimension
        40
    }
    
    func dropDown(_ dropDown: VASDropDown, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DropDownTableViewCell = dropDown.tableView.dequeueReusableCell(for: indexPath)
        cell.update(countryName: "\(currentWords[indexPath.row]) \(indexPath.row)")
        cell.buttonCallback = { text in
            NSLog("Button tapped: \(text)")
            dropDown.hide()
        }
        return cell
    }
    
    func dropDown(_ dropDown: VASDropDown, didSelectRowAt indexPath: IndexPath) {
        let word = currentWords[indexPath.row]
        if let currentTextField = dropDown.anchorView as? UITextField {
            currentTextField.text = word
        }
    }
    
    func numberOfRows(in dropDown: VASDropDown) -> Int {
        NSLog("Number of words: \(currentWords.count)")
        return currentWords.count
    }
    
    func dropDown(_ dropDown: VASDropDown, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    func dropDown(_ dropDown: VASDropDown, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    
    var currentWords: [String] {
        if currentString.isEmpty {
            return allWords
        }
        return allWords.map{ $0.lowercased() }.filter { $0.contains(currentString.lowercased()) }
    }
    
    var allWords: [String] {
        ["Bella", "Ala", "Margaret", "Zenia", "Józio", "Waldek", "Marek", "Robert", "Szymon", "Piotr"]
    }
}


final class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = UIView()
        newView.backgroundColor = .yellow
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        newView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50).isActive = true
        newView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50).isActive = true
        newView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -50).isActive = true
        
        newView.layer.shadowColor = UIColor.black.cgColor
        newView.layer.shadowOffset = CGSize(width: 5, height: 5)
        newView.layer.shadowOpacity = 0.4
        newView.layer.shadowRadius = 4
        newView.layer.cornerRadius = 4
        
        let tableView = UITableView()
        newView.addSubview(tableView)
        tableView.frame = newView.bounds
        tableView.layer.cornerRadius = 4
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        newView.layer.masksToBounds = false
//        newView.clipsToBounds = true
    }
}

final class ViewController: UITableViewController {
    
    private lazy var dropDown: VASDropDown = {
        VASDropDown()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell: SampleTableViewCell.self)
        tableView.dataSource = self
        tableView.reloadData()
        dropDown.register(cell: DropDownTableViewCell.self)
        dropDown.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SampleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.update(countryName: "CCC \(indexPath.row)", index: indexPath.row)
        cell.textField.delegate = self
        return cell
    }
    private var currentString = ""
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLog("--- textFieldShouldBeginEditing: %@", textField)
        currentString = ""
        dropDown.show(nextTo: textField)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentString = textField.text ?? ""
        let range = Range(range, in: currentString)!
        currentString = currentString.replacingCharacters(in: range, with: string)
        NSLog("--- final: \(currentString)")
        dropDown.show(nextTo: textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        NSLog("--- \(textField.text)")
    }
}

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
//        ViewController2()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
