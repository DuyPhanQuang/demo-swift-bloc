//
//  ContactBloc.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Combine
import Repository
import SwiftBloc

public class ContactBloc: BaseBloc<ContactEvent, ContactState> {
    private var contactInteractor: ContactInteractor
    
    public init(key: String, closeWithBlocKey: String? = nil, contact: Contact, interactor: ContactInteractor) {
        self.contactInteractor = interactor
        
        super.init(
            key: key,
            closeWithBlocKey: closeWithBlocKey,
            inititalState: ContactInitial(contact: contact)
        )
        
        onEvent(ContactEdited.self, handler: { [weak self] event, emitter in
            self?.onContactEditedEvent(event: event, emitter: emitter)
        })
    }
    
    private func onContactEditedEvent(event: ContactEdited, emitter: Emitter<ContactState>) {
        emitter.send(ContactEditInProgress(contact: state.contact))
        print("CONTACT EDIT")
        showAppLoading()
        
        self.contactInteractor.editContactById(contact: event.contact)
            .delay(for: 2, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    if let self = self {
                        // handleException()
                        
                        emitter.send(ContactEditFailure(contact: self.state.contact))
                    }
                }
                self?.hideAppLoading()
            }, receiveValue: { updatedContact in
                let nextState = ContactEditSuccess(contact: updatedContact)
                emitter.send(nextState)
            })
            .store(in: &self.disposables)
    }
}

