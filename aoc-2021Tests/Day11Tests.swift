//
//  Day11Tests.swift
//  aoc-2021Tests
//
//  Created by Markus Krischke on 11.12.21.
//

import XCTest

class Day11Tests: XCTestCase {

    class Octo {
        var val: Int
        var flashed = false

        init(val: Int) {
            self.val = val
        }
    }

    func testDay11_1() throws {

        let octos = loadData()
        var flashCounter = 0

        for _ in 0..<100 {
            octos.forEach {
                $0.forEach {
                    $0.flashed = false
                    $0.val += 1
                }
            }

            var someoneFlashed = false
            repeat {
                someoneFlashed = false

                for (rowIndex, row) in octos.enumerated() {
                    for (index, octo) in row.enumerated() {
                        if !octo.flashed && octo.val > 9 {
                            someoneFlashed = true
                            octo.flashed = true
                            flashCounter += 1

                            octos[rowIndex - 1, index - 1].val += 1
                            octos[rowIndex - 1, index].val += 1
                            octos[rowIndex - 1, index + 1].val += 1
                            octos[rowIndex, index - 1].val += 1
                            octos[rowIndex, index + 1].val += 1
                            octos[rowIndex + 1, index - 1].val += 1
                            octos[rowIndex + 1, index].val += 1
                            octos[rowIndex + 1, index + 1].val += 1
                        }
                    }
                }
            } while someoneFlashed

            octos.forEach {
                $0.forEach {
                    if $0.flashed {
                        $0.val = 0
                    }
                }
            }
        }

        XCTAssertEqual(flashCounter, 1620)
    }

    func testDay11_2() throws {

        let octos = loadData()
        var stepCounter = 0

        while !octos.allSatisfy({ $0.allSatisfy({ $0.val == 0 }) }) {
            stepCounter += 1

            octos.forEach {
                $0.forEach {
                    $0.flashed = false
                    $0.val += 1
                }
            }

            var someoneFlashed = false
            repeat {
                someoneFlashed = false

                for (rowIndex, row) in octos.enumerated() {
                    for (index, octo) in row.enumerated() {
                        if !octo.flashed && octo.val > 9 {
                            someoneFlashed = true
                            octo.flashed = true

                            octos[rowIndex - 1, index - 1].val += 1
                            octos[rowIndex - 1, index].val += 1
                            octos[rowIndex - 1, index + 1].val += 1
                            octos[rowIndex, index - 1].val += 1
                            octos[rowIndex, index + 1].val += 1
                            octos[rowIndex + 1, index - 1].val += 1
                            octos[rowIndex + 1, index].val += 1
                            octos[rowIndex + 1, index + 1].val += 1
                        }
                    }
                }
            } while someoneFlashed

            octos.forEach {
                $0.forEach {
                    if $0.flashed {
                        $0.val = 0
                    }
                }
            }
        }

        XCTAssertEqual(stepCounter, 371)
    }

    private func loadData() -> [[Octo]] {
        let d = """
            7147713556
            6167733555
            5183482118
            3885424521
            7533644611
            3877764863
            7636874333
            8687188533
            7467115265
            1626573134
            """
        return d.split(separator: "\n").map { String($0).compactMap { Octo(val: Int(String($0))!) } }
    }
}

extension Array where Element == [Day11Tests.Octo] {

    subscript(row: Int, column: Int) -> Day11Tests.Octo {
        get {
            if row >= 0 && column >= 0 && row < self.count && column < self[row].count {
                return self[row][column]
            }
            return Day11Tests.Octo(val: -1)
        }
        set(newValue) {
            if row >= 0 && column >= 0 && row < self.count && column < self[row].count {
                self[row][column] = newValue
            }
        }
    }
}
