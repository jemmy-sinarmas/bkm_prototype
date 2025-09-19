import 'package:bkm_prototype/models/work_result.dart';
import 'package:bkm_prototype/widgets/filtered_plantation_dropdown.dart';
import 'package:flutter/material.dart';

class EditWorkResultScreen extends StatefulWidget {
  final HasilKerja? workResult;
  final bool isEditable;
  final bool isOperator;
  final String unitKerja;
  final String divisi;

  const EditWorkResultScreen({
    super.key,
    this.workResult,
    this.isEditable = true,
    this.isOperator = false,
    required this.unitKerja,
    required this.divisi,
  });

  @override
  State<EditWorkResultScreen> createState() => _EditWorkResultScreenState();
}

class _EditWorkResultScreenState extends State<EditWorkResultScreen> {
  String? selectedComplex;
  String? selectedBlock;
  late TextEditingController jenisPekerjaanController;
  late TextEditingController jumlahHkController;
  late TextEditingController hasilController;
  late TextEditingController uomController;
  late TextEditingController luasBlokController;
  late TextEditingController keteranganController;
  late TextEditingController workOrderController;
  late TextEditingController networkInternalOrderController;
  late TextEditingController costCenterController;
  late TextEditingController operationController;
  late TextEditingController activityTypeController;

  @override
  void initState() {
    super.initState();
    selectedComplex = widget.workResult?.complex;
    selectedBlock = widget.workResult?.noBlok;
    jenisPekerjaanController =
        TextEditingController(text: widget.workResult?.jenisPekerjaan ?? "");
    jumlahHkController =
        TextEditingController(text: widget.workResult?.jumlahHk.toString() ?? "");
    hasilController =
        TextEditingController(text: widget.workResult?.hasil.toString() ?? "");
    uomController =
        TextEditingController(text: widget.workResult?.uomHasil ?? "");
    luasBlokController =
        TextEditingController(text: widget.workResult?.luasBlok.toString() ?? "");
    keteranganController =
        TextEditingController(text: widget.workResult?.keterangan ?? "");
    workOrderController =
        TextEditingController(text: widget.workResult?.workOrder ?? "");
    costCenterController =
        TextEditingController(text: widget.workResult?.costCenter ?? "");
    operationController =
        TextEditingController(text: widget.workResult?.operation ?? "");
    activityTypeController =
        TextEditingController(text: widget.workResult?.activityType ?? "");
  }

  void _save() {
    final wr = HasilKerja(
      complex: selectedComplex ?? '',
      noBlok: selectedBlock ?? '',
      jenisPekerjaan: jenisPekerjaanController.text,
      jumlahHk: double.tryParse(jumlahHkController.text) ?? 0,
      hasil: double.tryParse(hasilController.text) ?? 0,
      uomHasil: uomController.text,
      luasBlok: double.tryParse(luasBlokController.text) ?? 0,
      keterangan: keteranganController.text,
      workOrder: workOrderController.text,
      costCenter: costCenterController.text,
      operation: operationController.text,
      activityType: activityTypeController.text,
    );
    Navigator.pop(context, wr);
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workResult == null ? "Tambah Hasil Kerja" : "Edit Hasil Kerja"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilteredPlantationDropdown(
              unitKerja: widget.unitKerja,
              divisi: widget.divisi,
              selectedComplex: selectedComplex,
              selectedBlock: selectedBlock,
              onComplexChanged: (value) => setState(() => selectedComplex = value),
              onBlockChanged: (value) => setState(() => selectedBlock = value),
              enabled: widget.isEditable && !widget.isOperator,
            ),
            const SizedBox(height: 16),
            _buildField("Luas Blok", luasBlokController, keyboard: TextInputType.number),
            _buildField("Jenis Pekerjaan", jenisPekerjaanController),
            _buildField("Jumlah HK", jumlahHkController, keyboard: TextInputType.number),
            _buildField("Hasil", hasilController, keyboard: TextInputType.number),
            _buildField("Satuan (UOM)", uomController),
            _buildField("Keterangan", keteranganController),
            _buildOperatorField("Work Order", workOrderController),
            _buildOperatorField("Operation", operationController),
            _buildOperatorField("Activity Type", activityTypeController),
            _buildOperatorField("Cost Center", costCenterController),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        keyboardType: keyboard,
        enabled: widget.isEditable && !widget.isOperator,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _buildOperatorField(String label, TextEditingController c, {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        keyboardType: keyboard,
        enabled: widget.isEditable,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
