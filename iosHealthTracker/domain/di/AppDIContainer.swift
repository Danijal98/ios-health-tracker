//
//  AppDIContainer.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


import Foundation

final class AppDIContainer {
    
    // MARK: - Services
    let userDetailsService: UserDetailsService

    // MARK: - Repositories
    let userDetailsRepository: UserDetailsRepository
    
    init() {
        // Initialize services
        self.userDetailsService = UserDetailsServiceImpl()
        
        // Initialize repositories
        self.userDetailsRepository = UserDetailsRepositoryImpl(
            userDetailsService: userDetailsService
        )
    }
}
