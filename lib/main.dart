import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'scereens/navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rojolhismrqgexmofvbj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvam9saGlzbXJxZ2V4bW9mdmJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE2MTExNTksImV4cCI6MjA4NzE4NzE1OX0.g8PoQ8srnrwOuaAWh1dLcvi1RDtEIkIXTUj5i0n6WsE',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}