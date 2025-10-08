import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/di/app_provider.dart';
import 'core/navigation/app_router.dart';
import 'core/persistent_storage/local_storage.dart';
import 'core/persistent_storage/database_helper.dart';
import 'features/app/presentation/bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.database; // Initialize database
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
