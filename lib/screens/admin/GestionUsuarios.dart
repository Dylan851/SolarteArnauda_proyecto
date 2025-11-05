import 'package:flutter/material.dart';
import 'package:flutter_application/screens/admin/PantallaRegistrosAdmin.dart';
import 'package:flutter_application/services/LogicaUsuarios.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: const Color.fromRGBO(61, 180, 228, 1),
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
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Editar: ${user.getName}'),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirmar eliminación'),
                                    content: Text(
                                      '¿Eliminar a ${user.getName}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text('Eliminar'),
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
                                    SnackBar(
                                      content: Text(
                                        'Eliminado: ${user.getName}',
                                      ),
                                    ),
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
                                final updated = users.firstWhere(
                                  (u) => u.name == user.name,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      (updated.getIsBlocked == true)
                                          ? 'Bloqueado: ${updated.getName}'
                                          : 'Desbloqueado: ${updated.getName}',
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
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaRegistrosAdmin(),
                  ),
                ).then((_) {
                  // refresh list when returning
                  setState(() {
                    users = LogicaUsuarios.getListaUsuarios();
                  });
                });
              },
              child: const Text('Crear Usuario'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
