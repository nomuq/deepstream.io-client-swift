
import Foundation

//TODO: Check if this works not sure

/// An array-like type that holds `DeepstreamConfig`s
public struct DeepstreamConfig: ExpressibleByArrayLiteral, Collection, MutableCollection {
    
    // MARK: Typealiases
    
    /// Type of element stored.
    public typealias Element = ConfigOptions
    
    /// Index type.
    public typealias Index = Array<ConfigOptions>.Index
    
    /// Iterator type.
    public typealias Iterator = Array<ConfigOptions>.Iterator
    
    /// SubSequence type.
    public typealias SubSequence = Array<ConfigOptions>.SubSequence
    
    // MARK: Properties
    
    private var backingArray = [ConfigOptions]()
    
    /// The start index of this collection.
    public var startIndex: Index {
        return backingArray.startIndex
    }
    
    /// The end index of this collection.
    public var endIndex: Index {
        return backingArray.endIndex
    }
    
    /// Whether this collection is empty.
    public var isEmpty: Bool {
        return backingArray.isEmpty
    }
    
    /// The number of elements stored in this collection.
    public var count: Index.Stride {
        return backingArray.count
    }
    
    /// The first element in this collection.
    public var first: Element? {
        return backingArray.first
    }
    
    public subscript(position: Index) -> Element {
        get {
            return backingArray[position]
        }
        
        set {
            backingArray[position] = newValue
        }
    }
    
    public subscript(bounds: Range<Index>) -> SubSequence {
        get {
            return backingArray[bounds]
        }
        
        set {
            backingArray[bounds] = newValue
        }
    }
    
    // MARK: Initializers
    
    /// Creates a new `SocketIOClientConfiguration` from an array literal.
    ///
    /// - parameter arrayLiteral: The elements.
    public init(arrayLiteral elements: Element...) {
        backingArray = elements
    }
    
    // MARK: Methods
    
    /// Creates an iterator for this collection.
    ///
    /// - returns: An iterator over this collection.
    public func makeIterator() -> Iterator {
        return backingArray.makeIterator()
    }
    
    /// - returns: The index after index.
    public func index(after i: Index) -> Index {
        return backingArray.index(after: i)
    }
    
    /// Special method that inserts `element` into the collection, replacing any other instances of `element`.
    ///
    /// - parameter element: The element to insert.
    /// - parameter replacing: Whether to replace any occurrences of element to the new item. Default is `true`.
    public mutating func insert(_ element: Element, replacing replace: Bool = true) {
        for i in 0..<backingArray.count where backingArray[i] == element {
            guard replace else { return }
            
            backingArray[i] = element
            
            return
        }
        
        backingArray.append(element)
    }
    
}
    
