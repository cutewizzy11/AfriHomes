import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              'Find your next home',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            expandedHeight: 140,
            surfaceTintColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SearchBar(),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _FilterChip(label: 'Lagos'),
                      _FilterChip(label: '₦200k - ₦600k'),
                      _FilterChip(label: 'Apartment'),
                      _FilterChip(label: 'WiFi'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Featured near you', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.74,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _PropertyCard(index: index),
                childCount: _demoImages.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search city, area, or property...',
            ),
          ),
        ),
        const SizedBox(width: 10),
        FilledButton.tonal(
          onPressed: () {},
          child: const Icon(Icons.tune_rounded),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  const _FilterChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: true,
      onSelected: (_) {},
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final int index;
  const _PropertyCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = _demoImages[index % _demoImages.length];
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 11,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
              ),
            ).animate().fadeIn(duration: 350.ms),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('₦${_prices[index % _prices.length]} / month',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                    _titles[index % _titles.length],
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.bed_outlined, size: 18),
                      SizedBox(width: 4),
                      Text('2'),
                      SizedBox(width: 12),
                      Icon(Icons.bathtub_outlined, size: 18),
                      SizedBox(width: 4),
                      Text('1'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> _demoImages = [
  'https://images.unsplash.com/photo-1596484550911-7e4d72f9f06f?q=80&w=1080&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1560448075-bb4caa6cfcf6?q=80&w=1080&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1600607687920-4ce8c559d8df?q=80&w=1080&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1597047084897-51e81819a499?q=80&w=1080&auto=format&fit=crop',
];

const List<String> _titles = [
  'Modern studio in Lekki Phase 1',
  'Cozy 2-bed apartment in Yaba',
  'Furnished self-contained at Surulere',
  'Gated bungalow with WiFi at Ajah',
];

const List<String> _prices = ['250,000', '450,000', '600,000', '350,000'];

