//
//  AccountViewInfo.swift
//  T-Snapkit
//
//  Created by Georgy on 2023-10-25.
//

import UIKit

struct AccountViewInfo {
    let currency: Currency
    let amount: Int
    let accountName: String
    let cards: [CardThumbnailInfo]
}

enum Currency {
    case rub
    case usd
    case eur
}

struct CardThumbnailInfo {
    let image: UIImage
    let id: String
}
