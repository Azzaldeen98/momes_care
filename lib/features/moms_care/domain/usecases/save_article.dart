import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/moms_care/domain/entities/signup_entity.dart';

import '../repository/auth_repository.dart';

class SignupUseCase implements UseCase<void,SignUpEntity>{
  
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);
  
  @override
  Future<void> call({SignUpEntity ? params}) {
    return _authRepository.signUp(params!);
  }
  
}