//
//  DetailController.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 23/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var itemViewModel: ItemViewModel! {
        didSet {
            titleLabel.text = itemViewModel.title
            priceLabel.text = itemViewModel.price
            isNewLabel.text = itemViewModel.condition
            itemImage.loadImage(fromUrl: itemViewModel.thumbnail)
//            setupQuantityAttributedText()
            stockLabel.text = itemViewModel.hasStock
            quantityLabel.attributedText = itemViewModel.setupQuantityAttributedText()
            installmentsLabel.attributedText = itemViewModel.setupInstallmentsAttributedText()
            shippingLabel.attributedText = itemViewModel.setupShippingAttributedText()
            mercadoPagoLabel.attributedText = itemViewModel.setupMercadoPagoAttributedText()
        }
    }
    
    //MARK: - UIComponents

    let isNewLabel = UILabel(text: "newOrUsed", font: UIFont.systemFont(ofSize: 12, weight: .light), textColor: .meliGrey)

    let titleLabel = UILabel(text: "Item Name", font: UIFont.systemFont(ofSize: 18, weight: .medium), textColor: .meliBlack, numberOfLines: 0)

   let itemImage: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .meliWhite
        return imageView
    }()
    
    let quantityContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .meliLightGrey
        view.layer.cornerRadius = 5
        view.contentMode = .left
        return view
    }()
    
    let quantityLabel = UILabel(text: "QuantityLabel", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .meliBlack)

    let priceLabel = UILabel(text: "$ 00.00", font: UIFont.systemFont(ofSize: 30, weight: .medium), textColor: .meliBlack)

    let stockLabel = UILabel(text: "StockLabel", font: UIFont.systemFont(ofSize: 20, weight: .regular), textColor: .meliBlack)
    
    let installmentsLabel = UILabel(text: "Installments", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .meliBlack)
    
    let shippingLabel = UILabel(text: "ShippingLabel", font: UIFont.systemFont(ofSize: 16, weight: .medium), textColor: .meliGreen)
    
    let mercadoPagoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .meliBlueLight
        view.layer.cornerRadius = 5
        view.contentMode = .left
        return view
    }()
    
    let mercadoPagoLabel = UILabel(text: "FreeShipping", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .meliBlue)
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    //
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.bounces = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
// MARK: - Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .meliWhite
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.largeTitleDisplayMode = .automatic
        setupViews()
        setupConstraints()
       }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let height = self.view.bounds.height < 415 ? self.view.bounds.height + 150 : self.view.bounds.height - 150
        scrollView.contentSize = CGSize(width:self.view.bounds.width, height: height)
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.fillSuperview()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
//        scrollView.delegate = self
        containerView.addSubview(itemImage)
        containerView.addSubview(quantityContainerView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(stockLabel)
        containerView.addSubview(installmentsLabel)
        containerView.addSubview(shippingLabel)
        containerView.addSubview(mercadoPagoLabel)
    }
    
    fileprivate func setupConstraints() {
        
        let stackView = VerticalStackView(arrangedSubviews: [isNewLabel, titleLabel], spacing: 5)
        containerView.addSubview(stackView)
        let leftAnchor = self.view.safeAreaLayoutGuide.leftAnchor
        let rightAnchor = self.view.safeAreaLayoutGuide.rightAnchor
        
        stackView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        itemImage.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
        
        quantityContainerView.addSubview(quantityLabel)
        quantityContainerView.anchor(top: itemImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 45)
        quantityLabel.anchor(top: quantityContainerView.topAnchor, left: quantityContainerView.leftAnchor, bottom: quantityContainerView.bottomAnchor, right: quantityContainerView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 15, width: 0, height: 0)
        
        priceLabel.anchor(top: quantityContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 22, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        stockLabel.anchor(top: priceLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        let paymentStackView = VerticalStackView(arrangedSubviews: [installmentsLabel, mercadoPagoLabel, shippingLabel], spacing: 15)
        containerView.addSubview(paymentStackView)
        paymentStackView.anchor(top: stockLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }
    
    fileprivate func setupInstallmentsAttributedText() {
        
        let imageOffsetY:CGFloat = -5.0
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "creditCard")
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let installmentString = itemViewModel.installments > 1 ? "hasta \(itemViewModel.installments) cuotas!" : "cuotas!"
        let  textAfterIcon = NSMutableAttributedString(string: "  Pagá en \(installmentString)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),  NSAttributedString.Key.foregroundColor: UIColor.meliBlack])

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let attributedText = NSMutableAttributedString(string: "")
        attributedText.append(attachmentString)
        attributedText.append(textAfterIcon)
        self.installmentsLabel.attributedText = attributedText
    }
    
    fileprivate func setupShippingAttributedText() {
        
        let imageOffsetY:CGFloat = -5.0
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "deliveryTruck")
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let installmentString = itemViewModel.installments > 1 ? "hasta \(itemViewModel.installments) cuotas!" : "cuotas!"
        let  textAfterIcon = NSMutableAttributedString(string: "  Pagá en \(installmentString)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),  NSAttributedString.Key.foregroundColor: UIColor.meliBlack])

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let attributedText = NSMutableAttributedString(string: "")
        attributedText.append(attachmentString)
        attributedText.append(textAfterIcon)
        self.installmentsLabel.attributedText = attributedText
    }
}
