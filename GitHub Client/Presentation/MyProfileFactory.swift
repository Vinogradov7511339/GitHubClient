//
//  MyProfileFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

protocol MyProfileFactory {
    func makeMyProfileViewController(_ actions: ProfileActions) -> ProfileViewController
}

final class MyProfileFactoryImpl {

    private let dataTransferService: DataTransferService
    private let storage: ProfileLocalStorage

    init(dataTransferService: DataTransferService, storage: ProfileLocalStorage) {
        self.dataTransferService = dataTransferService
        self.storage = storage
    }
}

// MARK: - MyProfileFactory
extension MyProfileFactoryImpl: MyProfileFactory {
    func makeMyProfileViewController(_ actions: ProfileActions) -> ProfileViewController {
        .create(with: createProfileViewModel(actions))
    }
}

private extension MyProfileFactoryImpl {
    func createProfileViewModel(_ actions: ProfileActions) -> ProfileViewModel {
        return ProfileViewModelImpl(useCase: createProfileUseCase(), actions: actions)
    }

    func createProfileUseCase() -> MyProfileUseCase {
        return MyProfileUseCaseImpl(repository: createProfileRepository())
    }

    func createProfileRepository() -> MyProfileRepository {
        return MyProfileRepositoryImpl(dataTransferService: dataTransferService, localStorage: storage)
    }
}
