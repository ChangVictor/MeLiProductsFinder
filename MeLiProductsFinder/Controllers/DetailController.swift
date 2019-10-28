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

            // sold_quantity
            // accepts mercadopago
            shippingLabel.attributedText = itemViewModel.setupShippingAttributedText()

        }
    }
    
    //MARK: - UIComponents
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.sizeToFit()
        return scrollView
    }()
    
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
    
    let quantityLabel = UILabel(text: "Cantidad: 1", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .meliBlack)

    let priceLabel = UILabel(text: "$ 00.00", font: UIFont.systemFont(ofSize: 30, weight: .medium), textColor: .meliBlack)

    let stockLabel = UILabel(text: "StockLabel", font: UIFont.systemFont(ofSize: 20, weight: .regular), textColor: .meliBlack)
    
    let installmentsLabel = UILabel(text: "Pagalo en cuotas", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .meliBlack)
    
    let shippingLabel = UILabel(text: "Recibilo gratis en tu casa!", font: UIFont.systemFont(ofSize: 16, weight: .medium), textColor: .meliGreen)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .meliWhite
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.largeTitleDisplayMode = .automatic
        setupViews()
        setupConstraints()
       }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
//        scrollView.delegate = self
        scrollView.addSubview(itemImage)
        scrollView.addSubview(quantityContainerView)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(stockLabel)
        scrollView.addSubview(installmentsLabel)
        scrollView.addSubview(shippingLabel)
    }
    
    fileprivate func setupConstraints() {
        
        let stackView = VerticalStackView(arrangedSubviews: [isNewLabel, titleLabel], spacing: 5)
        scrollView.addSubview(stackView)
        let leftAnchor = self.view.safeAreaLayoutGuide.leftAnchor
        let rightAnchor = self.view.safeAreaLayoutGuide.rightAnchor
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        itemImage.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
        
        quantityContainerView.addSubview(quantityLabel)
        quantityContainerView.anchor(top: itemImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 45)
        quantityLabel.anchor(top: quantityContainerView.topAnchor, left: quantityContainerView.leftAnchor, bottom: quantityContainerView.bottomAnchor, right: quantityContainerView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 15, width: 0, height: 0)
        
        priceLabel.anchor(top: quantityContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 22, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        stockLabel.anchor(top: priceLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        installmentsLabel.anchor(top: stockLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        shippingLabel.anchor(top: installmentsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
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
