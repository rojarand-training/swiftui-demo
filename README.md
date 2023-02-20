## Custom UITableViewCell created from code

```swift
class CountryTableViewCell: UITableViewCell {
    
    private lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "CountryCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.identifier)
       
        self.contentView.addSubview(indexLabel)
        let indexLabelConstraints = [
            indexLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            indexLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(indexLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(countryName: String, index: Int) {
        textLabel?.text = countryName
        indexLabel.text = "\(index+1)"
    }
}


extension CoutryTable: UITableViewDataSource {
    ...
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier,
                                                 for: indexPath) as? CountryTableViewCell
        if let cell {
            let country = countries[indexPath.row]
            cell.update(countryName: country.name, index: indexPath.row)
            return cell
        } else {
            fatalError("The CountryTable view is misconfigured!!!")
        }
    }
}
```

<img src="preview.gif">
