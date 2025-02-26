//
//  SplashFlowDelegate.swift
//  Nearby
//
//  Created by Eduardo Sant Ana Sales on 26/02/25.
//
//  Navigation protocol class, which serves to expose a function to another class
//

import Foundation

public protocol SplashFlowDelegate: AnyObject {
    func decideNavigationFlow()
}
