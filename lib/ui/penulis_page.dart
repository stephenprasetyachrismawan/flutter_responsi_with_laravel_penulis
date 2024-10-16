import 'package:flutter/material.dart';
import 'package:tokokita/bloc/logout_bloc.dart';
import 'package:tokokita/bloc/penulis_bloc.dart';
import 'package:tokokita/model/penulis.dart';
import 'package:tokokita/ui/login_page.dart';
import 'package:tokokita/ui/penulis_detail.dart';
import 'package:tokokita/ui/penulis_form.dart';

class PenulisPage extends StatefulWidget {
  const PenulisPage({Key? key}) : super(key: key);

  @override
  _PenulisPageState createState() => _PenulisPageState();
}

class _PenulisPageState extends State<PenulisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Penulis'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PenulisForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: PenulisBloc.getPenulis(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListPenulis(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListPenulis extends StatelessWidget {
  final List? list;

  const ListPenulis({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemPenulis(
            penulis: list![i],
          );
        });
  }
}

class ItemPenulis extends StatelessWidget {
  final Penulis penulis;

  const ItemPenulis({Key? key, required this.penulis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PenulisDetail(
                      penulis: penulis,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(penulis.author_name!),
          subtitle: Text(penulis.nationality!),
          trailing: Text(penulis.birth_year.toString()),
        ),
      ),
    );
  }
}
