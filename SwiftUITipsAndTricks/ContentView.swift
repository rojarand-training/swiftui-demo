//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

final class ParkingSummaryViewController2: UIViewController {
    
    private lazy var parkingImage: UIView = {
        let image = UIImage(systemName: "car.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 48),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    private lazy var vehiclePlateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Twój pojazd"
        return label
    }()
    
    private lazy var vehiclePlateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "BI 764AW"
        return label
    }()
    
    private lazy var parkingZoneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Strefa parkowania"
        return label
    }()
    
    private lazy var parkingZoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Śródmiejska SPP Centrum"
        return label
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cena"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "max 25,50 zł"
        return label
    }()
    
    private lazy var remainderView: UIView = {
        let imageView = UIImageView(image: UIImage(systemName: "info.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Pamiętaj o oznakowaniu pojazdu!"
        label.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("KUPUJE I ZAPŁACĘ", for: .normal)
        button.addTarget(self, action: #selector(onBuyAndPayButtonInteraction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        /*
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
        ])
        */
        return button
    }()
    
    @objc private func onBuyAndPayButtonInteraction() {
        
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .yellow
        stackView.layer.cornerRadius = 15.0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private func layoutAllViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
        stackView.addArrangedSubview(parkingImage)
        stackView.setCustomSpacing(15, after: parkingImage)
        stackView.addArrangedSubview(vehiclePlateTitleLabel)
        stackView.addArrangedSubview(vehiclePlateLabel)
        stackView.setCustomSpacing(15, after: vehiclePlateLabel)
        stackView.addArrangedSubview(parkingZoneTitleLabel)
        stackView.addArrangedSubview(parkingZoneLabel)
        stackView.setCustomSpacing(15, after: parkingZoneLabel)
        stackView.addArrangedSubview(priceTitleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.setCustomSpacing(15, after: priceLabel)
        stackView.addArrangedSubview(remainderView)
        stackView.setCustomSpacing(15, after: remainderView)
        stackView.addArrangedSubview(buyButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        layoutAllViews()
    }
}

final class ParkingSummaryViewController: UIViewController {
    
    private lazy var parkingImage: UIView = {
        let image = UIImage(systemName: "car.circle.fill")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var vehiclePlateTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Twój pojazd"
        return label
    }()
    
    private lazy var vehiclePlateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.text = "BI 764AW"
        return label
    }()
    
    private lazy var parkingZoneTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Strefa parkowania"
        return label
    }()
    
    private lazy var parkingZoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Śródmiejska SPP Centrum"
        return label
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Cena"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "max 25,50 zł"
        return label
    }()
    
    private lazy var reminderView: UIView = {
        let imageView = UIImageView(image: UIImage(systemName: "info.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Pamiętaj o oznakowaniu pojazdu!"
        label.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("KUPUJE I ZAPŁACĘ", for: .normal)
        button.addTarget(self, action: #selector(onBuyAndPayButtonInteraction), for: .touchUpInside)
        button.backgroundColor = .blue
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 10)
        return button
    }()
    
    @objc private func onBuyAndPayButtonInteraction() {
        
    }
    
    private lazy var goBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("Wróć do edycji", for: .normal)
        button.addTarget(self, action: #selector(onGoBackButtonInteraction), for: .touchUpInside)
        return button
    }()
    
    @objc private func onGoBackButtonInteraction() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        layoutAllViews()
    }
    
    private func layoutAllViews() {
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15.0

        [parkingImage, vehiclePlateTitleLabel, vehiclePlateLabel,
         parkingZoneTitleLabel, parkingZoneLabel, priceTitleLabel, priceLabel,
         reminderView, buyButton, goBackButton, extraViewToActivateScroll].forEach { childView in
            childView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(childView)
        }
        
        NSLayoutConstraint.activate([
            parkingImage.heightAnchor.constraint(equalToConstant: 48),
            parkingImage.widthAnchor.constraint(equalToConstant: 48),
            parkingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parkingImage.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalMediumMargin),
            
            vehiclePlateTitleLabel.topAnchor.constraint(equalTo: parkingImage.bottomAnchor, constant: verticalLargeMargin),
            vehiclePlateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            vehiclePlateTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            
            vehiclePlateLabel.topAnchor.constraint(equalTo: vehiclePlateTitleLabel.bottomAnchor, constant: verticalSmallMargin),
            vehiclePlateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            vehiclePlateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            
            parkingZoneTitleLabel.topAnchor.constraint(equalTo: vehiclePlateLabel.bottomAnchor, constant: verticalLargeMargin),
            parkingZoneTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            parkingZoneTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),

            parkingZoneLabel.topAnchor.constraint(equalTo: parkingZoneTitleLabel.bottomAnchor, constant: verticalSmallMargin),
            parkingZoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            parkingZoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
           
            priceTitleLabel.topAnchor.constraint(equalTo: parkingZoneLabel.bottomAnchor, constant: verticalLargeMargin),
            priceTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            priceTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),

            priceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: verticalSmallMargin),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            
            reminderView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: verticalLargeMargin),
            reminderView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: horizontalMargin),
            reminderView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -horizontalMargin),
            reminderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buyButton.topAnchor.constraint(equalTo: reminderView.bottomAnchor, constant: verticalLargeMargin),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),

            goBackButton.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: verticalLargeMargin),
            goBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            goBackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            extraViewToActivateScroll.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: verticalLargeMargin),
            extraViewToActivateScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            extraViewToActivateScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            extraViewToActivateScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalMediumMargin)
        ])
    }
    
    private var horizontalMargin: CGFloat {
        10.0
    }
    
    private var verticalLargeMargin: CGFloat {
        verticalMediumMargin + 3.0
    }
    
    private var verticalMediumMargin: CGFloat {
        verticalSmallMargin + 3.0
    }
    
    private var verticalSmallMargin: CGFloat {
        3.0
    }
    
    private lazy var extraViewToActivateScroll: UIView = {
        let extraView = UIView()
        extraView.translatesAutoresizingMaskIntoConstraints = false
        var upperView: UIView?
        
        for i in 0..<100 {
            let label = UILabel()
            label.text = "Label \(i)"
            label.translatesAutoresizingMaskIntoConstraints = false
            extraView.addSubview(label)
            let topAnchor: NSLayoutYAxisAnchor = upperView?.bottomAnchor ?? extraView.topAnchor
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor),
                label.leadingAnchor.constraint(equalTo: extraView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: extraView.trailingAnchor),
            ])
            upperView = label
        }
        if let upperView {
            upperView.bottomAnchor.constraint(equalTo: extraView.bottomAnchor).isActive = true
        }
        return extraView
    }()
}

