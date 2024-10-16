import 'package:flutter/material.dart';
import 'package:tokokita/bloc/penulis_bloc.dart';
import 'package:tokokita/model/penulis.dart';
import 'package:tokokita/ui/penulis_form.dart';
import 'package:tokokita/ui/penulis_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class PenulisDetail extends StatefulWidget {
  Penulis? penulis;

  PenulisDetail({Key? key, this.penulis}) : super(key: key);

  @override
  _PenulisDetailState createState() => _PenulisDetailState();
}

class _PenulisDetailState extends State<PenulisDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penulis'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Nama : ${widget.penulis!.author_name}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nationality : ${widget.penulis!.nationality}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Birth Year : ${widget.penulis!.birth_year}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PenulisForm(
                  penulis: widget.penulis!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            PenulisBloc.deletePenulis(id: widget.penulis!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PenulisPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
