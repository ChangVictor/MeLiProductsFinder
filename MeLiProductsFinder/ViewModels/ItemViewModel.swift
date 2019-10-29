//
//  ItemViewModel.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 27/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class ItemViewModel {
    
    var title: String
    let price: String
    let availableQuantity: Int
    let hasStock: String
    let soldQuantity: Int
    let condition: String
    let thumbnail: String
    let acceptsMercadopago: Bool
    let installments: Int
    let installmentPrice: Double?
    let address: String?
    let freeShipping: Bool?
    let hasFreeShipping: String?
    
    init(item: ItemResult) {
        self.title = item.title
        self.price = "$ \(item.price.formattedWithSeparator)"
        self.availableQuantity = item.available_quantity
        self.hasStock = item.available_quantity >= 1 ? "Stock disponible" : "Sin stock"
        self.soldQuantity = item.sold_quantity
        self.condition = item.condition == "new" ? "Nuevo" : "Usado"
        self.thumbnail = item.thumbnail
        self.acceptsMercadopago = item.accepts_mercadopago
        self.installments = item.installments?.quantity ?? 0
        self.installmentPrice  = item.installments?.amount
        self.address = item.address?.city_name
        self.freeShipping = item.shipping?.free_shipping
        self.hasFreeShipping = item.shipping?.free_shipping == true ? "Envío Gratis" : ""
    
    }
    
    func setupQuantityAttributedText() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: "Cantidad:  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),  NSAttributedString.Key.foregroundColor: UIColor.meliBlack])

        attributedText.append(NSAttributedString(string: "\(availableQuantity)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]))

        if availableQuantity == 1 {
            attributedText.append(NSAttributedString(string: "    !Última disponible!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),  NSAttributedString.Key.foregroundColor: UIColor.meliGrey]))
        } else {
            attributedText.append(NSAttributedString(string: " disponibles", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),  NSAttributedString.Key.foregroundColor: UIColor.meliGrey]))
        }
        return attributedText
    }

    func setupInstallmentsAttributedText() -> NSMutableAttributedString {
        
        let imageOffsetY:CGFloat = -5.0
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "creditCard")
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let installmentString = installments > 1 ? "hasta \(installments) cuotas!" : "cuotas!"
        let  textAfterIcon = NSMutableAttributedString(string: "   Pagá en \(installmentString)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),  NSAttributedString.Key.foregroundColor: UIColor.meliBlack])

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let attributedText = NSMutableAttributedString(string: "")
        attributedText.append(attachmentString)
        attributedText.append(textAfterIcon)
        
        return attributedText
    }
    
    func setupShippingAttributedText() -> NSMutableAttributedString {
        
        let imageOffsetY:CGFloat = -5.0
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "deliveryTruck")?.withTintColor(.meliGreen)
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        
        let  textAfterIcon = NSMutableAttributedString(string: "   Envío gratis", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.meliGreen])

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let attributedText = NSMutableAttributedString(string: "")
        
        if freeShipping == true {
            attributedText.append(attachmentString)
            attributedText.append(textAfterIcon)
        } 
        return attributedText
    }
    
    func setupMercadoPagoAttributedText() -> NSMutableAttributedString {
        
        let imageOffsetY:CGFloat = -5.0
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "creditCard")?.withTintColor(.meliBlue)
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        
        let  textAfterIcon = NSMutableAttributedString(string: "   Comprá con MercadoPago y sumá puntos!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),  NSAttributedString.Key.foregroundColor: UIColor.meliBlue])

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let attributedText = NSMutableAttributedString(string: "")
        
        if acceptsMercadopago == true {
            attributedText.append(attachmentString)
            attributedText.append(textAfterIcon)
        }
        return attributedText
    }
}
