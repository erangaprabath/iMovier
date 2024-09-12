//
//  CompnayDetailsView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-06.
//
#warning("NOT PART OF THE APP")
import SwiftUI

class AsyncStreamManager {
    
    func getAsyncStream() -> AsyncThrowingStream<Int,Error>{
        AsyncThrowingStream(Int.self) {  continuation in
            self.getFakeData { value in
                continuation.yield(value)
            } onFinish: { error in
                continuation.finish(throwing: error)
            }

        }
    }
    
    func getFakeData(
        newValue:@escaping (_ value : Int) -> Void,
        onFinish:@escaping ( _ error : Error?) -> Void
    ) {
        let items:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute:{
                newValue(item)
                if item == items.last {
                    onFinish(nil)
                }
            })
        }
    }
    
}

@MainActor
final class asyncViewModel:ObservableObject{
    let manager = AsyncStreamManager()
    @Published private(set) var currentNumber:Int = 0
    
    func onViewUpdate(){
        Task {
            do{
                for try await value in manager.getAsyncStream(){
                    currentNumber = value
                }
            }catch{
                print(error)
            }
        }
    }
}


struct AsyncStreamView: View {
    @StateObject private var viewModel = asyncViewModel()
    var body: some View {
        Text("\(viewModel.currentNumber)")
            .onAppear(perform: {
                viewModel.onViewUpdate()
            })
    }
}

#Preview {
    AsyncStreamView()
}
