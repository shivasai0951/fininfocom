import 'package:fininfocom/activities/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class drawerService extends StatefulWidget {
  const drawerService({Key? key}) : super(key: key);

  @override
  State<drawerService> createState() => _drawerServiceState();
}

class _drawerServiceState extends State<drawerService> {
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
            child: Text(''),
          ),
          ListTile(
            title: const Text('Dogs image'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder:
                      (context) => const profileActivity()));
            },
          ),
          ListTile(
            title: const Text('Bluetooth'),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
