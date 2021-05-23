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
         
        let longMsg = ChatMessage(messageId: 0, senderName: "한아름", message: "Afsdkjfksdjfksdwemcsdmcksdmcsdmfkwemf,mcsdkmksdsdjckdscsdkfjdksfjdkfjkdfjkdfjkdjfkdfjdkjfkdfjkdjfkdfjkdjfkdjfkdfjkdjfkdjfkdjfkdsjfksdjfkdsjfkdsjfksdjfksdjfksdjfksdfjksdjfks \(lineChange[3])")
        items.append(longMsg)
        
        for i in 1..<100 {
            items.append(ChatMessage(messageId: i, senderName: "한아름", message: "안녕? \(i) \(lineChange[i%4])"))
        }
        return Observable.just(items)
    }
}
