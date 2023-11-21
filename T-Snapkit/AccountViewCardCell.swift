//
//  AccountViewCardCell.swift
//  T-Snapkit
//
//  Created by Georgy on 2023-10-25.
//

import SnapKit
import UIKit

class AccountViewCardCell: UICollectionViewCell {
    // MARK: Public
    func configure(with image: UIImage) {
        imageView.image = image
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
}

// MARK: - Private Methods
private extension AccountViewCardCell {
    func initialize() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
}
