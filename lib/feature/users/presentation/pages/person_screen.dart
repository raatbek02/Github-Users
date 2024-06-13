import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_bloc.dart';
import 'package:github_users/core/common/bloc/language_bloc/language_event.dart';
import 'package:github_users/feature/users/presentation/widgets/persons_%20list_widget.dart';
import 'package:github_users/generated/l10n.dart';

class HomePage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 4,
          shadowColor: Colors.black54,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/github_logo.png',
              height: 32,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF24292E), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          title: Text(
            S.of(context).users,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          actions: [
           
            PopupMenuButton<Locale>(
              icon: const Icon(Icons.language, size: 24, color: Colors.white),
              onSelected: (locale) {
                context.read<LanguageBloc>().add(ChangeLanguage(locale));
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                const PopupMenuItem(
                  value: Locale('ru'),
                  child: Text('Русский'),
                ),
              ],
            ),
          ],
        ),
      ),
      body:  UsersList(),
    );
  }
}
