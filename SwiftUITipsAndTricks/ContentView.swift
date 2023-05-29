//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        VieController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UITextView {
        var date: Date? {
            get {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                return dateFormatter.date(from: text)
            }
            set {
                if let date = newValue {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    text = dateFormatter.string(from: date)
                } else {
                    text = ""
                }
            }
        }
    }

class VieController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(section)
        section.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            section.topAnchor.constraint(equalTo: view.topAnchor),
            section.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            section.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                   multiplier: 0.95),
            section.heightAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.translatesAutoresizingMaskIntoConstraints = false
        //picker.addTarget(self, action: #selector(VieController.didPickDate), for: .valueChanged)
        //picker.isHidden = true
        return picker
    }()
    
    @objc private func didPickDate() {
        NSLog("Picked date:\(datePicker.date)")
    }
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.textColor = .systemBlue
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.date = Date()
        tv.isEditable = false
        //tv.layer.cornerRadius = 3
        tv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCalendar)))
        return tv
    }()
    
    private var pickerWidthContraint: NSLayoutConstraint!
    private var pickerHeightContraint: NSLayoutConstraint!
    
    lazy var section: UIView = {
        let sectionView = UIView()
        
        //3. Color range is 0..1 not 0..255
        //sectionView.backgroundColor = UIColor(red: 246.0/255.0, green: 240.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        //datePicker.backgroundColor = sectionView.backgroundColor
        
        sectionView.layer.cornerRadius = 20
        
        //4. Add gesture recognizer to the calendar image view
        let calendarIV = UIImageView()
        calendarIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCalendar)))
        calendarIV.isUserInteractionEnabled = true
        calendarIV.image = UIImage(systemName: "calendar")
        calendarIV.translatesAutoresizingMaskIntoConstraints = false
        
        let heightOfCalendarBackgroundView = 40.0
        let calendarBackgroundView = UIView()
        calendarBackgroundView.backgroundColor = UIColor(red: 246.0/255.0, green: 240.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        textView.backgroundColor = calendarBackgroundView.backgroundColor
        //textView.backgroundColor = .blue
        calendarBackgroundView.layer.cornerRadius = heightOfCalendarBackgroundView/2
        calendarBackgroundView.addSubview(calendarIV)
        calendarBackgroundView.addSubview(textView)
        calendarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarIV.leadingAnchor.constraint(equalTo: calendarBackgroundView.leadingAnchor, constant: heightOfCalendarBackgroundView/2),
            calendarIV.centerYAnchor.constraint(equalTo: calendarBackgroundView.centerYAnchor),
            
            textView.centerYAnchor.constraint(equalTo: calendarBackgroundView.centerYAnchor),
            textView.centerXAnchor.constraint(equalTo: calendarBackgroundView.centerXAnchor),
            
            textView.widthAnchor.constraint(equalToConstant: 100),
            textView.heightAnchor.constraint(equalToConstant: heightOfCalendarBackgroundView/2),
        ])
        
        //sectionView.addSubview(calendarIV)
        //sectionView.addSubview(textView)
        sectionView.addSubview(calendarBackgroundView)
        sectionView.addSubview(datePicker)
        
        //let tv = UITextView(frame: .zero)
        //sectionView.addSubview(tv)
        //tv.inputView = datePicker
        
        pickerWidthContraint = datePicker.widthAnchor.constraint(equalToConstant: 0)
        pickerHeightContraint = datePicker.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            calendarBackgroundView.heightAnchor.constraint(equalToConstant: heightOfCalendarBackgroundView),
            calendarBackgroundView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 30),
            calendarBackgroundView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -30),
            calendarBackgroundView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 30),
//            calendarIV.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor, constant: -150),
//            calendarIV.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
//
//            textView.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor, constant: -150),
//            textView.centerXAnchor.constraint(equalTo: sectionView.centerXAnchor),
//            textView.widthAnchor.constraint(equalToConstant: 100),
//            textView.heightAnchor.constraint(equalToConstant: 30),
            
            datePicker.topAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -200),
            datePicker.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 0),
            pickerWidthContraint,
            pickerHeightContraint
        ])

        return sectionView
    }()
    
    @objc func didTapCalendar(sender: UITapGestureRecognizer) {
        
        datePicker.isHidden = false
        
        //self.pickerWidthContraint.constant = self.section.frame.width
        //self.pickerHeightContraint.constant = self.view.frame.height * 0.4
        ///*
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut,
                       animations: {
            self.pickerWidthContraint.constant = self.section.frame.width
            self.pickerHeightContraint.constant = self.view.frame.height * 0.4
            self.view.layoutIfNeeded()
        },
                       completion:{ finished in
            
        })
        //*/
    }
}



