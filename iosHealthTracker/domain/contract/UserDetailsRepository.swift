//
//  UserDetailsRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

protocol UserDetailsRepository {
    func getUserDetails() async -> Result<UserDetails, HomeError>
}
