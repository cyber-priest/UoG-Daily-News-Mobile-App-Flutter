import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uog_daily/engine/EditDataProvider.dart';
import 'package:uog_daily/engine/auth_provider.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/route.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UsePreferences.init();

  runApp(UogDaily());
}

class UogDaily extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomeTheme>(
      create: (_) => CustomeTheme(),
      child: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<CustomeTheme>(context);
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
            create: (_) => AuthProvider(FirebaseAuth.instance)),
        ChangeNotifierProvider(create: (_) => EditDataProvider()),
        ChangeNotifierProvider(create: (_) => LangProvider()),
        StreamProvider(
            create: (context) => context.read<AuthProvider>().user,
            initialData: null)
      ],
      child: MaterialApp(
        title: "UoG Daily",
        routes: RouteGenerator.routes,
        onGenerateRoute: RouteGenerator.generator,
        initialRoute: RouteGenerator.homePage,
        debugShowCheckedModeBanner: false,
        theme: theme.onstart(),
      ),
    );
  }
}