class VieController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(section)
        section.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            section.topAnchor.constraint(equalTo: view.topAnchor),
            section.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            section.widthAnchor.constraint(equalTo: view.widthAnchor,
                                           multiplier: 0.8),
            section.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(VieController3.didPickDate), for: .valueChanged)
        return picker
    }()
    
    @objc private func didPickDate() {
        NSLog("Picked date:\(datePicker.date)")
    }
    
    lazy var section: UIView = {
        let sectionView = UIView()
        
        //3. Color range is 0..1 not 0..255
        sectionView.backgroundColor = UIColor(red: 246.0/255.0, green: 240.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        datePicker.backgroundColor = sectionView.backgroundColor
        
        sectionView.layer.cornerRadius = 20
        
        //4. Add gesture recognizer to the calendar image view
        let calendarIV = UIImageView()
        calendarIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCalendar)))
        calendarIV.isUserInteractionEnabled = true
        calendarIV.image = UIImage(systemName: "calendar")
        calendarIV.translatesAutoresizingMaskIntoConstraints = false
        
        sectionView.addSubview(calendarIV)
        sectionView.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            calendarIV.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor),
            calendarIV.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
            datePicker.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor),
            datePicker.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 50)
        ])
        
        return sectionView
    }()
    
    @objc func didTapCalendar(sender: UITapGestureRecognizer) {
        // 4. Show or hide the picker using its isHidden property
        //datePicker.isHidden.toggle()
        //textView.becomeFirstResponder()
        datePicker.becomeFirstResponder()
    }
}

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(calendarImageView)
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    lazy var calendarImageView: UIImageView = {
        let calendarIV = UIImageView()
        calendarIV.image = UIImage(systemName: "calendar")
        calendarIV.translatesAutoresizingMaskIntoConstraints = false
        calendarIV.isUserInteractionEnabled = true
        calendarIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCalendar)))
        return calendarIV
    }()
    
    @objc func didTapCalendar() {
        
        calendarPresenter.show { date in
            NSLog("Picked date: \(String(describing: date))")
        }
    }
    
    private lazy var calendarPresenter: CalendarPresenter = {
        let backgroundColor = UIColor(red: 246.0/255.0, green: 240.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        return CalendarPresenter(presentingView: calendarImageView,
                                 calendarBackgroundColor: backgroundColor)
    }()
}

class CalendarPresenter: NSObject {
    
    private let presentingView: UIView
    private let calendarBackgroundColor: UIColor
    private var textView: UITextView?
    private var completion: ((Date?) -> Void)?
    
    init(presentingView: UIView, calendarBackgroundColor: UIColor) {
        self.presentingView = presentingView
        self.calendarBackgroundColor = calendarBackgroundColor
        super.init()
    }
    
    func show(completion: @escaping (Date?) -> Void) {
        self.completion = completion
        if self.textView == nil {
            self.textView = createTextView()
        }
        textView?.becomeFirstResponder()
    }
    
    private func createTextView() -> UITextView {
        let textView = UITextView(frame: .zero)
        textView.accessibilityElementsHidden = true
        presentingView.addSubview(textView)
        textView.inputAccessoryView = createAccessoryToolbar()
        textView.inputView = createDatePicker()
        return textView
    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.timeZone = TimeZone.current
        datePicker.addTarget(self, action: #selector(CalendarPresenter.dismissWithResultDatePicked), for: .valueChanged)
        return datePicker
    }
    
    private func createAccessoryToolbar() -> UIToolbar? {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .done,
                                           target: self,
                                           action: #selector(CalendarPresenter.dismissWithResultCancelled))
        
        let okButton = UIBarButtonItem(title: "OK",
                                       style: .done,
                                       target: self,
                                       action: #selector(CalendarPresenter.dismissWithResultDatePicked))
        
        toolbar.items = [spacer, cancelButton, okButton]
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }
    
    @objc private func dismissWithResultDatePicked() {
        textView?.resignFirstResponder()
        if let datePicker = textView?.inputView as? UIDatePicker {
            completion?(datePicker.date)
        } else {
            completion?(nil)
        }
    }
    
    @objc private func dismissWithResultCancelled() {
        textView?.resignFirstResponder()
        completion?(nil)
    }
}
