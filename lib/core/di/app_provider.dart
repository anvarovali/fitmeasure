import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import '../network/dio_client.dart';
import '../persistent_storage/local_storage.dart';
import '../persistent_storage/database_helper.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/initializer/presentation/bloc/initializer_bloc.dart';

class AppProvider {
  static List<Provider> get providers => [
    // Network
    Provider<Dio>(
      create: (_) => DioClient.create(),
    ),
    
    // Storage
    Provider<LocalStorage>(
      create: (_) => LocalStorage(),
    ),
    
    Provider<DatabaseHelper>(
      create: (_) => DatabaseHelper(),
    ),
    
    // Blocs
    Provider<AuthBloc>(
      create: (context) => AuthBloc(
        localStorage: context.read<LocalStorage>(),
      ),
    ),
    
    Provider<InitializerBloc>(
      create: (context) => InitializerBloc(
        localStorage: context.read<LocalStorage>(),
      ),
    ),
  ];
}

