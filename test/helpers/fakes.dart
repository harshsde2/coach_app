import 'package:coach_app/core/storage/token_storage.dart';
import 'package:coach_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:coach_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coach_app/features/auth/data/models/user_dto.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:coach_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository;

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource;

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource;

class MockTokenStorage extends Mock implements TokenStorage;

const testUserDto = UserDto(
  id: 'u1',
  firstName: 'Alex',
  lastName: 'Morgan',
  email: 'alex@example.com',
);

const testUser = User(
  id: 'u1',
  firstName: 'Alex',
  lastName: 'Morgan',
  email: 'alex@example.com',
);
