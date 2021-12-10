//
//  Day10Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 10.12.21.
//

import XCTest

class Day10Tests: XCTestCase {

    func testDay10_1() throws {
        let score: [Character: Int] = [")": 3, "]": 57, "}": 1197, ">": 25137]
        let match: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">", ]
        var errorPoints = 0

        for line in loadData() {
            var stack: [Character] = []

            for c in line {
                switch c {
                case "[", "(", "{", "<":
                    stack.append(c)
                case "]", ")", "}", ">":
                    let opener = stack.popLast()
                    if match[opener!] != c {
                        errorPoints += score[c]!
                    }
                default: preconditionFailure()
                }
            }

            if !stack.isEmpty {
                print("Not all parentheses closed")
            }
        }

        XCTAssertEqual(errorPoints, 344193)
    }

    func testDay10_2() throws {
        let score: [Character: Int] = [")": 1, "]": 2, "}": 3, ">": 4]
        let match: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">", ]
        var errorPoints: [Int] = []

    outer:
        for line in loadData() {
            var stack: [Character] = []

            for c in line {
                switch c {
                case "[", "(", "{", "<":
                    stack.append(c)
                case "]", ")", "}", ">":
                    let opener = stack.popLast()
                    if match[opener!] != c {
                        continue outer
                    }
                default: preconditionFailure()
                }
            }

            if !stack.isEmpty {
                print("Not all parentheses closed")

                let points = stack.reversed().reduce(0) { result, c in
                    return result * 5 + score[match[c]!]!
                }
                errorPoints.append(points)
            }
        }

        XCTAssertEqual(errorPoints.sorted()[(errorPoints.count - 1) / 2], 3241238967)
    }

    private func loadData() -> [String] {
        let d = """
            [({(<(())[]>[[{[]{<()<>>
            [(()[<>])]({[<{<<[]>>(
            {([(<{}[<>[]}>{[]{[(<()>
            (((({<>}<{<{<>}{[]{[]{}
            [[<[([]))<([[{}[[()]]]
            [{[{({}]{}}([{[{{{}}([]
            {<[[]]>}<{[{[{[]{()[[[]
            [<(<(<(<{}))><([]([]()
            <{([([[(<>()){}]>(<<{{
            <{([{{}}[<[[[<>{}]]]>[]]
            """
        let d2 = loadFile(name: "day10.txt")
        return d2.split(separator: "\n").map { String($0) }
    }
}
