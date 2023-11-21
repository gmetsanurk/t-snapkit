//
//  ViewController.swift
//  T-Snapkit
//
//  Created by Georgy on 2023-10-25.
//
import SnapKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "TinkoffBackgroundColor")
        let accountView = AccountView()
        let info = AccountViewInfo(currency: .rub, amount: 1230000, accountName: "Tinkoff Black", cards: [CardThumbnailInfo(image: UIImage(named: "card")!, id: ""), CardThumbnailInfo(image: UIImage(named: "card")!, id: ""), CardThumbnailInfo(image: UIImage(named: "card")!, id: "")])
        accountView.configure(with: info)
        view.addSubview(accountView)
        accountView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }


}

