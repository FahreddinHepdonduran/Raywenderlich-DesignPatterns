// 1
public class MulticastDelegate<ProtocolType> {
    
    // MARK: - DelegateWrapper
    // 2
    private class DelegateWrapper {
        
        weak var delegate: AnyObject?
        
        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }
    
    // MARK: - Instance Properties
    // 1
    private var delegateWrappers: [DelegateWrapper]
    
    // 2
    public var delegates: [ProtocolType] {
        delegateWrappers = delegateWrappers
            .filter { $0.delegate != nil }
        return delegateWrappers.map
            { $0.delegate! } as! [ProtocolType]
    }
    
    // MARK: - Object Lifecycle
    // 3
    public init(delegates: [ProtocolType] = []) {
        delegateWrappers = delegates.map {
            DelegateWrapper($0 as AnyObject)
        }
    }
    
    // MARK: - Delegate Management
    // 1
    public func addDelegate(_ delegate: ProtocolType) {
      let wrapper = DelegateWrapper(delegate as AnyObject)
      delegateWrappers.append(wrapper)
    }

    // 2
    public func removeDelegate(_ delegate: ProtocolType) {
      guard let index = delegateWrappers.firstIndex(where: {
        $0.delegate === (delegate as AnyObject)
      }) else {
        return
      }
      delegateWrappers.remove(at: index)
    }
    
    public func invokeDelegates(_ closure: (ProtocolType) -> ()) {
      delegates.forEach { closure($0) }
    }
}
