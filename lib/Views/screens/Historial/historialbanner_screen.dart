
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Banner.dart';


import 'package:gestionresidencial/main.dart';
import 'package:flutter/material.dart';

class BannerScreen extends ConsumerStatefulWidget {
  static const String nombre = 'bannerscreen';
  const BannerScreen({Key? key}) : super(key: key);

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends ConsumerState<BannerScreen> {
  late Future<List<BannerModel>> bannersList;

  @override
  void initState() {
    super.initState();
    bannersList = ref.read(bannerProvider.notifier).getAll();
  }

  Future<void> _deleteBanner(String id) async {
    if (id != null && id.isNotEmpty) {
      try {
        await ref.read(bannerProvider.notifier).delete(id);
        print("Se ha eliminado el banner");
      } catch (e) {
        print(e);
      }
    } else {
      print("El ID del banner está vacío");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banners'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<BannerModel>>(
          future: bannersList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay banners'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final banner = snapshot.data![index];
                  return Dismissible(
                    key: Key(banner.id ?? ''),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        _deleteBanner(banner.id ?? '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Banner eliminado"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: ListTile(
                      title: Text(banner.titulo ?? ''),
                      subtitle: Text(banner.descripcion ?? ''),
                      // Aquí puedes mostrar más detalles del banner si es necesario
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
