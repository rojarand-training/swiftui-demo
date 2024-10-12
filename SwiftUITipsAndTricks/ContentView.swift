//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI

import UIKit
import Vision
import CoreML

class CarRecognitionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI elements
    let imageView = UIImageView()
    let resultLabel = UILabel()
    let selectImageButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color
        view.backgroundColor = .white
        
        // Setup imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // Setup resultLabel
        resultLabel.text = "Select an image to detect a car"
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        // Setup selectImageButton
        selectImageButton.setTitle("Select Image", for: .normal)
        selectImageButton.setTitleColor(.systemBlue, for: .normal)
        selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectImageButton)
        
        // Add constraints
        setupConstraints()
    }
    
    // Setup Auto Layout constraints for the views
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // ImageView Constraints
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            // ResultLabel Constraints
            resultLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // SelectImageButton Constraints
            selectImageButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            selectImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Open image picker to select an image from the photo library
    @objc func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Delegate method for image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            detectCarInImage(image: image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // Method to perform car recognition using Core ML and Vision
    func detectCarInImage(image: UIImage) {
        guard let model = try? VNCoreMLModel(for: CarDetector().model) else {
            resultLabel.text = "Failed to load model"
            return
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                self.resultLabel.text = "No cars detected"
                return
            }
            
            for result in results {
                if let carLabel = result.labels.first(where: { $0.identifier == "dog" }) {
                    let confidence = carLabel.confidence * 100
                    DispatchQueue.main.async {
                        self.resultLabel.text = "Car detected with \(confidence)% confidence"
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                self.resultLabel.text = "No car detected"
            }
        }
        
        guard let ciImage = CIImage(image: image) else { return }
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}


struct ContentView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        CarRecognitionViewController()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
