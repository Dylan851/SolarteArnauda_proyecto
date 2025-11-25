import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/screens/admin/editarInformacionAdmin/EditarUsuario.dart';
import 'package:flutter_application/screens/admin/PantallaRegistrosAdmin.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class GestionUsuarios extends StatefulWidget {
  const GestionUsuarios({super.key});

  @override
  State<GestionUsuarios> createState() => _GestionUsuariosState();
}

class _GestionUsuariosState extends State<GestionUsuarios> {
  List users = [];

  void _loadUsers() {
    users = LogicaUsuarios.getListaUsuarios();
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.usersManagementTitle),
        backgroundColor: Appcolor.backgroundColor,
        actions: [Padding(padding: const EdgeInsets.only(right: 8), child: buildLanguageDropdown())],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 8),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(user.getName),
                      subtitle: Text(user.getPassword),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (user.getIsAdmin == true)
                              const Icon(
                                Icons.workspace_premium,
                                color: Colors.amber,
                                size: 20,
                              ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditarUsuario(user: user),
                                  ),
                                ).then((edited) {
                                  if (edited == true) {
                                    setState(() {
                                      users = LogicaUsuarios.getListaUsuarios();
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${l10n.updatedUserPrefix} ${user.getName}'),
                                      ),
                                    );
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(l10n.confirmDeletionTitle),
                                    content: Text('${l10n.confirmDeletionQuestionUserPrefix} ${user.getName}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text(l10n.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: Text(l10n.delete),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  LogicaUsuarios.eliminarUsuario(user.name);
                                  setState(() {
                                    users = LogicaUsuarios.getListaUsuarios();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${l10n.delete} ${user.getName}')),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                (user.getIsBlocked == true)
                                    ? Icons.block_flipped
                                    : Icons.block,
                                color: (user.getIsBlocked == true)
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                LogicaUsuarios.toggleBloqueoUsuario(user.name);
                                setState(() {
                                  users = LogicaUsuarios.getListaUsuarios();
                                });
                                final updated = users.firstWhere((u) => u.name == user.name);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      (updated.getIsBlocked == true)
                                          ? '${l10n.blockedUserPrefix} ${updated.getName}'
                                          : '${l10n.unblockedUserPrefix} ${updated.getName}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Appcolor.backgroundColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaRegistrosAdmin(),
                  ),
                ).then((_) {
                  setState(() {
                    users = LogicaUsuarios.getListaUsuarios();
                  });
                });
              },
              child: Text(l10n.createUser, style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Appcolor.backgroundColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(l10n.returnText, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
