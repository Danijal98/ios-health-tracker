//
//  UserDetailsServiceImpl.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/3/25.
//

import Foundation


class UserDetailsServiceImpl: UserDetailsService {
    
    func getUserDetails() async throws -> UserDetails {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // MARK: - Real implementation (commented out)
        /*
        guard let url = URL(string: "https://apimocha.com/healthtracker/userDetails") else {
            throw HomeError.loadingError
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HomeError.loadingError
        }

        let decoded = try JSONDecoder().decode(UserDetails.self, from: data)
        return decoded
        */
        
        // Simulated dummy data
        return UserDetails(
            averageHeartRate: Int.random(in: 75...120),
            averageOxygenSaturation: Int.random(in: 50...100)
        )
    }
}
