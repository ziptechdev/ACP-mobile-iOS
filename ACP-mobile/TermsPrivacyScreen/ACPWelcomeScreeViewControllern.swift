//
//  ACPWelcomeScreeViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 7. 10. 2022..
//

import UIKit

class ACPWelcomeScreeViewController: UIViewController {

    // MARK: - Views
    private lazy var leftTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "acpFirstTabLeftLine")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var rightTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "acpFirstTabRightLine")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var titleText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Affordable Conectivity Program"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()
    
    private lazy var descriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "\(NSLocalizedString("welcomeScreen_text", comment: ""))"
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .justified
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    private lazy var continueButton: UIButton! = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.backgroundColor = .white
      button.setTitleColor(.coreBlue, for: .normal)
      button.addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
      button.setTitle("Continue", for: .normal)
      button.layer.masksToBounds = true
      button.layer.cornerRadius = 10
      return button
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .coreBlue
        view.addSubview(leftTopLine)
        view.addSubview(rightTopLine)
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(continueButton)
        setupConstraints()
    }

    // MARK: - UI
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftTopLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftTopLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            leftTopLine.widthAnchor.constraint(equalTo: rightTopLine.widthAnchor),

            rightTopLine.leadingAnchor.constraint(equalTo: leftTopLine.trailingAnchor, constant: 5),
            rightTopLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightTopLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),

            titleText.topAnchor.constraint(equalTo: leftTopLine.topAnchor, constant: 35),
            titleText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            titleText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 25),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            descriptionText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            descriptionText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            continueButton.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 320),
            continueButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    //MARK: Functions
    @objc func didTaped(_ sender: UIButton!){
        print("KARINA")
    }
}
