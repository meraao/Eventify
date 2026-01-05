import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String organization;
  final String organizationIcon; // Image URL or asset path
  final String eventType;
  final String title;
  final String presenterName;
  final String description;
  final String? imageUrl; // Event poster image

  const EventCard({
    super.key,
    required this.organization,
    required this.organizationIcon,
    required this.eventType,
    required this.title,
    required this.presenterName,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFFE8FFD7), // Light green background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color(0xFFE8FFD7), // Light green for header
              ),
              child: Row(
                children: [
                  // Organization Icon
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: organizationIcon.startsWith('http')
                        ? NetworkImage(organizationIcon)
                        : AssetImage(organizationIcon) as ImageProvider,
                    backgroundColor: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  // Organization Name and Type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organization,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          eventType,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // More Options Icon
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Image Section
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.image_not_supported, size: 48),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image_outlined, size: 48, color: Colors.grey),
                    ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ) ?? const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Presenter Name
                  Text(
                    'by $presenterName',
                    style: textTheme.bodyMedium ?? const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    description,
                    style: (textTheme.bodyMedium ?? const TextStyle(fontSize: 14)).copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text('Details'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Participate'),
                      ),
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

