import 'package:bkm_prototype/models/material.dart';
import 'package:flutter/material.dart';

class EditMaterialScreen extends StatefulWidget {
  final PemakaianBahan? material;
  final bool isEditable;
  final bool isOperator;

  const EditMaterialScreen({
    Key? key,
    this.material,
    this.isEditable = true,
    this.isOperator = false,
  }) : super(key: key);

  @override
  State<EditMaterialScreen> createState() => _EditMaterialScreenState();
}

class _EditMaterialScreenState extends State<EditMaterialScreen> {
  late TextEditingController namaController;
  late TextEditingController jumlahController;
  late TextEditingController uomController;
  late TextEditingController keteranganController;
  late TextEditingController noMaterialController;
  late TextEditingController noBatchController;
  late TextEditingController glAccountController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.material?.namaBahan ?? "");
    jumlahController = TextEditingController(text: widget.material?.jumlahBahan.toString() ?? "");
    uomController = TextEditingController(text: widget.material?.uomBahan ?? "");
    keteranganController = TextEditingController(text: widget.material?.keterangan ?? "");
    noMaterialController = TextEditingController(text: widget.material?.noMaterial ?? "");
    noBatchController = TextEditingController(text: widget.material?.noBatch ?? "");
    glAccountController = TextEditingController(text: widget.material?.glAccount ?? "");
  }

  void _save() {
    final m = PemakaianBahan(
      namaBahan: namaController.text,
      jumlahBahan: double.tryParse(jumlahController.text) ?? 0,
      uomBahan: uomController.text,
      keterangan: keteranganController.text,
      noMaterial: noMaterialController.text,
      noBatch: noBatchController.text,
      glAccount: glAccountController.text,
    );
    Navigator.pop(context, m);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.material == null ? "Tambah Bahan" : "Edit Bahan")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField("Nama Bahan", namaController),
            _buildField("Jumlah", jumlahController, keyboard: TextInputType.number),
            _buildField("Satuan (UOM)", uomController),
            _buildField("Keterangan", keteranganController),
            _buildOperatorField("No Material", noMaterialController),
            _buildOperatorField("No Batch", noBatchController),
            _buildOperatorField("GL Account", glAccountController),
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
      enabled: widget.isEditable && !widget.isOperator,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildOperatorField(String label, TextEditingController c, {TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: c,
      keyboardType: keyboard,
      enabled: widget.isEditable,
      decoration: InputDecoration(labelText: label),
    );
  }
}
