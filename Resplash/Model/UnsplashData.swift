//
//  UnsplashData.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/23/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import Foundation

//"photo"
//Request a single random photo will return one Photo Object.
//Request a user's photos and likes will return an array of Photo objects.
//Each Photo object will have the info of the User who took the photo.
struct PhotoInfo: Codable, Hashable {
    let id: String
    let width: Int
    let height: Int
    var description: String?
    var altDescription: String?
    let urls: ImageUrls
    let user: User
    
}

struct ImageUrls: Codable, Hashable {
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

//"user"
//Request User info will return one User.
//Request User's Following/Follower list will return an array of User objects.
enum UserInfoType {
    case PublicProfile, Followers, Following
}

struct User: Codable, Hashable {
    let id: String
    let username: String
    let name: String
    //other portfolio
    var portfolioUrl: String?
    var bio: String?
    var location: String?
    //unsplash public profile
    let links: UserLinks
    let profileImage: ProfileImage
    var instagramUsername: String?
    let totalLikes: Int
    let totalPhotos: Int
}

struct UserLinks: Codable, Hashable {
    let photos: String
    let likes: String
    let portfolio: String
    let following: String
    let followers: String
}

struct ProfileImage: Codable, Hashable {
    let small: String
    let medium: String
    let large: String
}

//"/search/users"
//For a given search query, an array of Users will be returned.
struct SearchQuery: Codable,Hashable {
    let total: Int
    let totalPages: Int
    let results: [User]
}
