//
//  ViewController.swift
//  HSB Demo
//
//  Created by Haidar Mohammed on 3/7/20.
//  Copyright © 2020 Haidar AlOgaily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!

    var hueSlider: ColorSlider!
    var saturationSlider: ColorSlider!
    var brightnessSlider: ColorSlider!
    
    var hueLabel: UILabel!
    var saturationLabel: UILabel!
    var brightnessLabel: UILabel!
    
    var blurEffectView: UIVisualEffectView!
    
    lazy var originalImage: UIImage = {
        return UIImage(named: "neon-source")!
    }()
    
    lazy var context: CIContext = {
           return CIContext(options: nil)
       }()
    
    var filter: CIFilter!
    var filter2: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        setupViews()
        setupConstraints()
    }
    
    // Create the views.
    private func createViews(){
        
        hueSlider = ColorSlider(orientation: .horizontal, colorMode: .all, previewSide: .none)
        saturationSlider = ColorSlider(orientation: .horizontal, colorMode: .wr, previewSide: .none)
        brightnessSlider = ColorSlider(orientation: .horizontal, colorMode: .bw, previewSide: .none)

        hueLabel = UILabel()
        hueLabel.text = "Hue"
        hueLabel.textColor = UIColor.white
        hueLabel.textAlignment = .center
        hueLabel.font = UIFont.boldSystemFont(ofSize: 20)

        saturationLabel = UILabel()
        saturationLabel.text = "Sarturation"
        saturationLabel.textColor = UIColor.white
        saturationLabel.textAlignment = .center
        saturationLabel.font = UIFont.boldSystemFont(ofSize: 20)

        brightnessLabel = UILabel()
        brightnessLabel.text = "Brightness"
        brightnessLabel.textColor = UIColor.white
        brightnessLabel.textAlignment = .center
        brightnessLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        imageView = UIImageView(image: UIImage(named: "neon-source"))
        imageView.contentMode = .scaleAspectFill
        
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: darkBlur)
        
        let inputImage = CIImage(image: originalImage)
        filter = CIFilter(name: "CIHueAdjust")
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        filter2 = CIFilter(name: "CIColorControls")
        filter2.setValue(inputImage, forKey: kCIInputImageKey)
        
    }
    
    // Setup and add the views.
    private func setupViews(){
        
        // Observe ColorSlider events
        hueSlider.addTarget(self, action: #selector(changedColor(slider:)), for: .valueChanged)
        saturationSlider.addTarget(self, action: #selector(changedColor(slider:)), for: .valueChanged)
        brightnessSlider.addTarget(self, action: #selector(changedColor(slider:)), for: .valueChanged)
        
        // Add the views
        self.view.addSubview(imageView, false)
        self.view.addSubview(blurEffectView, false)
        self.view.addSubview(hueSlider, false)
        self.view.addSubview(saturationSlider, false)
        self.view.addSubview(brightnessSlider, false)
        self.view.addSubview(hueLabel, false)
        self.view.addSubview(saturationLabel, false)
        self.view.addSubview(brightnessLabel, false)

    }
    
    // Setup the constraints.
    func setupConstraints() {
        let inset = CGFloat(30)
        
        NSLayoutConstraint.activate([
                        
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            hueLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            hueLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            hueLabel.bottomAnchor.constraint(equalTo: hueSlider.topAnchor, constant: -inset),
            
            hueSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            hueSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            hueSlider.heightAnchor.constraint(equalToConstant: 15),
            hueSlider.bottomAnchor.constraint(equalTo: saturationLabel.topAnchor, constant: -inset),
            
            saturationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            saturationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            saturationLabel.bottomAnchor.constraint(equalTo: saturationSlider.topAnchor, constant: -inset),
            
            saturationSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            saturationSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            saturationSlider.heightAnchor.constraint(equalToConstant: 15),
            saturationSlider.bottomAnchor.constraint(equalTo: brightnessLabel.topAnchor, constant: -inset),
            
            brightnessLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            brightnessLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            brightnessLabel.bottomAnchor.constraint(equalTo: brightnessSlider.topAnchor, constant: -inset),
            
            brightnessSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            brightnessSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            brightnessSlider.heightAnchor.constraint(equalToConstant: 15),
            brightnessSlider.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -inset),
            
            blurEffectView.topAnchor.constraint(equalTo: self.hueLabel.topAnchor, constant: -inset),
            blurEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    // Observe ColorSlider .valueChanged events.
    @objc func changedColor(slider: ColorSlider) {
        
        let progress = slider.sliderProgress

        switch (slider){
            
        case saturationSlider:
            filter2!.setValue(progress, forKey: kCIInputSaturationKey)
            if let ciimage = filter2.outputImage {
                self.imageView.image = UIImage(ciImage: ciimage)
            }
            break;
            
        case hueSlider:
            let rotation = (progress * CGFloat.pi*2)
            filter.setValue(rotation, forKey: kCIInputAngleKey)
            let outputImage = filter.outputImage!
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                imageView.image = UIImage(cgImage: cgImage)
            }
            break;
            
        case brightnessSlider:
            filter2!.setValue(progress, forKey: kCIInputBrightnessKey)
            if let ciimage = filter2.outputImage {
                self.imageView.image = UIImage(ciImage: ciimage)
            }
            break;
            
        default: break
        }
    }
    
}

