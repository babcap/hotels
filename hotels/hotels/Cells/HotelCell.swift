//
//  HotelCell.swift
//  hotels
//
//  Created by Arthur on 03.03.2024.
//

import UIKit

struct HotelViewModel {
    enum Keys: String {
        case hotels
        case name
        case counrty
        case city
        case adress
        case phone
        case email
        case starsCount
        case photoPath
        case photo
        case conditions
        case isFavorite
    }
    
    let name: String
    let country: String
    let city: String
    let adress: String
    var phone: String?
    var email: String?
    let starsCount: Int
    let photo: UIImage
    var photoPath: String?
    let conditions: Set<HotelsConditions>
    var isFavorite: Bool = false
    
    var location: String {
        [country, city, adress].joined(separator: ",")
    }

    func matchedConditions(with matches: Set<HotelsConditions>) -> Set<HotelsConditions> {
        return conditions.intersection(matches)
    }

    func toDict() -> [String: [String: Any]] {
        var dict: [String: Any] = [:]
        dict[HotelViewModel.Keys.name.rawValue] = name
        dict[HotelViewModel.Keys.counrty.rawValue] = country
        dict[HotelViewModel.Keys.city.rawValue] = city
        dict[HotelViewModel.Keys.adress.rawValue] = adress
        dict[HotelViewModel.Keys.phone.rawValue] = phone
        dict[HotelViewModel.Keys.email.rawValue] = email
        dict[HotelViewModel.Keys.starsCount.rawValue] = "\(starsCount)"
        dict[HotelViewModel.Keys.photoPath.rawValue] = photoPath
        dict[HotelViewModel.Keys.conditions.rawValue] = conditions.enumerated().map({
            $0.0
        })
        dict[HotelViewModel.Keys.isFavorite.rawValue] = isFavorite
        return [name: dict]
    }

    static func fromDict(hotelsDict: [String: Any]) -> HotelViewModel {
        let name = hotelsDict[HotelViewModel.Keys.name.rawValue] as? String ?? ""
        let country = hotelsDict[HotelViewModel.Keys.counrty.rawValue] as? String ?? ""
        let city = hotelsDict[HotelViewModel.Keys.city.rawValue] as? String ?? ""
        let adress = hotelsDict[HotelViewModel.Keys.adress.rawValue] as? String ?? ""
        let phone = hotelsDict[HotelViewModel.Keys.phone.rawValue] as? String ?? ""
        let email = hotelsDict[HotelViewModel.Keys.email.rawValue] as? String ?? ""
        let starsCount = Int(hotelsDict[HotelViewModel.Keys.starsCount.rawValue] as? String ?? "") ?? 1
        let isFavorite = hotelsDict[HotelViewModel.Keys.isFavorite.rawValue] as? Bool ?? false
        let photoPath = hotelsDict[HotelViewModel.Keys.photoPath.rawValue] as? String ?? ""
        let photo = HotelsPhotoManager.shared.loadImageFromDiskWith(fileName: photoPath) ?? UIImage(named: "ic_hotel_first")!
        let conditions = hotelsDict[HotelViewModel.Keys.conditions.rawValue] as? Set<HotelsConditions> ?? Set<HotelsConditions>()
        return .init(name: name, country: country, city: city, adress: adress, phone: phone, email: email, starsCount: starsCount, photo: photo, conditions: conditions, isFavorite: isFavorite)
    }
}

final class SectionSpacerCell: UITableViewCell {
    static let reuseIdentifier = "SectionSpacerCell"
}

final class HotelCell: UITableViewCell {

    static let reuseIdentifier = "HotelCell"
    var onFeedback: Hotels_VoidBlock?

    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorCellBacground
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 27), color: .white)
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var locationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_location")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var locationLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .regular, size: 16), color: .colorLocation)
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_filled_star")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var hotelsImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.colorImageBorder.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 18
        return view
    }()

    private lazy var starLabel: GradientLabel = {
        let view = GradientLabel(font: HotelFont.helvetica(style: .medium, size: 27), color: .colorLocation, alignment: .right)
        let titleColors: [UIColor] = [.gradient1, .gradient2, .gradient3, .gradient4]
        view.gradientColors = titleColors.map({ $0.cgColor })
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var middleView: HotelsFilledGradientView = {
        let view = HotelsFilledGradientView()
        view.isCornered = true
        return view
    }()

    private lazy var firstConditionView: UIView = {
       let view = UIView()
        return view
    }()
    private lazy var secondConditionView: UIView = {
        let view = UIView()
         return view
     }()
    private lazy var thirdConditionView: UIView = {
        let view = UIView()
         return view
     }()
    private lazy var fourthConditionView: UIView = {
        let view = UIView()
         return view
     }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorSeparator
        return view
    }()

    private lazy var conditionsView = UIView()
    private lazy var feedBackButton: HotelsGradientButton = {
        let view = HotelsGradientButton()
        view.setTitle("Feedback", for: .normal)
        view.setTitleColor(.colorBlackText, for: .normal)
        view.isBacgroundGold = true
        view.isCornered = true
        view.clipsToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        HotelsSetupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 40
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.colorBorder.cgColor

        self.layer.masksToBounds = true
    }

    func setupCell(with viewModel: HotelViewModel) {
        self.titleLabel.text = viewModel.name
        self.locationLabel.text = viewModel.location
        self.starLabel.text = "\(viewModel.starsCount)"
        self.hotelsImageView.image = viewModel.photo
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled, !isHidden, alpha >= 0.01, self.point(inside: point, with: event) else { return self }
        if self.feedBackButton.point(inside: convert(point, to: feedBackButton), with: event) {
            return self.feedBackButton
        } else { return nil }
    }
}

