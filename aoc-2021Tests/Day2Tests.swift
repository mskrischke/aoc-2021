//
//  Day2Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 03.12.21.
//

import XCTest

class Day2Tests: XCTestCase {

    enum Dir {
        case forward(Int)
        case down(Int)
        case up(Int)
    }

    func testDay2_1() throws {
        let data = loadData()
        let position = data.reduce(into: (0 ,0)) { (result: inout (horizontal: Int, depth: Int), movement) in
            switch movement.0 {
            case "forward": result.horizontal += movement.1
            case "up" : result.depth -= movement.1
            case "down": result.depth += movement.1
            default: fatalError()
            }
        }
        XCTAssertEqual(position.depth * position.horizontal, 2322630)
    }

    func testDay2_2() throws {
        let data = loadData()
        let position = data.reduce(into: (0 ,0, 0)) { (result: inout (horizontal: Int, aim: Int, depth: Int), movement) in
            switch movement.0 {
            case "forward":
                result.horizontal += movement.1
                result.depth += result.aim * movement.1
            case "down":
                result.aim += movement.1
            case "up":
                result.aim -= movement.1
            default: fatalError()
            }
        }
        XCTAssertEqual(position.depth * position.horizontal, 2105273490)
    }

    func loadData() -> [(String, Int)]{
        let test = """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """

        return loadFile(name: "day2.txt")
            .split(separator: "\n")
            .map { String($0).split(separator: " ") }
            .map { (String($0[0]), Int($0[1])!) }
    }
}
