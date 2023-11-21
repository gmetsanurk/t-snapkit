//
//  AccountView.swift
//  T-Snapkit
//
//  Created by Georgy on 2023-10-25.
//

import SnapKit
import UIKit

class AccountView: UIView {
    //MARK - Public
    func configure(with info: AccountViewInfo) {
        currencyImageView.image = makeCurrencyImage(for: info.currency)
        amountLabel.text = makeAmountLabelText(for: info.currency, amount: info.amount)
        accountNameLabel.text = info.accountName
        cards = info.cards
        collectionView.reloadData()
    }
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Constants
    private enum UIConstants {
        static let cornerRadius: CGFloat = 16
        static let cardWidth: CGFloat = 45
        static let cardHeight: CGFloat = 30
        static let contentInset: CGFloat = 16
        static let currencySignImageSize: CGFloat = 50
        static let xStackSpacing: CGFloat = 16
        static let yStackSpacing: CGFloat = 4
        static let cardsToAccountNameSpacing: CGFloat = 12
        static let amountFontLabelSize: CGFloat = 17
    }
    
    //MARK - Private Properties
    private let currencyImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: UIConstants.amountFontLabelSize)
        return label
    }()
    
    private let accountNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var collectionView: UICollectionView!
    private var cards: [CardThumbnailInfo] = []
}

// MARK: - Private Methods
private extension AccountView {
    func initialize() {
        backgroundColor = UIColor(named: "TinkoffViewsColor")
        layer.cornerRadius = UIConstants.cornerRadius
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.spacing = UIConstants.yStackSpacing
        yStack.addArrangedSubview(amountLabel)
        yStack.addArrangedSubview(accountNameLabel)
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AccountViewCardCell.self, forCellWithReuseIdentifier: String(describing: AccountViewCardCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.cardHeight)
        }
        yStack.addArrangedSubview(collectionView)
        yStack.setCustomSpacing(UIConstants.cardsToAccountNameSpacing, after: accountNameLabel)
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .top
        xStack.spacing = UIConstants.xStackSpacing
        currencyImageView.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.currencySignImageSize)
        }
        xStack.addArrangedSubview(currencyImageView)
        xStack.addArrangedSubview(yStack)
        addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
    
    func makeCurrencyImage(for currency: Currency) -> UIImage? {
        switch currency {
        case .rub:
            return UIImage(named: "rubleImage")
        case .usd:
            return UIImage(systemName: "star")
        case .eur:
            return UIImage(systemName: "star")
        }
    }
    
    func makeAmountLabelText(for сurrency: Currency, amount: Int) -> String {
        var currencySign: String {
            switch сurrency {
            case .rub:
                return "₽"
            case .usd:
                return "$"
            case .eur:
                return "€"
            }
        }
        return "\(amount) \(currencySign)"
    }
}

// MARK: - UICollectionViewDataSource
extension AccountView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AccountViewCardCell.self), for: indexPath) as! AccountViewCardCell
        let image = cards[indexPath.item].image
        cell.configure(with: image)
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AccountView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIConstants.cardWidth, height: UIConstants.cardHeight)
    }
}
