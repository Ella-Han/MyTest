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
    var items: PublishRelay<[MessageItemViewModel]> { get }
    var isFetching: PublishRelay<Bool> { get }
}

protocol MessageListViewModel: MessageListViewModelInput, MessageListViewModelOutput {}

final class DefaultMessageListViewModel: MessageListViewModel {
    let items = PublishRelay<[MessageItemViewModel]>()
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
                self.items.accept($0.map { MessageItemViewModel(chatMsg: $0)})
            })
            .disposed(by: bag)
    }
}

struct MessageItemViewModel {
    let message: String
    let senderName: String
    
    init(chatMsg: ChatMessage) {
        message = chatMsg.message
        senderName = chatMsg.senderName
    }
}
