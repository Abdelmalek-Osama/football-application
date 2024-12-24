import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class PlayerCard extends StatefulWidget {
  final String name;
  final String position;
  final String? photoUrl;
  final VoidCallback onTap;

  const PlayerCard({
    Key? key,
    required this.name,
    required this.position,
    this.photoUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  final FirestoreService firestoreService = FirestoreService();
  bool isFavorited = false; // Track if the player is favorited

  @override
  void initState() {
    super.initState();
    _checkIfFavorited(); // Check if the player is already favorited
  }

  Future<void> _checkIfFavorited() async {
    final favoritesCollection = firestoreService.getFavoritesCollection();
    final existingPlayer = await favoritesCollection
        .where('name', isEqualTo: widget.name)
        .get();

    setState(() {
      isFavorited = existingPlayer.docs.isNotEmpty; // Update state based on existence
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFavorited) {
      await firestoreService.removeFavoritePlayer(widget.name); // Remove from favorites
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.name} removed from favorites!')),
      );
    } else {
      try {
        await firestoreService.addFavoritePlayer({
          'name': widget.name,
          'position': widget.position,
          'photoUrl': widget.photoUrl,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.name} added to favorites!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    setState(() {
      isFavorited = !isFavorited; // Toggle the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              if (widget.photoUrl != null)
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.photoUrl!),
                  onBackgroundImageError: (e, s) => Icon(Icons.person),
                ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.position),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited ? Colors.red : null, // Change color based on state
                ),
                onPressed: _toggleFavorite, // Toggle favorite on press
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
