import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/event_card.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreenstate();
}

class _HomeScreenstate extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: StreamBuilder<QuerySnapshot>(
        // Fetch events from Firestore 'events' collection
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // No data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No events available'));
          }

          // Display list of event cards
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Get event data from Firestore document
              final eventData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              
              return EventCard(
                organization: eventData['society'] ?? 'Unknown',
                organizationIcon: eventData['organizationIcon'] ?? 'assets/images/ieee cs ju logo.jpg',
                eventType: eventData['eventType'] ?? 'Event',
                title: eventData['eventName'] ?? 'No Title',
                presenterName: eventData['presenterName'] ?? 'Unknown',
                description: eventData['eventDescription'] ?? 'No description',
                imageUrl: eventData['eventPoster'],
              );
            },
          );
        },
      ),
    );
  }
}
