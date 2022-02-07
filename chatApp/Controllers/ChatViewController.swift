//
//  MessagesViewController.swift
//  chatApp
//
//  Created by Maïlys Perez on 07/02/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

final class ChatViewController: MessagesViewController {

    var messages: [MessageType] = [MessageType]()
    var firstUser: Sender = Sender(senderId: "Chatter1", displayName: "Chatter 1")
    var secondUser: Sender = Sender(senderId: "Chatter2", displayName: "Chatter 2")
    var currentUser: Sender!

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
        messages = []
        currentUser = firstUser
    }
}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, MessageCellDelegate {
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
            
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .lightGray
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.senderId == "Chatter1" {
            avatarView.backgroundColor = .systemPink
        } else if message.sender.senderId == "Chatter2" {
            avatarView.backgroundColor = .systemBlue
        }
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        messages.append(Message(sender: currentUser, messageId: "\(messages.count)", sentDate: Date(), kind: .text(text)))
        self.messagesCollectionView.reloadData()
        inputBar.inputTextView.text = ""
    }
}


