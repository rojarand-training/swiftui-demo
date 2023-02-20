//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

struct ContentView: View {

    var body: some View {
        TableView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TableView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        TableViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct Country: Decodable {
    let name: String
}

typealias Countries = [Country]

final class ViewModel: ObservableObject {
    
    @Published var countries: Countries = []
    private var cancellables: Set<AnyCancellable> = []
     
    func reload() {
        cancellables = []
        countryPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { countries in
                self.countries = countries
            }.store(in: &cancellables)
    }
    
    private var countryPublisher: AnyPublisher<Countries, Error> {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Countries.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


class TableViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellable: AnyCancellable?
    
    private lazy var reloadButton: UIButton = {
        let primaryAction = UIAction(title:"Reload", handler: { [weak self] action in
            self?.viewModel.reload()
        })
        let button = UIButton(primaryAction: primaryAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var countryTable: CoutryTable = {
        let table = CoutryTable()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTable()
        setupBindings()
    }
    
    private func setupLayout() {
        self.view.addSubview(reloadButton)
        self.view.addSubview(countryTable)
        
        let buttonConstraints = [
            reloadButton.topAnchor.constraint(equalTo: self.view.topAnchor),
            reloadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        let tableConstraints = [
            countryTable.topAnchor.constraint(equalTo: reloadButton.bottomAnchor),
            countryTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            countryTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            countryTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints + tableConstraints)
    }
    
    private func setupTable() {
        countryTable.setup()
    }
    
    private func setupBindings() {
        cancellable = viewModel.$countries.sink { [weak self] countries in
            self?.countryTable.updateCountries(countries)
        }
    }
}

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

class CoutryTable: UITableView {
    var countries: Countries = []
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        self.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
    
    func updateCountries(_ countries: Countries) {
        self.countries = countries
        self.reloadData()
    }
}

extension CoutryTable: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CoutryTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}
