//
//  ChatRoomUseCase.swift
//  MyTest
//
//  Created by 한아름 on 2021/05/22.
//

import Foundation
import RxSwift

final class ChatRoomUseCase {
    
    func fetch() -> Observable<[ChatMessage]> {
        var items = [ChatMessage]()
        
        let lineChange = ["\nline1", "\nline1\nline2", "\nline1\nline2\nline3", "\nline1\nline2\nline3\nline4"]
         
        for i in 0..<100 {
            items.append(ChatMessage(messageId: Int64(i), senderName: "한아름", message: "안녕? \(i) \(lineChange[i%4])"))
        }
        return Observable.just(items)
    }
}
