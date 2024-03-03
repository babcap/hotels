//
//  HotelsHotelDetailsViewController.swift
//  hotels
//
//  Created by Arthur on 03.03.2024.
//

import UIKit

final class HotelsHotelDetailsViewController: UIViewController {

    private let viewModel: HotelViewModel

    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar()
        return view
    }()
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    private let contentStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 36)

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private let infoView = UIView()

    private let titleLabel = UILabel(font: .helvetica(style: .medium, size: 27),
                                     color: .white, lines: 0)
    private let locationLabel = UILabel(font: .helvetica(style: .medium, size: 27),
                                     color: .white, lines: 0)
    private let phoneLabel = UILabel(font: .helvetica(style: .medium, size: 27),
                                     color: .white, lines: 0)
    private let emailLabel = UILabel(font: .helvetica(style: .medium, size: 27),
                                     color: .white, lines: 0)

    private lazy var locationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_location")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var phoneImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_phone")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private lazy var emailImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_email")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_filled_star")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var starLabel: GradientLabel = {
        let view = GradientLabel(font: HotelFont.helvetica(style: .medium, size: 27), color: .colorLocation, alignment: .right)
        let titleColors: [UIColor] = [.gradient1, .gradient2, .gradient3, .gradient4]
        view.gradientColors = titleColors.map({ $0.cgColor })
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var conditionsView: HotelsConditionsView = {
        let view = HotelsConditionsView()
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var bookButton = HotelsGradientButton(type: .custom)
    
    required init(viewModel: HotelViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private init() {
        fatalError("Use init(with:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.onLeftButton = {
            self.navigationController?.popViewController(animated: false)
        }

        HotelsSetupViews()
        setup(with: viewModel)
    }

}

extension HotelsHotelDetailsViewController {

    func setup(with viewModel: HotelViewModel) {
        self.titleLabel.text = viewModel.name
        self.locationLabel.text = viewModel.location
        self.phoneLabel.text = viewModel.phone
        self.emailLabel.text = viewModel.email
        self.starLabel.text = "\(viewModel.starsCount)"
    }
    func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        view.addSubview(conditionsView)
        scrollView.addSubview(contentStackView)
        infoView.addSubview(titleLabel)
        infoView.addSubview(locationImageView)
        infoView.addSubview(locationLabel)
        infoView.addSubview(phoneLabel)
        infoView.addSubview(phoneImageView)
        infoView.addSubview(emailLabel)
        infoView.addSubview(emailImageView)
        infoView.addSubview(starImageView)
        infoView.addSubview(starLabel)
        
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(infoView)
        contentStackView.addArrangedSubview(conditionsView)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottomMargin.equalToSuperview()
        }
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.left.right.equalTo(view).inset(25)
            
        }
        imageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.67)
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(40)
            
        }
        starLabel.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalTo(starImageView.snp.left)
        }

        starImageView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(starLabel.snp.top)
            $0.height.width.equalTo(11)
        }
    
        locationImageView.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.equalTo(titleLabel)
        }
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView)
            $0.left.equalTo(locationImageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(8)
        }

        phoneImageView.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.top.equalTo(locationImageView.snp.bottom).offset(12)
            $0.left.equalTo(locationImageView)
        }
        phoneLabel.snp.makeConstraints {
            $0.centerY.equalTo(phoneImageView)
            $0.left.equalTo(phoneImageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(8)
        }

        emailImageView.snp.makeConstraints {
            $0.width.height.equalTo(17)
            $0.top.equalTo(phoneImageView.snp.bottom).offset(16)
            $0.left.equalTo(phoneImageView)
            $0.bottom.equalToSuperview().offset(16)
        }
        emailLabel.snp.makeConstraints {
            $0.centerY.equalTo(emailImageView)
            $0.left.equalTo(emailImageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(8)
        }

        let bookView = UIView()
        contentStackView.addArrangedSubview(bookView)
        bookView.addSubview(bookButton)
        bookButton.addTarget(self, action: #selector(onBookButton), for: .touchUpInside)
        
        bookButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().inset(30)
            $0.left.right.equalToSuperview()
            $0.height.width.equalTo(59)
        }
        bookButton.setTitle("Book", for: .normal)
        bookButton.isTitleGold = true
    }
    
    
    @objc func onBookButton() {
    }
}
