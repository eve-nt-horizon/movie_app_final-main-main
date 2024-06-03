import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/app/app.router.dart';
import 'package:movie/services/firebase_auth_service.dart';
import 'package:stacked_services/stacked_services.dart';

final _navigationService = locator<NavigationService>();
final _firebaseAuthService = locator<FirebaseAuthService>();

class MovieAppDrawer extends StatelessWidget {
  const MovieAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          // ListTile(
          //   title: TextButton(
          //     onPressed: () {},
          //     child: const Text('See all genres'),
          //   ),
          //   onTap: () {
          //     _navigationService.navigateToAllGenresView();
          //   },
          // ),
          ListTile(
            title: TextButton(
              onPressed: () async => await _firebaseAuthService.signOut(),
              child: const Text('Sign Out'),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
