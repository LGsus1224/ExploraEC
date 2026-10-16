import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colores del diseño (mismos tokens que el diseño de Stitch)
const _primario = Color(0xFF0D9488);
const _primarioOscuro = Color(0xFF00685F);
const _secundario = Color(0xFF059669);
const _fondo = Color(0xFFF9F9FF);
const _textoPrincipal = Color(0xFF141B2B);
const _textoSecundario = Color(0xFF3D4947);

/// Pantalla de bienvenida según el artefacto "Bienvenida ExploraEC" de Claude Design.
class BienvenidaScreenClaudeDesign extends StatelessWidget {
  const BienvenidaScreenClaudeDesign({super.key, this.onEmpezar});

  /// Se llama al pulsar "Empezar".
  final VoidCallback? onEmpezar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,
      body: Stack(
        children: [
          // Círculos decorativos de fondo
          Positioned(
            top: -140,
            left: -80,
            child: _Circulo(diametro: 360, color: _primario.withValues(alpha: 0.10)),
          ),
          Positioned(
            bottom: 120,
            right: -120,
            child: _Circulo(diametro: 300, color: _secundario.withValues(alpha: 0.07)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _primario.withValues(alpha: 0.12),
                    ),
                    child: const Icon(
                      Icons.explore_outlined,
                      size: 64,
                      color: _primarioOscuro,
                      semanticLabel: 'Brújula',
                    ),
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
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Text(
                      'Descubre los mejores lugares cerca de ti',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        height: 24 / 16,
                        color: _textoSecundario,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: _secundario.withValues(alpha: 0.25),
                          blurRadius: 32,
                          spreadRadius: -4,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: const Color(0xFF111827).withValues(alpha: 0.08),
                          blurRadius: 12,
                          spreadRadius: -2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onEmpezar ?? () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primario,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const StadiumBorder(),
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.16,
                          ),
                        ),
                        child: const Text('Empezar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Circulo extends StatelessWidget {
  const _Circulo({required this.diametro, required this.color});

  final double diametro;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diametro,
      height: diametro,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
