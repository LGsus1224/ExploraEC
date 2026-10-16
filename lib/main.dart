import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colores del diseño de Stitch (ExploraEC Design System)
const _primario = Color(0xFF0D9488); // turquesa costero
const _primarioOscuro = Color(0xFF00685F);
const _fondo = Color(0xFFF9F9FF);
const _textoPrincipal = Color(0xFF141B2B);
const _textoSecundario = Color(0xFF3D4947);

void main() {
  runApp(const ExploraEcApp());
}

class ExploraEcApp extends StatelessWidget {
  const ExploraEcApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExploraEC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _primario),
        scaffoldBackgroundColor: _fondo,
      ),
      home: const BienvenidaScreen(),
    );
  }
}

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _primario.withValues(alpha: 0.12),
                ),
                child: const Icon(Icons.explore, size: 56, color: _primarioOscuro),
              ),
              const SizedBox(height: 32),
              Text(
                'ExploraEC',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 40,
                  height: 48 / 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                  color: _textoPrincipal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Descubre los mejores lugares cerca de ti',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  height: 24 / 16,
                  color: _textoSecundario,
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primario,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Empezar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
