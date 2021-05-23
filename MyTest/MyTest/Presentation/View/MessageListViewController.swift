//
//  MessageListViewController.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MessageListViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    
    private var viewModel: MessageListViewModel!
    private var dataSource: RxTableViewSectionedAnimatedDataSource<MessageSection>?
    private let bag = DisposeBag()
    
    static func create(viewModel: MessageListViewModel) -> MessageListViewController {
        let vc = MessageListViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        makeDataSource()
        setupView()
        bindUI()
    }
    
    private func makeDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<MessageSection> (animationConfiguration: AnimationConfiguration(insertAnimation: .none, reloadAnimation: .none, deleteAnimation: .none), configureCell: { (dataSource: TableViewSectionedDataSource<MessageSection>, tableView: UITableView, indexPath: IndexPath, itemViewModel: TableViewSectionedDataSource<MessageSection>.Item) -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageCell", for: indexPath) as? ReceivedMessageCell else { return UITableViewCell() }
            cell.configure(viewModel: itemViewModel)
            
            return cell
        })
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
            .drive(messageTableView.rx.items(dataSource: dataSource!))
            .disposed(by: bag)
    }
}
extension RxTableViewSectionedAnimatedDataSource {
    
   
}
