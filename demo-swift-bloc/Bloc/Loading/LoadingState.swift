
public class LoadingState: State {
    public let isLoading: Bool
    public init(_ loading: Bool) {
        self.isLoading = loading
    }
}

public class LoadingInitial: LoadingState {
    public init() { super.init(false) }
}

public class LoadingUpdated: LoadingState {
    public init(loading: Bool) {
        super.init(loading)
    }
}