private extension HotelCell {
    func HotelsSetupViews() {
        addSubview(topView)
        addSubview(middleView)
        addSubview(feedBackButton)
        topView.addSubview(titleLabel)
        topView.addSubview(locationImageView)
        topView.addSubview(locationLabel)
        topView.addSubview(starImageView)
        topView.addSubview(starLabel)

        setupConditions(conditions: Set(HotelsConditions.allCases.prefix(4)))
        middleView.addSubview(conditionsView)
        middleView.addSubview(separatorView)
        middleView.addSubview(hotelsImageView)

        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalTo(starLabel.snp.left).inset(8)
            $0.height.equalTo(40)
        }

        locationImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalTo(titleLabel.snp.left).offset(4)
            $0.height.width.equalTo(17)
        }

        locationLabel.snp.makeConstraints {
            $0.left.equalTo(locationImageView.snp.right).offset(10)
            $0.centerY.equalTo(locationImageView.snp.centerY)
            $0.right.equalTo(starLabel.snp.left).inset(8)
            $0.height.equalTo(24)
            $0.bottom.equalTo(topView.snp.bottom).inset(20)
        }

        starLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(40)
            $0.width.equalTo(20)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }

        starImageView.snp.makeConstraints {
            $0.left.equalTo(starLabel.snp.right)
            $0.top.equalTo(starLabel.snp.top)
            $0.height.width.equalTo(11)
        }

        middleView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
        }

        conditionsView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.right.equalTo(middleView.snp.centerX).inset(24)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(24)
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
        }

        hotelsImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(hotelsImageView.snp.width)
            $0.left.equalTo(separatorView.snp.right).offset(24)
        }

        feedBackButton.snp.makeConstraints {
            $0.top.equalTo(middleView.snp.bottom)
            $0.height.equalTo(59)
            $0.left.right.bottom.equalToSuperview()
        }
    
        feedBackButton.addTarget(self, action: #selector(onFeedbackButton), for: .touchUpInside)
    }

    @objc func onFeedbackButton() {
        onFeedback?()
    }

    func setupConditions(conditions: Set<HotelsConditions>) {
        conditionsView.backgroundColor = .clear
        conditionsView.addSubview(firstConditionView)
        conditionsView.addSubview(secondConditionView)
        conditionsView.addSubview(thirdConditionView)
        conditionsView.addSubview(fourthConditionView)
    
        firstConditionView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(46)
        }
        secondConditionView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(firstConditionView.snp.bottom).offset(8)
            $0.height.equalTo(46)
        }
        thirdConditionView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(secondConditionView.snp.bottom).offset(8)
            $0.height.equalTo(46)
        }
        fourthConditionView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(thirdConditionView.snp.bottom).offset(8)
            $0.height.equalTo(46)
            $0.bottom.equalToSuperview()
        }
        conditions.enumerated().forEach {
            let titleLabel = GradientLabel(font: .helvetica(style: .regular, size: 20), title: $1.rawValue)
            let titleColors: [UIColor] = [.gradient1, .gradient2, .gradient3, .gradient4]
            titleLabel.gradientColors =  titleColors.map({ $0.cgColor })

            switch $0 {
            case 0:
                firstConditionView.addSubview(titleLabel)
            case 1:
                secondConditionView.addSubview(titleLabel)
            case 2:
                thirdConditionView.addSubview(titleLabel)
            case 3:
                fourthConditionView.addSubview(titleLabel)
            default: break
            }

            titleLabel.snp.makeConstraints {
                $0.left.equalToSuperview().offset(28)
                $0.right.equalToSuperview().inset(28)
                $0.centerY.equalToSuperview()
            }
        }
    }
}
