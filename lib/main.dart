import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_users/core/common/app_colors.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_bloc.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_state.dart';
import 'package:github_users/core/connectivity/connectivity_service.dart';
import 'package:github_users/core/di/app_bloc_providers.dart';
import 'package:github_users/feature/splash/presentation/pages/splash_screen.dart';
import 'package:github_users/generated/l10n.dart';
import 'package:github_users/core/di/locator_service.dart' as di;
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            builder: (context, child) {
              return ConnectivityAwareWidget(
                child: MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                ),
              );
            },
            locale: state.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                background: AppColors.mainBackground,
              ),
              scaffoldBackgroundColor: AppColors.mainBackground,
              textTheme: GoogleFonts.robotoFlexTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBlocProviders(
//       child: BlocBuilder<LanguageBloc, LanguageState>(
//         builder: (context, state) {
//           return MaterialApp(
//             builder: (context, child) {
//               return MediaQuery(
//                 data: MediaQuery.of(context)
//                     .copyWith(textScaler: const TextScaler.linear(1.0)),
//                 child: child!,
//               );
//             },
//             locale: state.locale,
//             localizationsDelegates: const [
//               S.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: S.delegate.supportedLocales,
//             theme: ThemeData.dark().copyWith(
//               colorScheme:
//                   const ColorScheme.dark(background: AppColors.mainBackground),
//               scaffoldBackgroundColor: AppColors.mainBackground,
//             ),
//             debugShowCheckedModeBanner: false,
//             home: const SplashScreen(),
//           );
//         },
//       ),
//     );
//   }
// }

