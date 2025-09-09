import 'package:bkm_prototype/models/worker.dart';
import 'package:flutter/material.dart';

class EditWorkerScreen extends StatefulWidget {
  final DaftarHadir? worker;
  final bool isEditable;

  const EditWorkerScreen({
    Key? key,
    this.worker,
    this.isEditable = true,
  }) : super(key: key);

  @override
  State<EditWorkerScreen> createState() => _EditWorkerScreenState();
}

class _EditWorkerScreenState extends State<EditWorkerScreen> {
  late TextEditingController namaController;
  late TextEditingController noIndukController;
  late TextEditingController pengupahanController;
  late TextEditingController kodeAbsenController;
  late TextEditingController hkController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.worker?.namaPekerja ?? "");
    noIndukController = TextEditingController(text: widget.worker?.noIndukPekerja ?? "");
    pengupahanController = TextEditingController(text: widget.worker?.pengupahan ?? "");
    kodeAbsenController = TextEditingController(text: widget.worker?.kodeAbsen ?? "");
    hkController = TextEditingController(text: widget.worker?.hk.toString() ?? "");
  }

  void _save() {
    final w = DaftarHadir(
      namaPekerja: namaController.text,
      noIndukPekerja: noIndukController.text,
      pengupahan: pengupahanController.text,
      kodeAbsen: kodeAbsenController.text,
      hk: int.tryParse(hkController.text) ?? 0,
    );
    Navigator.pop(context, w);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.worker == null ? "Tambah Pekerja" : "Edit Pekerja")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField("Nama Pekerja", namaController),
            _buildField("No Induk", noIndukController),
            _buildField("Pengupahan", pengupahanController),
            _buildField("Kode Absen", kodeAbsenController),
            _buildField("Hari Kerja (HK)", hkController, keyboard: TextInputType.number),
            const SizedBox(height: 24),
            if (widget.isEditable)
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController c, {TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: c,
      keyboardType: keyboard,
      enabled: widget.isEditable,
      decoration: InputDecoration(labelText: label),
    );
  }
}
