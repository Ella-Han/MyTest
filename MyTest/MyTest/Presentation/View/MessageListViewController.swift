//
//  MessageListViewController.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class MessageListViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    
    private var viewModel: MessageListViewModel!
    private let bag = DisposeBag()
    
    static func create(viewModel: MessageListViewModel) -> MessageListViewController {
        let vc = MessageListViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupView()
        bindUI()
    }
    
    private func registerCell() {
        messageTableView.register(UINib(nibName: "ReceivedMessageCell", bundle: nil), forCellReuseIdentifier: "ReceivedMessageCell")
    }

    private func setupView() {
        messageTableView.refreshControl = UIRefreshControl()
    }
    
    private func bindUI() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let pull = messageTableView.refreshControl!.rx.controlEvent(.valueChanged).asDriver()
        
        Driver.merge(viewWillAppear, pull)
            .drive(onNext: {() in
                self.viewModel.fetchMessageList()
            })
            .disposed(by: bag)
        
        viewModel.isFetching
            .asDriverOnErrorJustComplete()
            .drive(messageTableView.refreshControl!.rx.isRefreshing)
            .disposed(by: bag)
        
        viewModel.items
            .asDriverOnErrorJustComplete()
            .drive(messageTableView.rx.items(cellIdentifier: "ReceivedMessageCell", cellType: ReceivedMessageCell.self))
            { (index: Int, itemViewModel: MessageItemViewModel, cell: ReceivedMessageCell) in
                cell.configure(viewModel: itemViewModel)
            }
            .disposed(by: bag)
    }
}
