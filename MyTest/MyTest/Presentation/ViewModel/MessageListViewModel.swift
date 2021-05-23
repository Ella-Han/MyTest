//
//  MessageListViewModel.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol MessageListViewModelInput {
    func viewDidLoad()
    func fetchMessageList()
}

protocol MessageListViewModelOutput {
    var items: PublishRelay<[MessageSection]> { get }
    var isFetching: PublishRelay<Bool> { get }
}

protocol MessageListViewModel: MessageListViewModelInput, MessageListViewModelOutput {}

final class DefaultMessageListViewModel: MessageListViewModel {
    let items = PublishRelay<[MessageSection]>()
    let isFetching = PublishRelay<Bool>()
    
    private let bag = DisposeBag()
    private let useCase = ChatRoomUseCase()
}

extension DefaultMessageListViewModel {
    func viewDidLoad() {
        
    }
    
    func fetchMessageList() {
        self.isFetching.accept(true)
        
        useCase.fetch()
            .asDriverOnErrorJustComplete()
            .drive(onNext: {
                self.isFetching.accept(false)
                let viewModels = $0.map { MessageItemViewModel(chatMsg: $0)}
                self.items.accept([MessageSection(header: 0, items: viewModels)])
            })
            .disposed(by: bag)
    }
}
