//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension UITableView {
    func adjustFooterViewHeightToFillTableView(heightCalculation: () -> CGFloat) {
        
        if let tableFooterView = self.tableFooterView {
            
            let minHeight = heightCalculation()//tableFooterView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            let currentFooterHeight = tableFooterView.frame.height
            
            let realContentHeight: CGFloat
            if currentFooterHeight > minHeight {
                realContentHeight = self.contentSize.height - currentFooterHeight
            } else {
                realContentHeight = self.contentSize.height
            }
            NSLog("frame.height: \(frame.height), contentSize.height: \(self.contentSize.height), currentFooterHeight: \(currentFooterHeight), realContentHeight: \(realContentHeight)")
            let fitHeight = self.frame.height - self.adjustedContentInset.top - realContentHeight//self.contentSize.height
            let nextHeight = (fitHeight > minHeight) ? fitHeight : minHeight
            
            if (round(nextHeight) != round(currentFooterHeight)) {
                var frame = tableFooterView.frame
                frame.size.height = nextHeight
                tableFooterView.frame = frame
                self.tableFooterView = tableFooterView
            }
        }
    }
}

final class ViewControllerWithButtonOnBottom: UIViewController {
    
    private var items = Array(repeating: 0, count: 3)
    
    private lazy var table: UITableView = {
        let table = UITableView()
        let footerView = UIView(frame: .zero)
        
        let bottomGreenView = UIView(frame: .zero)
        bottomGreenView.translatesAutoresizingMaskIntoConstraints = false
        bottomGreenView.backgroundColor = .green
        footerView.addSubview(bottomGreenView)
        NSLayoutConstraint.activate([
            bottomGreenView.heightAnchor.constraint(equalToConstant: 50),
            bottomGreenView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            bottomGreenView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            bottomGreenView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
        ])
        
        footerView.backgroundColor = .red
        table.tableFooterView = footerView
        table.backgroundColor = .lightGray
        return table
    }()
    
    @objc private func addItem() {
        items.append(0)
        table.reloadData()
        table.adjustFooterViewHeightToFillTableView {
            50.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let topView = UIView(frame: .zero)//UIButton(primaryAction: action)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addItem))
        topView.addGestureRecognizer(tapGesture)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .orange
        
        let action = UIAction(title: "Add item") { [unowned self] _ in
            self.addItem()
        }
        let addItemButton = UIButton(primaryAction: action)
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(addItemButton)
        
        NSLayoutConstraint.activate([
            addItemButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            addItemButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            addItemButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
        ])
        
        view.addSubview(topView)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50.0),
            
            table.topAnchor.constraint(equalTo: topView.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.adjustFooterViewHeightToFillTableView {
            50.0
        }
    }
}

extension ViewControllerWithButtonOnBottom: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
    
    //This is crucial. Without it `self.contentSize.height`
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
}

extension ViewControllerWithButtonOnBottom: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Some text"
        return cell
    }
    
}

struct VC: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewControllerWithButtonOnBottom()
    }
}

struct ContentView: View {
    var body: some View {
        VC().ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
