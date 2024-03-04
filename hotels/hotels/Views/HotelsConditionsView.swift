//
//  HotelsConditionsView.swift
//  hotels
//
//  Created by Arthur on 01.03.2024.
//

import UIKit

enum HotelsConditions: String, CaseIterable {
    case parking = "Parking"
    case gym = "Fitness/Gym"
    case bar = "Bar"
    case wify = "Free WiFi"
    case pool = "Pool"
    case sauna = "Sauna"
    case casino = "Casino"
    case roulette = "Roulette"
    case poker = "Poker"
    case sea = "Access to the sea"
    case restaurant = "Restaurant"
}

final class HotelsConditionsView: UIView {
    var selectedCells: Set<Int> = []
    private lazy var titleLabel = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), title: "Conditions", color: .white)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: .zero, left: .zero, bottom: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 16, right: .zero)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = false
        collection.frame = CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.width - 50, height: .zero)
        collection.allowsMultipleSelection = true
        collection.register(HotelsConditionCell.self, forCellWithReuseIdentifier: HotelsConditionCell.reuseIdentifier)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()

    required init(selected: Set<Int>? = nil) {
        if let selected {
            selectedCells = selected
        }
        super.init(frame: .zero)

        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func Hotels_setupViews() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(22)
        }
        collectionView.layoutIfNeeded()
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(26)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(collectionView.contentSize.height)
        }
    }
}

extension HotelsConditionsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HotelsConditions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HotelsConditionCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelsConditionCell.reuseIdentifier, for: indexPath) as? HotelsConditionCell ?? HotelsConditionCell()
        cell.setTitle(HotelsConditions.allCases[indexPath.row].rawValue)
        cell.isSelected = selectedCells.contains(indexPath.row)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = HotelsConditions.allCases[indexPath.row].rawValue
        let size = (text as NSString).size(withAttributes: [.font: HotelFont.helvetica(style: .medium, size: 18)])
        return .init(width: size.width + 40, height: 46)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HotelsConditionCell else { return }
        cell.isSelected = true
        selectedCells.insert(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HotelsConditionCell else { return }
        cell.isSelected = false
        selectedCells.remove(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.isSelected = selectedCells.contains(indexPath.row)
    }
}

final class HotelsConditionCell: UICollectionViewCell {
    private lazy var title = GradientLabel(font: HotelFont.helvetica(style: .medium, size: 20), title: "test", color: .colorTextFieldText)
    static let reuseIdentifier = "HotelsConditionCell"

    override var isSelected: Bool {
        didSet {
            setColors(isSelected: isSelected)
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Hotels_setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func Hotels_setupCell() {
        setColors(isSelected: self.isSelected)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        backgroundColor = .colorTextField
        title.lineBreakMode = .byClipping
        addSubview(title)
        title.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        setColors(isSelected: self.isSelected)
    }

    func setColors(isSelected: Bool) {
        let titleColors: [UIColor] = isSelected ? [.gradient1, .gradient2, .gradient3, .gradient4] : [.colorTextFieldText, .colorTextFieldText, .colorTextFieldText, .colorTextFieldText]
        title.gradientColors =  titleColors.map({ $0.cgColor })
        layer.borderColor = isSelected ? UIColor.colorTextFieldBorder.cgColor : UIColor.colorTextFieldBorder.cgColor
    }

    func applyTitleGradient(isSelected: Bool) {
        let colors: [UIColor] = isSelected ? [.gradient1, .gradient2, .gradient3, .gradient4] : [.colorTextField]
        if let gradientLayer = title.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.colors = colors
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = title.bounds
            gradientLayer.colors = colors
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            title.layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    func setTitle(_ title: String) {
        self.title.text = title
    }
}
