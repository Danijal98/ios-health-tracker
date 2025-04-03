//
//  MockUserDetailsRepository.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//


struct MockUserDetailsRepository: UserDetailsRepository {
    func getUserDetails() async -> Result<UserDetails, HomeError> {
        .success(UserDetails(averageHeartRate: 85, averageOxygenSaturation: 97))
    }
}
