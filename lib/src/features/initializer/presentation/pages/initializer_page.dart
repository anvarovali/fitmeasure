import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/initializer_bloc.dart';

class InitializerPage extends StatelessWidget {
  const InitializerPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitializerBloc()..add(const InitializerStarted()),
      child: const InitializerView(),
    );
  }
}

class InitializerView extends StatelessWidget {
  const InitializerView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<InitializerBloc, InitializerState>(
      listener: (context, state) {
        if (state is InitializerAuthenticated) {
          context.go('/main');
        } else if (state is InitializerUnauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        body: BlocBuilder<InitializerBloc, InitializerState>(
          builder: (context, state) {
            if (state is InitializerLoading) {
              return const LoadingWidget(message: AppStrings.loading);
            }
            
            return const LoadingWidget(message: 'Initializing app...');
          },
        ),
      ),
    );
  }
}

