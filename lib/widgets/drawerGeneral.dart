import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/screens/MiPerfil.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class drawerGeneral extends StatefulWidget {
  const drawerGeneral({super.key});

  @override
  State<drawerGeneral> createState() => _drawerGeneralState();
}

class _drawerGeneralState extends State<drawerGeneral> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 60,
            color: Appcolor.backgroundColor,
            child: DrawerHeader(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.menu, style: const TextStyle(color: Colors.white)),
                  buildLanguageDropdown(),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: Text(l10n.mainScreenTitle),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(l10n.profile),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Miperfil(user: usuarioActual!),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(l10n.logout),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
