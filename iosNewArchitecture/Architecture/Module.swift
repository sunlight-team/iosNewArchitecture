//
//  Module.swift
//  SunlightArchitectureIOS
//
//  Created by lorenc_D_K on 30.04.2025.
//

import SwiftUI
import Combine

// MARK: - ViewState

@MainActor
protocol ViewStateProtocol: ObservableObject, Sendable {
    associatedtype Input
    
    init(input: Input?)
}
    
extension ViewStateProtocol {
func update(_ handler: @Sendable @MainActor (Self) -> Void) async {
    await MainActor.run { handler(self) }
    }
}


// MARK: - ViewModel

protocol ViewModelProtocol: Sendable {
    associatedtype Input
    associatedtype Output
    associatedtype Action
    associatedtype ViewState: ViewStateProtocol
    associatedtype Router: RouterProtocol
    
    @MainActor
    init(state: ViewState, input: Input?, output: Output?, router: Router?)
    
    func handle(_ action: Action) async
}

// MARK: - View

protocol ViewProtocol {
    associatedtype ViewState: ViewStateProtocol
    associatedtype ViewModel: ViewModelProtocol
    
    @MainActor
    init(state: ViewState, reducer: Reducer<ViewModel>)
}

// MARK: - Router

@MainActor
protocol RouterProtocol: Sendable {
    var parentViewController: UIViewController? { get set }
    init()
}

// MARK: - Reducer

final class Reducer<ViewModel>: Sendable where ViewModel: ViewModelProtocol {
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    nonisolated func callAsFunction(_ action: ViewModel.Action) {
        Task { [weak self] in
            await self?.viewModel.handle(action)
        }
    }
}

// MARK: - Module

protocol ModuleProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype ViewState: ViewStateProtocol where ViewState.Input == Input
    associatedtype ViewScene: ViewProtocol where ViewScene.ViewState == ViewState, ViewScene.ViewModel == ViewModel
    associatedtype ViewModel: ViewModelProtocol where ViewModel.Input == Input, ViewModel.Output == Output, ViewModel.ViewState == ViewState, ViewModel.Router == Router
    associatedtype Router: RouterProtocol
}

extension ModuleProtocol {
    @MainActor
    static func build(input: Input? = nil, output: Output? = nil) -> UIViewController {
        let state = ViewState(input: input)
        var router = Router()
        let viewModel = ViewModel(
            state: state,
            input: input,
            output: output,
            router: router
        )
        let reducer = Reducer(viewModel: viewModel)
        let view = ViewScene(state: state, reducer: reducer)
        if let vc = view as? UIViewController {
            router.parentViewController = vc
            return vc
        } else if let view = view as? (any View) {
            let viewController = UIHostingController(rootView: AnyView(view))
            router.parentViewController = viewController
            return viewController
        } else {
            fatalError("Unexpected view type")
        }
    }
}

extension ModuleProtocol where ViewScene: View {
    @MainActor
    static func preview(input: Input? = nil, output: Output? = nil) -> some View {
        let state = ViewState(input: input)
        let router = Router()
        let viewModel = ViewModel(
            state: state,
            input: input,
            output: output,
            router: router
        )
        let reducer = Reducer(viewModel: viewModel)
        return ViewScene(state: state, reducer: reducer)
    }
}

final class Builder<M>: Sendable where M: ModuleProtocol {
    @MainActor
    static func build(input: M.ViewModel.Input? = nil, output: M.ViewModel.Output? = nil) -> UIViewController {
        let state = M.ViewState(input: input)
        var router = M.Router()
        let viewModel = M.ViewModel(
            state: state,
            input: input,
            output: output,
            router: router
        )
        let reducer = Reducer(viewModel: viewModel)
        let view = M.ViewScene(state: state, reducer: reducer)
        if let vc = view as? UIViewController {
            router.parentViewController = vc
            return vc
        } else if let view = view as? (any View) {
            let viewController = UIHostingController(rootView: AnyView(view))
            router.parentViewController = viewController
            return viewController
        } else {
            fatalError("Unexpected view type")
        }
    }
}

extension Builder where M.ViewScene: View {
    @MainActor
    static func preview(input: M.ViewModel.Input? = nil, output: M.ViewModel.Output? = nil) -> some View {
        let state = M.ViewState(input: input)
        let router = M.Router()
        let viewModel = M.ViewModel(
            state: state,
            input: input,
            output: output,
            router: router
        )
        let reducer = Reducer(viewModel: viewModel)
        return M.ViewScene(state: state, reducer: reducer)
    }
}

// MARK: GlobalRouter

@MainActor
final class GlobalRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func push<M: ModuleProtocol>(
        _ module: M.Type,
        input: M.ViewModel.Input? = nil,
        output: M.ViewModel.Output? = nil
    ) {
        let view = M.build(input: input, output: output)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func present<M: ModuleProtocol>(
        _ module: M.Type,
        input: M.ViewModel.Input? = nil,
        output: M.ViewModel.Output? = nil
    ) {
        let view = M.build(input: input, output: output)
        viewController?.present(view, animated: true)
    }
}

