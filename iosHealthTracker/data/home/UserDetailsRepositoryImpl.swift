//
//  UserDetailsRepositoryImpl.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

class UserDetailsRepositoryImpl: UserDetailsRepository {
    
    private let userDetailsService: UserDetailsService
    
    init(userDetailsService: UserDetailsService) {
        self.userDetailsService = userDetailsService
    }
    
    func getUserDetails() async -> Result<UserDetails, HomeError> {
        do {
            let userDetails = try await userDetailsService.getUserDetails()
            return .success(userDetails)
        } catch {
            print("UserDetailsRepositoryImpl: Error fetching user details: \(error)")
            return .failure(.loadingError)
        }
    }
}
