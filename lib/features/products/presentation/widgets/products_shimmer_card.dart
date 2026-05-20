import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmerGrid extends StatelessWidget {
  const ProductsShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest,
      highlightColor: theme.colorScheme.surface,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => const _ShimmerCard(),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 138,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 4),
                  Container(height: 12, width: 120, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 10, width: 80, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 16, width: 60, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
