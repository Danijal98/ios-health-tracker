//
//  UserDetailsService.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

protocol UserDetailsService {
    func getUserDetails() async throws -> UserDetails
}