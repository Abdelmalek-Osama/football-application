import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab2/Screens/favorites_screen.dart';
import 'package:flutter_lab2/Screens/leagues_screen.dart';
import 'package:flutter_lab2/Screens/login.dart';
import 'package:flutter_lab2/Screens/search_favorites_screen.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void handleOnTap(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 15),
              children: <Widget>[
                // favorite
                ListTile(
                  leading: Icon(
                    Icons.favorite_outline,
                  ),
                  title: const Text(
                    'Favorite Players',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesScreen()),
                    );
                  },
                ),
                // leuge
                ListTile(
                  leading: Icon(
                    Icons.sports_soccer,
                  ),
                  title: const Text(
                    'Leagues',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeaguesScreen()),
                    );
                  },
                ),
                // search Favorite
                ListTile(
                  leading: Icon(
                    Icons.search,
                  ),
                  title: const Text(
                    'Search Favorite',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchFavoritesScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
            ),
            onTap: () {
              signOutCurrentUser();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> signOutCurrentUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
