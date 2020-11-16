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
    func bind(listener: @escaping WrappedValueChangeListener<Wrapped>)
}

class Box<Wrapped>: BoxType {
    var value: Wrapped {
        didSet {
            listeners.forEach { $0(value) }
        }
    }

    private var listeners: [WrappedValueChangeListener<Wrapped>] = []

    func bind(listener: @escaping WrappedValueChangeListener<Wrapped>) {
        listeners.append(listener)
        listener(value)
    }

    init(_ value: Wrapped) {
        self.value = value
    }
}
