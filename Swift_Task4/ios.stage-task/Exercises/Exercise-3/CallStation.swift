import Foundation

final class CallStation {
    var usersList: Set<User> = []
    var callsList: [Call] = []
    var currentCallUsersList: [User:Call] = [:]
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
            currentCallUsersList[user1] = call
            currentCallUsersList[user2] = call
            
            return call.id
            
            
        case .end(from: let user1):
            let callID = currentCallUsersList[user1]?.outgoingUser.id
            
            if currentCallUsersList[user1] != nil && currentCallUsersList[user1]?.status == .talk {
                callsList.removeFirst()
                let call = Call(id: callID!, incomingUser: currentCallUsersList[user1]!.incomingUser, outgoingUser: user1, status: .ended(reason: .end))
                callsList.append(call)
                currentCallUsersList[currentCallUsersList[user1]!.incomingUser] = nil
                currentCallUsersList[user1] = nil
            }
            
            
            
            return callID
        
        case .answer(from: let answeringUser):
            let callID = currentCallUsersList[answeringUser]?.outgoingUser.id
            
            if currentCallUsersList[answeringUser] != nil && currentCallUsersList[answeringUser]?.status == .calling {
                callsList.removeFirst()
                let call = Call(id: callID!, incomingUser: answeringUser, outgoingUser: currentCallUsersList[answeringUser]!.outgoingUser, status: .talk)
                callsList.append(call)
                currentCallUsersList[currentCallUsersList[answeringUser]!.outgoingUser] = call
                currentCallUsersList[answeringUser] = call
            }
            
            return callID
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
            return currentCallUsersList[user]
    }
}
