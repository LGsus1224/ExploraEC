import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gastos_controller.dart';
import '../theme/app_theme.dart';

/// Fila de chips para filtrar los gastos por categoría: «Todas» y una opción
/// por cada categoría que aparece en los gastos cargados.
class FiltroCategorias extends StatelessWidget {
  const FiltroCategorias({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<GastosController>();
    return Obx(() {
      final elegida = controlador.categoriaFiltro.value;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            ChoiceChip(
              label: const Text('Todas'),
              selected: elegida == null,
              onSelected: (_) => controlador.filtrarPorCategoria(null),
            ),
            for (final categoria in controlador.categoriasPresentes) ...[
              const SizedBox(width: AppSpacing.sm),
              ChoiceChip(
                label: Text(categoria),
                selected: elegida == categoria,
                onSelected: (_) => controlador.filtrarPorCategoria(categoria),
              ),
            ],
          ],
        ),
      );
    });
  }
}
