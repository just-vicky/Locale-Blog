import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'details.dart';

void main() {
  runApp(
    ChangeNotifierProvider<LocaleProvider>(
      create: (_) => LocaleProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('fr'), // French
      ],
      locale: context.watch<LocaleProvider>().locale,
      home: const HomePage(),
      routes: {
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        actions: [
          IconButton(
            onPressed: () {
              context.read<LocaleProvider>().toggleLocale();
            },
            tooltip: 'Language',
            icon: const Icon(Icons.language),
          )
        ],
      ),
      body: ListView(
        children: [
          buildCard(context,
              title: AppLocalizations.of(context)!.title1,
              details: AppLocalizations.of(context)!.description1),
          buildCard(context,
              title: AppLocalizations.of(context)!.title2,
              details: AppLocalizations.of(context)!.description2),
          buildCard(context,
              title: AppLocalizations.of(context)!.title3,
              details: AppLocalizations.of(context)!.description3),
          // Add more CardItems as needed
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context,
      {required String title, required String details}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details',
            arguments: {'title': title, 'details': details});
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class LocaleProvider with ChangeNotifier {
  late Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void toggleLocale() {
    _locale =
        _locale.languageCode == 'en' ? const Locale('fr') : const Locale('en');
    notifyListeners();
  }
}
