//
//  HomeState.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

struct HomeState {
    var isLoading: Bool = false
    var homeError: HomeError? = nil
    var userDetails: UserDetails? = nil
}

enum HomeError: Error {
    case loadingError
    case defaultError
}
