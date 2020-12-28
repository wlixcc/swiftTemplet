//
//  GraphTests.swift
//  TempletTests
//
//  Created by wl on 2020/12/8.
//

import XCTest
@testable import Templet


class GraphTests: XCTestCase {


    func testExample() throws {
        let graph = AdjacencyList<String>()

        let singapore = graph.createVertex(data: "Singapore")
        let tokyo = graph.createVertex(data: "Tokyo")
        let hongKong = graph.createVertex(data: "Hong Kong")
        let detroit = graph.createVertex(data: "Detroit")
        let sanFrancisco = graph.createVertex(data: "San Francisco")
        let washingtonDC = graph.createVertex(data: "Washington DC")
        let austinTexas = graph.createVertex(data: "Austin Texas")
        let seattle = graph.createVertex(data: "Seattle")

        graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
        graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
        graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
        graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
        graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
        graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
        graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
        graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
        graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
        graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
        graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
        graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

        print(graph)
    }
    
    func testMatrix() {
        let graph = AdjacencyMatrix<String>()

        let singapore = graph.createVertex(data: "Singapore")
        let tokyo = graph.createVertex(data: "Tokyo")
        let hongKong = graph.createVertex(data: "Hong Kong")
        let detroit = graph.createVertex(data: "Detroit")
        let sanFrancisco = graph.createVertex(data: "San Francisco")
        let washingtonDC = graph.createVertex(data: "Washington DC")
        let austinTexas = graph.createVertex(data: "Austin Texas")
        let seattle = graph.createVertex(data: "Seattle")

        graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
        graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
        graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
        graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
        graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
        graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
        graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
        graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
        graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
        graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
        graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
        graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

        print(graph)
        
    }
    
    func testGraphYourFriends() {
        let graph = AdjacencyList<String>()
        
        let vincent = graph.createVertex(data: "Vincent")
        let chesley = graph.createVertex(data: "Chesley")
        let ruiz = graph.createVertex(data: "Ruiz")
        let patrick = graph.createVertex(data: "Patrick")
        let ray = graph.createVertex(data: "ray")
        let sun = graph.createVertex(data: "Sun")
        let cole = graph.createVertex(data: "Cole")
        let kerry = graph.createVertex(data: "Kerry")
        
        graph.add(.undirected, from: vincent, to: chesley, weight: 1)
        graph.add(.undirected, from: vincent, to: ruiz, weight: 1)
        graph.add(.undirected, from: vincent, to: patrick, weight: 1)
        graph.add(.undirected, from: ruiz, to: ray, weight: 1)
        graph.add(.undirected, from: ruiz, to: sun, weight: 1)
        graph.add(.undirected, from: patrick, to: cole, weight: 1)
        graph.add(.undirected, from: patrick, to: kerry, weight: 1)
        graph.add(.undirected, from: cole, to: ruiz, weight: 1)
        graph.add(.undirected, from: cole, to: vincent, weight: 1)
        print(graph)

        let vincentsFriends = Set(graph.edges(from: vincent).map { $0.destination.data })
        // 交集
        let mutual = vincentsFriends.intersection(graph.edges(from: ruiz).map { $0.destination.data })
        assert(mutual.first == "Cole")
    }

}
