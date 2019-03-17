//
//  UIButtonOnEvent.swift
//  MGallery
//
//  Created by Mohammad on 12/25/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import UIKit

fileprivate var bindedEvents: [UIButton:EventBinder] = [:]

fileprivate class EventBinder {

    let event: UIControl.Event
    let button: UIButton
    let handler: UIButton.EventHandler
    let selector: Selector

    required init(
        _ event: UIControl.Event,
        on button: UIButton,
        withHandler handler: @escaping UIButton.EventHandler
        ) {
        self.event = event
        self.button = button
        self.handler = handler
        self.selector = #selector(performEvent(on:ofType:))
        button.addTarget(self, action: self.selector, for: event)
    }

    deinit {
        button.removeTarget(self, action: selector, for: event)
        if let index = bindedEvents.index(forKey: button) {
            bindedEvents.remove(at: index)
        }
    }
}

private extension EventBinder {

    @objc func performEvent(on sender: UIButton, ofType event: UIControl.Event) {
        handler(sender, event)
    }
}

extension UIButton {

    typealias EventHandler = (UIButton, UIControl.Event) -> Void

    func on(_ event: UIControl.Event, handler: @escaping EventHandler) {
        bindedEvents[self] = EventBinder(event, on: self, withHandler: handler)
    }
}