final class HostViewControllerWithTransparentBorder: UIViewController {
    
    private let childViewController: UIViewController
    private let scrollView = UIScrollView()
    
    init(childViewController: UIViewController) {
        self.childViewController = childViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpLayout()
    }
    
    private func setUpLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        
        let heightAnchorToSatisfyHeightAmbiguity = scrollView.heightAnchor.constraint(equalToConstant: 0)
        heightAnchorToSatisfyHeightAmbiguity.priority = UILayoutPriority(1)
        NSLayoutConstraint.activate([
            heightAnchorToSatisfyHeightAmbiguity,
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -verticalOffset),
            scrollView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: verticalMargin),
            scrollView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -verticalMargin)
        ])
        
        scrollView.isScrollEnabled = false

        addChild(childViewController)
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let childView: UIView = childViewController.view
        scrollView.addSubview(childView)
        
        let heightAnchor = scrollView.heightAnchor.constraint(equalTo: childView.heightAnchor)
        heightAnchor.priority = UILayoutPriority(250)

        NSLayoutConstraint.activate([
            heightAnchor,
            childView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            childView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            childView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            childView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.isScrollEnabled = (scrollView.frame.height + (verticalMargin * 2) + (verticalOffset * 2)) >= view.frame.height
    }
    
    private var horizontalMargin: CGFloat {
        20.0
    }
    
    private var verticalMargin: CGFloat {
        20.0
    }
    
    private var verticalOffset: CGFloat {
        0.0
    }
}

final class PresentingVC: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = HostViewControllerWithTransparentBorder(childViewController: ParkingSummaryViewController())
        present(vc, animated: false)
    }
}

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        PresentingVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
