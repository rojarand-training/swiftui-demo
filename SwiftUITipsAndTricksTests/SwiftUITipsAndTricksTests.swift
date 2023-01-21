//
//  SwiftUITipsAndTricksTests.swift
//  SwiftUITipsAndTricksTests
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import XCTest
@testable import SwiftUITipsAndTricks


struct User {
    let name: String
    let age: Int
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(age)
    }
}

final class UserHashingTests: XCTestCase {
    
    func test_set_holds_different_instances_of_users_despite_their_hash_is_equal() {
        let user1 = User(name: "Rob", age: 40)
        let user2 = User(name: "John", age: 40)
        var users: Set<User> = []
        users.insert(user1)
        users.insert(user2)
        
        XCTAssertEqual(user1.hashValue, user2.hashValue)
        XCTAssertNotEqual(user1, user2)
        XCTAssertEqual(users.count, 2)
    }
    
    func test_conforming_to_hashable_autosynthetizes_equatable() {
        
        XCTAssertEqual(User(name: "Rob", age: 40), User(name: "Rob", age: 40))
        XCTAssertNotEqual(User(name: "John", age: 40), User(name: "Rob", age: 40))
        XCTAssertNotEqual(User(name: "Rob", age: 1), User(name: "Rob", age: 10000000))
    }
}


struct Email {
    let value: String
}

struct GmailUser {
    let name: String
    let email: Email
}

extension GmailUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

//To satisfy the compiler we need to make GmailUser conforming to Equatable
/*
extension GmailUser: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.email.value == rhs.email.value) && (lhs.name == rhs.name)
    }
}
*/


//or make email property conforming to Equatable
extension Email: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}

//or make email property conforming to Hashable
extension Email: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}



final class GmailUserHashingTests: XCTestCase {
   
    func test_set_holds_only_one_instance_of_equal_objects() throws {
        var emailUsers: Set<GmailUser> = []
        emailUsers.insert(GmailUser(name: "Rob", email: Email(value: "rob@gmail.com")))
        emailUsers.insert(GmailUser(name: "Rob", email: Email(value: "rob@gmail.com")))
        XCTAssertEqual(emailUsers.count, 1)
    }
    
    func test_set_holds_multiple_instances_of_different_objects() throws {
        var emailUsers: Set<GmailUser> = []
        emailUsers.insert(GmailUser(name: "Rob", email: Email(value: "rob@gmail.com")))
        emailUsers.insert(GmailUser(name: "Rob", email: Email(value: "")))
        XCTAssertEqual(emailUsers.count, 2)
    }
}
