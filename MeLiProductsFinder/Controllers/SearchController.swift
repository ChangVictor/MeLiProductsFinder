//
//  SearchController.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 26/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    private var searchViewModel = SearchViewModel()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar", for: .normal)
        button.setTitleColor(.meliWhite, for: .normal)
        button.setTitleColor(.meliLightGrey, for: .disabled)
        button.layer.cornerRadius = 3
        button.isEnabled = false
        button.backgroundColor = .meliBlueLight
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    
    let searchTextField: CustomTextField = {
        let textField = CustomTextField(padding: 15, height: 44)
        textField.placeholder = "Buscar en Mercado Libre"
        textField.keyboardType = .alphabet
        textField.backgroundColor = .meliWhite
        textField.addLine(position: .bottom, color: .meliMidGrey, width: 1.3)
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    lazy var verticalStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [searchTextField, UIView(), searchButton])
        return stackView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .meliWhite
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .init(width: 0, height: 10)
        view.layer.shouldRasterize = false
        return view
    }()
    
    private let gradientLayer = CAGradientLayer()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupViews()
        setupViewModel()
        setupNavigationBar()
        setupKeyboardDismiss()
    }
    
    fileprivate func setupViews() {
        
        view.addSubview(containerView)
        view.addSubview(searchButton)
        view.addSubview(searchTextField)
        
        extendedLayoutIncludesOpaqueBars = true
        containerView.addSubview(verticalStackView)
        containerView.centerInSuperview()
        containerView.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 200)
        verticalStackView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 15, paddingBottom: 20, paddingRight: 15, width: 0, height: 0)
        searchTextField.delegate = self
    }
        
    fileprivate func setupKeyboardDismiss() {
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
    }
    
    @objc fileprivate func handleKeyboardDismiss() {
        
        view.endEditing(true)
    }
    
    fileprivate func setupNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = .meliYellow
        navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func setupViewModel() {

        searchViewModel.isValid = { [unowned self] isValid in
            self.searchButton.isEnabled = isValid
            self.searchButton.backgroundColor = isValid ? .meliBlue : .meliBlueLight
        }
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        
        searchViewModel.searchTerm = textField.text
    }
    
    @objc fileprivate func handleSearchButton() {
        
        view.endEditing(true)
        let searchResultsController = SearchResultsController(searchTerm: self.searchTextField.text!)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backBarButtonItem?.tintColor = .meliBlack
         self.navigationController?.pushViewController(searchResultsController, animated: true)
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupGradientLayer() {
        let topColor = UIColor.meliYellow
        let bottomColor = UIColor.meliYellowLight
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
}
