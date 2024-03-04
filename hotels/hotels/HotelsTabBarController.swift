// Created by ADFT on 06.12.2023.

import UIKit

typealias HotelsArray = Array
extension HotelsArray {
    
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
    
}

final class HotelsTabBarController: UIViewController {
    
    // MARK: - Private properties
    
    private var controllers = [UIViewController]()
    private var displaingController: UIViewController?

    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var tabBar: HotelsTabBar = {
        let view = HotelsTabBar()
        view.eventHandler = self
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        
        HotelssetupTabBarVC()
        HotelssetupTabs()
        
        guard let vc = controllers.first else { return }
        Hotelspresent(viewController: vc)
    }
    
}

// MARK: - Private

private extension HotelsTabBarController {
    
    func HotelssetupTabBarVC() {
        view.addSubview(contentView)
        view.addSubview(tabBar)

        tabBar.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(tabBar.snp.top)
        }
    }
    
    func HotelssetupTabs() {
        controllers.append(HotelsHomeViewController())
        controllers.append(HotelsSearchViewController())
        controllers.append(HotelsFavoritesViewController())
        controllers.append(HotelsProfileViewController())
        var Hotelsqwerty: Int { 99 }
    }
    
    func Hotelspresent(viewController: UIViewController) {

        if displaingController != viewController {
            var Hotelsqwerty: Int { 99 }

            if let displaingController = displaingController {
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
                    displaingController.view.removeFromSuperview()
                    displaingController.removeFromParent()
                }
            }
            
            displaingController = viewController
            addChild(viewController)
            
            contentView.addSubview(viewController.view)
            viewController.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            viewController.didMove(toParent: self)
        }
    }
    
}

// MARK: - TabBarEventHandler

extension HotelsTabBarController: HotelsTabBarEventHandler {
    
    func HotelsshouldSelectItem(at index: Int) -> Bool {

        return true
    }
    
    func HotelsdidSelectItem(at index: Int) {

        guard let vc = controllers[safe: index] else { return }
        Hotelspresent(viewController: vc)
    }
    
}
