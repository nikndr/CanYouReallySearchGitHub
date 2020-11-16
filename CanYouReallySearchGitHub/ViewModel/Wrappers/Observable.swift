//
//  Box.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import Foundation

typealias WrappedValueChangeListener<Wrapped> = (Wrapped) -> Void

protocol BoxType {
    associatedtype Wrapped

    var value: Wrapped { get set }
    func subscribe(listener: @escaping WrappedValueChangeListener<Wrapped>)
}

class Observable<Wrapped>: BoxType {
    var value: Wrapped {
        didSet {
            listeners.forEach { $0(value) }
        }
    }

    private var listeners = [WrappedValueChangeListener<Wrapped>]()

    func subscribe(listener: @escaping WrappedValueChangeListener<Wrapped>) {
        listeners.append(listener)
        listener(value)
    }

    init(_ value: Wrapped) {
        self.value = value
    }
}
