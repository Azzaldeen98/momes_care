  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/features/auth/persention/bloc/auth_bloc/auth_bloc.dart';

import '/features/splash/presentation/widgets/splash_body.dart';
import 'package:moms_care/injection_container.dart' as di;

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context) => di.sl<AuthBloc>(),
    child:const Scaffold(
      backgroundColor: Colors.white,
      body: SplashViewBody(),
    ) ,);

  }
}
