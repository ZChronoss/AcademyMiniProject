//
//  PersonView.swift
//  CobaUIKit
//
//  Created by Renaldi Antonio on 14/08/24.
//

import UIKit

class PersonView: UIView {
    private lazy var subscribeBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Subscribe".uppercased()
        config.baseBackgroundColor = .red
        config.baseForegroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        
        /// PENTING
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        return btn
        
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Billy Bob"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    private lazy var emailLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "billy.bob@gmail.com"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    private lazy var personStackview: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    private var action: () -> ()
    
    init(action: @escaping () -> ()){
        self.action = action
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, email: String){
        nameLbl.text = name
        emailLbl.text = email
    }
}

private extension PersonView {
    func setup(){
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(personStackview)
        
        personStackview.addArrangedSubview(nameLbl)
        personStackview.addArrangedSubview(emailLbl)
        personStackview.addArrangedSubview(subscribeBtn)
        
        NSLayoutConstraint.activate([
            personStackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            personStackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            personStackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            personStackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    @objc func didTapSubscribe(sender: UIButton){
        action()
    }
}
