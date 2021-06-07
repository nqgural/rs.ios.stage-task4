import Foundation

final class CallStation {
    var usersList: Set<User> = []
    var callsList: [Call] = []
    var currentCallUsersList: Array<User> = []
}

extension User: Hashable {

    public func hash(hasher: inout Hasher) {
         hasher.combine(id)
    }
}


extension CallStation: Station {
    func users() -> [User] {
        return Array(usersList)
    }
    
    func add(user: User) {
        usersList.insert(user)
    }
    
    func remove(user: User) {
        usersList.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        
        case let .start(from: user1, to: user2):
            
            let callID = user1.id
            
            if !usersList.contains(user1) { return nil }
            
            let call = Call(id: callID, incomingUser: user2, outgoingUser: user1, status: .calling)
            callsList.append(call)
            currentCallUsersList.append(user1)
            currentCallUsersList.append(user2)
            
            return call.id
            
            
        case .end:
            return nil
        case .answer(from: let from):
            return nil
        }
        return nil
    }
    
    func calls() -> [Call] {
        return callsList
    }
    
    func calls(user: User) -> [Call] {
        []
    }
    
    func call(id: CallID) -> Call? {
        nil
    }
    
    func currentCall(user: User) -> Call? {
        if currentCallUsersList.contains(user) {
            return 
        }
    }
}
