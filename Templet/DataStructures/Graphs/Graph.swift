//
//  Graph.swift
//  Templet
//
//  Created by wl on 2020/12/8.
//

import Foundation

public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    
    associatedtype Element
    
    func createVertex(data: Element) -> Vertex<Element>
    
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}

// MARK: 默认实现
extension Graph {
  
  public func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
    addDirectedEdge(from: source, to: destination, weight: weight)
    addDirectedEdge(from: destination, to: source, weight: weight)
  }
  
  public func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
    switch edge {
    case .directed:
      addDirectedEdge(from: source, to: destination, weight: weight)
    case .undirected:
      addUndirectedEdge(between: source, and: destination, weight: weight)
    }
  }
}

// MARK: 获取路径
extension Graph where Element: Hashable {
    func numberOfPaths(from source: Vertex<Element>, to destination: Vertex<Element>) -> Int {
        var numberOfPaths = 0
        var visited: Set<Vertex<Element>> = []
        paths(from: source, to: destination, visited: &visited, pathCount: &numberOfPaths)
        return numberOfPaths
    }
    
    func paths(from source: Vertex<Element>,
               to destination: Vertex<Element>,
               visited: inout Set<Vertex<Element>>,
               pathCount: inout Int) {
        //1. 把sorce加入已访问列表
        visited.insert(source)
        if source == destination {
            //2. 路径 += 1
            pathCount += 1
        } else {
            //3. 获取source的所有路径
            let neighbors = edges(from: source)
            //4. 访问
            for edge in neighbors {
                if !visited.contains(edge.destination) {
                    paths(from: edge.destination, to: destination, visited: &visited, pathCount: &pathCount)
                }
            }
        }
        //把source移出访问列表,这样其他路径可以使用这个顶点
        visited.remove(source)
    }
}

// MARK: BFS
extension Graph where Element: Hashable {
    func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        
        // 1.用于记录需要访问的节点, FIFO确保了所有的节点访问顺序
        var queue = QueueStack<Vertex<Element>>()
        // 2.用于保存已访问的节点
        var enqueued:Set<Vertex<Element>> = []
        // 3.用于记录访问顺序
        var visited: [Vertex<Element>] = []
        
        // 4.第一个需要访问的元素入队列
        queue.enqueue(source)
        enqueued.insert(source)
        
        // 5.对队列进行操作
        while let vertex = queue.dequeue() {
            // 6.加入访问数组
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            neighborEdges.forEach { (edge) in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
        }
        return visited
    }
}

//MARK: DFS
extension Graph where Element: Hashable {

  func depthFirstSearch(from source: Vertex<Element>)
      -> [Vertex<Element>] {
    var stack: Stack<Vertex<Element>> = []
    var pushed: Set<Vertex<Element>> = []
    var visited: [Vertex<Element>] = []

    stack.push(source)
    pushed.insert(source)
    visited.append(source)

    outer: while let vertex = stack.peek() {
        let neighbors = edges(from: vertex)
        guard !neighbors.isEmpty else {
            stack.pop()
            continue
        }
        for edge in neighbors {
            if !pushed.contains(edge.destination) {
                stack.push(edge.destination)
                pushed.insert(edge.destination)
                visited.append(edge.destination)
                continue outer
            }
        }
        stack.pop()
    }

    return visited
  }
}



