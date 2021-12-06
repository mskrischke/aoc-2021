//
//  Day4Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 04.12.21.
//

import XCTest
import Algorithms

class Day4Tests: XCTestCase {

    func testDay4_1() throws {
        let data = loadData()

        var cards = data.1

        for number in data.0 {
            for index in cards.indices {
                let bingo = cards[index].mark(number)

                if bingo {
                    XCTAssertEqual(cards[index].sum() * number, 38913)
                    return
                }
            }
        }
    }

    func testDay4_2() throws {
        let data = loadData()

        var cards = data.1

        for number in data.0 {
            var indicesOfBingo: Set<Int> = []

            for index in cards.indices {
                let bingo = cards[index].mark(number)

                if bingo {
                    indicesOfBingo.insert(index)
                }
            }

            if !indicesOfBingo.isEmpty {
                if cards.count == 1 {
                    XCTAssertEqual(cards[0].sum() * number, 16836)
                    return
                } else {
                    indicesOfBingo.sorted(by: >).forEach { cards.remove(at: $0) }
                }
            }
        }

    }

    private func loadData() -> ([Int], [BingoCard]) {
        let data = loadFile(name: "day4.txt")

        var lines = data.split(separator: "\n")

        let numbers = String(lines.removeFirst())
            .split(separator: ",")
            .compactMap { Int(String($0)) }

        let cards = lines.chunks(ofCount: 5)
            .map {
                BingoCard(rows: $0
                            .map { $0.split(separator: " ").compactMap { Int($0) }.map { BingoNumber(number: $0) } })
            }

        return (numbers, cards)
    }

    struct BingoNumber {
        var number: Int
        var marked = false
    }

    struct BingoCard {
        var rows: [[BingoNumber]]

        mutating func mark(_ number: Int) -> Bool {
            for (r, ns) in rows.enumerated() {
                for (c, n) in ns.enumerated() {
                    if n.number == number {
                        rows[r][c].marked = true
                    }
                }
            }

            return check()
        }

        func sum() -> Int {
            return rows.flatMap { $0 }.filter { !$0.marked }.map { $0.number }.reduce(0, +)
        }

        func check() -> Bool {
            // all numbers of any row
            if rows.contains(where: { $0.allSatisfy { $0.marked } }) {
                return true
            }

            // all numbers of any column
            if rows.transposed().contains(where: { $0.allSatisfy { $0.marked } }) {
                return true
            }

            return false
        }
    }
}
