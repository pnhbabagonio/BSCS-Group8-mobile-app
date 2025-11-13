import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Upcoming', 'Ongoing', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Column(
        children: [
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategory == index,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = index);
                    },
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5, // Mock data
              itemBuilder: (context, index) {
                return EventListItem(
                  title: 'PSITS Event ${index + 1}',
                  description: 'Description of the event goes here...',
                  date: 'Dec ${15 + index}, 2024',
                  time: '1:00 PM - 4:00 PM',
                  location: 'Main Campus',
                  capacity: 100,
                  registered: 75,
                  status: index % 3 == 0 ? 'upcoming' : 
                          index % 3 == 1 ? 'ongoing' : 'completed',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final int capacity;
  final int registered;
  final String status;

  const EventListItem({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.capacity,
    required this.registered,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'upcoming':
        return Colors.blue;
      case 'ongoing':
        return Colors.green;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getStatusColor(status)),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
            
            const SizedBox(height: 12),
            
            // Event Details
            _buildDetailRow(Icons.calendar_today, '$date • $time'),
            _buildDetailRow(Icons.location_on, location),
            _buildDetailRow(Icons.people, '$registered/$capacity registered'),
            
            const SizedBox(height: 12),
            
            // Progress Bar
            LinearProgressIndicator(
              value: registered / capacity,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(status)),
            ),
            
            const SizedBox(height: 12),
            
            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Register for event
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Register for Event'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}