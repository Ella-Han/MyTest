//
//  MainFlowCoordinator.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import Foundation
import UIKit

final class MainFlowCoordinator {
    
    private weak var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MessageListViewController.create(viewModel: DefaultMessageListViewModel())
        navigationController.pushViewController(vc, animated: false)
    }
}
