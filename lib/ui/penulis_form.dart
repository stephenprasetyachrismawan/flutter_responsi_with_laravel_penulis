import 'package:flutter/material.dart';
import 'package:tokokita/bloc/penulis_bloc.dart';
import 'package:tokokita/model/penulis.dart';
import 'package:tokokita/ui/penulis_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class PenulisForm extends StatefulWidget {
  Penulis? penulis;
  PenulisForm({Key? key, this.penulis}) : super(key: key);
  @override
  _PenulisFormState createState() => _PenulisFormState();
}

class _PenulisFormState extends State<PenulisForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PENULIS";
  String tombolSubmit = "SIMPAN";
  final _author_nameTextboxController = TextEditingController();
  final _nationalityTextboxController = TextEditingController();
  final _birth_yearTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.penulis != null) {
      setState(() {
        judul = "UBAH PENULIS";
        tombolSubmit = "UBAH";
        _author_nameTextboxController.text = widget.penulis!.author_name!;
        _nationalityTextboxController.text = widget.penulis!.nationality!;
        _birth_yearTextboxController.text =
            widget.penulis!.birth_year.toString();
      });
    } else {
      judul = "TAMBAH PENULIS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _author_nameTextField(),
                _nationalityTextField(),
                _birth_yearTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Produk
  Widget _author_nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Author Name"),
      keyboardType: TextInputType.text,
      controller: _author_nameTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Author Name harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Produk
  Widget _nationalityTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nationality"),
      keyboardType: TextInputType.text,
      controller: _nationalityTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nationality harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Harga Produk
  Widget _birth_yearTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Birth Year"),
      keyboardType: TextInputType.number,
      controller: _birth_yearTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Birth Year harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.penulis != null) {
                //kondisi update penulis
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Penulis createPenulis = Penulis(id: null);
    createPenulis.author_name = _author_nameTextboxController.text;
    createPenulis.nationality = _nationalityTextboxController.text;
    createPenulis.birth_year = int.parse(_birth_yearTextboxController.text);
    // createPenulis.birth_year = _birth_yearTextboxController.text; --> kode yang salah
    PenulisBloc.addPenulis(penulis: createPenulis).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PenulisPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Penulis updatePenulis = Penulis(id: widget.penulis!.id!);
    updatePenulis.author_name = _author_nameTextboxController.text;
    updatePenulis.nationality = _nationalityTextboxController.text;
    updatePenulis.birth_year = int.parse(_birth_yearTextboxController.text);
    // updatePenulis.birth_year = _birth_yearTextboxController.text; --> kode yang salah
    PenulisBloc.updatePenulis(penulis: updatePenulis).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PenulisPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
