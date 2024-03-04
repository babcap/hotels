//
//  HotelsFavoritesViewController.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit

final class HotelsFavoritesViewController: UIViewController {
    
    private var hotels: [HotelViewModel] = {
        var hotels: [HotelViewModel] = [
            .init(name: "Paris Monte-Carlo", country: "Monaco", city: "Monte-Carlo", adress: "Pl. du Casino", phone: "+377 98 06 30 00", email: "resort@sbm.mc", starsCount: 5, photo: UIImage(named: "ic_hotel_first")!, conditions: [.pool, .sauna, .gym, .roulette, .restaurant, .bar]),
            .init(name: "Casino Baden-Baden", country: "Germany", city: "Baden-Bade", adress: "Ludwig-Wilhelm-Platz 4, 76530", phone: "+49 7221 9000", email: "badenbaden@gmail.com", starsCount: 5, photo: UIImage(named: "ic_hotel_second")!, conditions: [.pool, .sauna, .wify, .gym, .poker, .roulette, .restaurant, .bar])
        ]
        guard let hotelsDict = UserDefaults.standard.value(forKey: HotelViewModel.Keys.hotels.rawValue) as? [String: [String:Any]] else {
            return hotels
        }
        hotelsDict.keys.forEach {
            if let hotel = hotelsDict[$0] {
                hotels.append(HotelViewModel.fromDict(hotelsDict: hotel)) 
            }
        }
        return hotels
    }()
    
    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar(isBackButtonHidden: true)
        return view
    }()

    private lazy var headerView: HotelsHomeSearchView = {
        let headerView = HotelsHomeSearchView()
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HotelCell.self, forCellReuseIdentifier: HotelCell.reuseIdentifier)
        tableView.register(SectionSpacerCell.self, forCellReuseIdentifier: SectionSpacerCell.reuseIdentifier)
        tableView.contentInset = .init(top: 30, left: .zero, bottom: .zero, right: .zero)
        
        tableView.bounces = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        HotelsSetupViews()
    }
}

private extension HotelsFavoritesViewController {
    func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
    }
}

extension HotelsFavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath.row)
        var model: HotelViewModel
        if indexPath.row == 1 {
            model = hotels[0]
        } else {
            let index = (indexPath.row - 1)/2
            model = hotels[index]
        }
        let vc = HotelsHotelDetailsViewController(viewModel: model)
        self.navigationController?.pushViewController(vc, animated: false)
    }
 
}

// MARK: - UITableViewDataSource

extension HotelsFavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hotels.count*2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 != 0 {
            let cell: HotelCell = tableView.dequeueReusableCell(withIdentifier: HotelCell.reuseIdentifier, for: indexPath) as! HotelCell
            var model: HotelViewModel
            if indexPath.row == 1 {
                model = hotels[0]
            } else {
                let index = (indexPath.row - 1)/2
                model = hotels[index]
            }
            cell.setupCell(with: model)
            cell.onFeedback = {
                self.showFeedBackAlert()
            }
            return cell
        } else {
            let cell: SectionSpacerCell = tableView.dequeueReusableCell(withIdentifier: SectionSpacerCell.reuseIdentifier, for: indexPath) as! SectionSpacerCell
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 != 0 {
            UITableView.automaticDimension
        } else {
            32
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HotelsHomeSearchView()
        header.onSearchTap = {
            let vc = HotelsSearchViewController(viewModel: $0, isFromHomeScreen: true)
            self.navigationController?.pushViewController(vc, animated: false)
        }
        return header
    }
}
