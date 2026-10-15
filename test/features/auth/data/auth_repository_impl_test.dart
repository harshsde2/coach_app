import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/core/storage/auth_tokens.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/models/auth_requests.dart';
import 'package:coach_app/features/auth/data/models/auth_response_dto.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fakes.dart';

void main() {
  late MockAuthRemoteDataSource remote;
  late MockAuthLocalDataSource local;
  late MockTokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  const tokens = AuthTokens(accessToken: 'access', refreshToken: 'refresh');

  setUpAll(() {
    registerFallbackValue(const LoginRequest(email: '', password: ''));
    registerFallbackValue(tokens);
    registerFallbackValue(testUserDto);
  });

  setUp(() {
    remote = MockAuthRemoteDataSource();
    local = MockAuthLocalDataSource();
    tokenStorage = MockTokenStorage();
    repository = AuthRepositoryImpl(
      remote: remote,
      local: local,
      tokenStorage: tokenStorage,
    );
    when(() => tokenStorage.save(any())).thenAnswer((_) async {});
    when(() => tokenStorage.clear()).thenAnswer((_) async {});
    when(() => local.saveUser(any())).thenAnswer((_) async {});
    when(() => local.clear()).thenAnswer((_) async {});
  });

  group('login', () {
    test(
      'normalises the email, stores the session and returns the user',
      () async {
        when(() => remote.login(any())).thenAnswer(
          (_) async => const AuthResponseDto(
            accessToken: 'access',
            refreshToken: 'refresh',
            user: testUserDto,
          ),
        );

        final result = await repository.login(
          email: '  Alex@Example.com ',
          password: 'secret-password',
        );

        expect(result, isA<Ok<Object?>>());
        expect((result as Ok).value, testUser);
        final request =
            verify(() => remote.login(captureAny())).captured.single
                as LoginRequest;
        expect(request.email, 'alex@example.com');
        verify(() => tokenStorage.save(any())).called(1);
        verify(() => local.saveUser(testUserDto)).called(1);
      },
    );

    test('maps a 422 response to a ValidationFailure', () async {
      final requestOptions = RequestOptions(path: '/auth/login');
      when(() => remote.login(any())).thenThrow(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 422,
            data: {'message': 'Incorrect email or password.'},
          ),
        ),
      );

      final result = await repository.login(email: 'a@b.co', password: 'x');

      final failure = (result as Err).failure;
      expect(failure, isA<ValidationFailure>());
      expect(failure.message, 'Incorrect email or password.');
      verifyNever(() => tokenStorage.save(any()));
    });

    test('maps connection errors to a NetworkFailure', () async {
      when(() => remote.login(any())).thenThrow(
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/auth/login'),
          reason: 'offline',
        ),
      );

      final result = await repository.login(email: 'a@b.co', password: 'x');

      expect((result as Err).failure, isA<NetworkFailure>());
    });
  });

  group('restoreSession', () {
    test(
      'returns null without calling the API when there is no token',
      () async {
        when(() => tokenStorage.read()).thenAnswer((_) async => null);

        final result = await repository.restoreSession();

        expect((result as Ok).value, isNull);
        verifyZeroInteractions(remote);
      },
    );

    test('prefers the cached user for an instant start', () async {
      when(() => tokenStorage.read()).thenAnswer((_) async => tokens);
      when(() => local.readUser()).thenAnswer((_) async => testUserDto);

      final result = await repository.restoreSession();

      expect((result as Ok).value, testUser);
      verifyNever(() => remote.getCurrentUser());
    });

    test('fetches and caches the user when nothing is cached', () async {
      when(() => tokenStorage.read()).thenAnswer((_) async => tokens);
      when(() => local.readUser()).thenAnswer((_) async => null);
      when(() => remote.getCurrentUser()).thenAnswer((_) async => testUserDto);

      final result = await repository.restoreSession();

      expect((result as Ok).value, testUser);
      verify(() => local.saveUser(testUserDto)).called(1);
    });
  });

  test('logout clears the local session even if the API call fails', () async {
    when(() => remote.logout()).thenThrow(
      DioException.connectionError(
        requestOptions: RequestOptions(path: '/auth/logout'),
        reason: 'offline',
      ),
    );

    await repository.logout();

    verify(() => tokenStorage.clear()).called(1);
    verify(() => local.clear()).called(1);
  });
}
