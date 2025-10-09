import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/di/app_provider.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/persistent_storage/local_storage.dart' as app_storage;
import 'core/persistent_storage/database_helper.dart';
import 'features/app/presentation/bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local storage
  await app_storage.LocalStorage.init();
  
  // Initialize database
  final databaseHelper = DatabaseHelper();
  await databaseHelper.database;
  
  runApp(const FitMeasureApp());
}

class FitMeasureApp extends StatelessWidget {
  const FitMeasureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: BlocProvider(
        create: (context) => AppBloc(),
        child: MaterialApp.router(
          title: 'Fit Measure',
          theme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
