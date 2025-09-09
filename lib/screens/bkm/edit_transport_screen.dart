import 'package:bkm_prototype/models/transport.dart';
import 'package:flutter/material.dart';

class EditTransportScreen extends StatefulWidget {
  final Transport? transport;
  final bool isEditable;

  const EditTransportScreen({
    super.key,
    this.transport,
    this.isEditable = true,
  });

  @override
  State<EditTransportScreen> createState() => _EditTransportScreenState();
}

class _EditTransportScreenState extends State<EditTransportScreen> {
  late TextEditingController jenisKendaraanController;
  late TextEditingController noKendaraanController;
  late TextEditingController merkKendaraanController;
  late TextEditingController namaPemakaiController;
  late TextEditingController keperluanController;
  late TextEditingController hmController;
  late TextEditingController kmController;

  @override
  void initState() {
    super.initState();
    jenisKendaraanController = TextEditingController(text: widget.transport?.jenisKendaraan ?? "");
    noKendaraanController = TextEditingController(text: widget.transport?.noKendaraan ?? "");
    merkKendaraanController = TextEditingController(text: widget.transport?.merkKendaraan ?? "");
    namaPemakaiController = TextEditingController(text: widget.transport?.namaPemakai ?? "");
    keperluanController = TextEditingController(text: widget.transport?.keperluan ?? "");
    hmController = TextEditingController(text: widget.transport?.hm.toString() ?? "");
    kmController = TextEditingController(text: widget.transport?.km.toString() ?? "");
  }

  void _save() {
    final t = Transport(
      jenisKendaraan: jenisKendaraanController.text,
      noKendaraan: noKendaraanController.text,
      merkKendaraan: merkKendaraanController.text,
      namaPemakai: namaPemakaiController.text,
      keperluan: keperluanController.text,
      hm: double.tryParse(hmController.text) ?? 0,
      km: double.tryParse(kmController.text) ?? 0,
    );
    Navigator.pop(context, t);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.transport == null ? "Tambah Transport" : "Edit Transport")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField("Jenis Kendaraan", jenisKendaraanController),
            _buildField("No Kendaraan", noKendaraanController),
            _buildField("Merk Kendaraan", merkKendaraanController),
            _buildField("Nama Pemakai", namaPemakaiController),
            _buildField("Keperluan", keperluanController),
            _buildField("HM", hmController, keyboard: TextInputType.number),
            _buildField("KM", kmController, keyboard: TextInputType.number),
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