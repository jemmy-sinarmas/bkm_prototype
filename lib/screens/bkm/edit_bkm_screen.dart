import 'package:bkm_prototype/models/material.dart';
import 'package:bkm_prototype/models/transport.dart';
import 'package:bkm_prototype/models/work_result.dart';
import 'package:bkm_prototype/models/worker.dart';
import 'package:bkm_prototype/screens/bkm/edit_material_screen.dart';
import 'package:bkm_prototype/screens/bkm/edit_work_result_screen.dart';
import 'package:bkm_prototype/screens/bkm/edit_worker_screen.dart';
import 'package:bkm_prototype/screens/bkm/edit_transport_screen.dart';
import 'package:bkm_prototype/constants/unit_kegiatan.dart';
import 'package:bkm_prototype/widgets/unit_division_dropdown.dart';
import 'package:bkm_prototype/services/bkm_data_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/bkm.dart';
import '../../models/user.dart';
import '../../theme/app_theme.dart';

class EditBKMScreen extends StatefulWidget {
  final BKM bkm;
  final bool isEditable;
  final UserType userType;

  const EditBKMScreen({
    super.key,
    required this.bkm,
    this.isEditable = true,
    required this.userType,
  });

  @override
  _EditBKMScreenState createState() => _EditBKMScreenState();
}

class _EditBKMScreenState extends State<EditBKMScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BKM _editableBkm;
  final BKMDataService _bkmService = BKMDataService();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _editableBkm = _copyBkm(widget.bkm);
  }

  BKM _copyBkm(BKM original) {
    return BKM(
      noSeriBkm: original.noSeriBkm,
      unitKerja: original.unitKerja,
      divisi: original.divisi,
      kemandoran: original.kemandoran,
      namaMandor: original.namaMandor,
      unitKegiatan: original.unitKegiatan,
      tanggalKegiatan: original.tanggalKegiatan,
      status: original.status,
      workResults: List.from(original.workResults),
      materials: List.from(original.materials),
      workers: List.from(original.workers),
      transports: List.from(original.transports),
    );
  }

  void _save() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }
    _bkmService.updateBKM(_editableBkm);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document saved successfully')),
    );
    Navigator.pop(context, _editableBkm);
  }

  void _goBack() {
    Navigator.pop(context);
  }

  Widget _buildTab(IconData icon, String text) {
    return Tab(
      height: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ GENERAL TAB ============
  Widget _buildGeneralInfoTab() {
    return Container(
      decoration: AppTheme.gradientBackground,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "General Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildField("No Seri BKM", _editableBkm.noSeriBkm, (val) => _editableBkm.noSeriBkm = val),
                  const SizedBox(height: 16),
                  _buildUnitDivisionDropdowns(),
                  const SizedBox(height: 16),
                  _buildField("Kemandoran", _editableBkm.kemandoran, (val) => _editableBkm.kemandoran = val),
                  const SizedBox(height: 16),
                  _buildField("Nama Mandor", _editableBkm.namaMandor, (val) => _editableBkm.namaMandor = val),
                  const SizedBox(height: 16),
                  _buildUnitKegiatanDropdown(),
                  const SizedBox(height: 16),
                  _buildDateField(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Status: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      AppTheme.statusChip(_editableBkm.status),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitDivisionDropdowns() {
    return UnitDivisionDropdown(
      selectedUnit: _editableBkm.unitKerja,
      selectedDivision: _editableBkm.divisi,
      onUnitChanged: (value) => setState(() => _editableBkm.unitKerja = value ?? ''),
      onDivisionChanged: (value) async {
        if (value != _editableBkm.divisi && _editableBkm.workResults.isNotEmpty) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Confirm Division Change'),
              content: const Text('Changing estate/division will remove all work result data. Continue?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Continue')),
              ],
            ),
          );
          if (confirm == true) {
            setState(() {
              _editableBkm.divisi = value ?? '';
              _editableBkm.workResults.clear();
              _editableBkm.materials.clear();
              _editableBkm.workers.clear();
              _editableBkm.transports.clear();
            });
          }
        } else {
          setState(() => _editableBkm.divisi = value ?? '');
        }
      },
      enabled: widget.isEditable && widget.userType != UserType.operator,
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[50],
      ),
      child: ListTile(
        leading: const Icon(Icons.calendar_today, color: AppTheme.primaryColor),
        title: const Text("Tanggal Kegiatan"),
        subtitle: Text(
          "${_editableBkm.tanggalKegiatan.day}/${_editableBkm.tanggalKegiatan.month}/${_editableBkm.tanggalKegiatan.year}",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: widget.isEditable && widget.userType != UserType.operator
            ? IconButton(
                icon: const Icon(Icons.edit, color: AppTheme.primaryColor),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _editableBkm.tanggalKegiatan,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() => _editableBkm.tanggalKegiatan = date);
                  }
                },
              )
            : null,
      ),
    );
  }

  Widget _buildField(String label, String value, Function(String) onSaved) {
    return widget.isEditable && widget.userType != UserType.operator
        ? TextFormField(
            initialValue: value,
            decoration: InputDecoration(labelText: label),
            onSaved: (val) => onSaved(val ?? ''),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text("$label: $value"),
          );
  }

  Widget _buildUnitKegiatanDropdown() {
    return widget.isEditable && widget.userType != UserType.operator
        ? DropdownButtonFormField<String>(
            initialValue: _editableBkm.unitKegiatan.isEmpty ? null : _editableBkm.unitKegiatan,
            decoration: const InputDecoration(labelText: "Unit Kegiatan"),
            items: UnitKegiatanConstants.options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _editableBkm.unitKegiatan = newValue ?? '';
              });
            },
            onSaved: (String? value) {
              _editableBkm.unitKegiatan = value ?? '';
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text("Unit Kegiatan: ${_editableBkm.unitKegiatan}"),
          );
  }

  // ============ WORK RESULTS TAB ============
  Widget _buildWorkResultsTab() {
    return Container(
      decoration: AppTheme.gradientBackground,
      child: Stack(
        children: [
          _editableBkm.workResults.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.work_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        "No Hasil Kerja",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _editableBkm.workResults.length,
                  itemBuilder: (context, index) {
                    final h = _editableBkm.workResults[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: AppTheme.cardDecoration,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pekerjaan #${h.noUrutPekerjaan}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        h.jenisPekerjaan,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    _buildActionButton(
                                      Icons.visibility,
                                      Colors.blue,
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditWorkResultScreen(
                                              workResult: h,
                                              isEditable: false,
                                              unitKerja: _editableBkm.unitKerja,
                                              divisi: _editableBkm.divisi,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    if (widget.isEditable)
                                      _buildActionButton(
                                        Icons.edit,
                                        AppTheme.warningColor,
                                        () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => EditWorkResultScreen(
                                                workResult: h,
                                                isEditable: true,
                                                isOperator: widget.userType == UserType.operator,
                                                unitKerja: _editableBkm.unitKerja,
                                                divisi: _editableBkm.divisi,
                                              ),
                                            ),
                                          );
                                          if (result != null) {
                                            setState(() {
                                              _editableBkm.workResults[index] = result;
                                            });
                                          }
                                        },
                                      ),
                                    if (widget.isEditable && widget.userType != UserType.operator)
                                      _buildActionButton(
                                        Icons.delete,
                                        AppTheme.errorColor,
                                        () {
                                          setState(() => _editableBkm.workResults.removeAt(index));
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(Icons.business, "Complex", h.complex),
                            _buildInfoRow(Icons.grid_view, "No Blok", h.noBlok),
                            _buildInfoRow(Icons.square_foot, "Luas Blok", "${h.luasBlok} ha"),
                            _buildInfoRow(Icons.people, "Jumlah HK", h.jumlahHk.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          if (widget.isEditable && widget.userType != UserType.operator)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton.extended(
                heroTag: "addWorkResult",
                onPressed: () async {
                  final newItem = HasilKerja();
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditWorkResultScreen(
                        workResult: newItem,
                        isEditable: true,
                        unitKerja: _editableBkm.unitKerja,
                        divisi: _editableBkm.divisi,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() => _editableBkm.workResults.add(result));
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 18),
        onPressed: onPressed,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============ MATERIALS TAB ============
  Widget _buildMaterialsTab() {
    return Stack(
      children: [
        _editableBkm.materials.isEmpty
            ? const Center(child: Text("No Bahan"))
            : ListView.builder(
                itemCount: _editableBkm.materials.length,
                itemBuilder: (context, index) {
                  final m = _editableBkm.materials[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No Urut Pekerjaan: ${m.noUrutPekerjaan}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditMaterialScreen(
                                            material: m,
                                            isEditable: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (widget.isEditable && widget.userType != UserType.asistenDivisi)
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditMaterialScreen(
                                              material: m,
                                              isEditable: true,
                                              isOperator: widget.userType == UserType.operator,
                                            ),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            _editableBkm.materials[index] = result;
                                          });
                                        }
                                      },
                                    ),
                                  if (widget.isEditable && widget.userType == UserType.mandor)
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        setState(() => _editableBkm.materials.removeAt(index));
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("Running No: ${m.runningNo}"),
                          Text("Nama Bahan: ${m.namaBahan}"),
                          Text("Jumlah Bahan: ${m.jumlahBahan} ${m.uomBahan}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
        if (widget.isEditable && widget.userType == UserType.mandor)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "addMaterial",
              onPressed: () async {
                final newItem = PemakaianBahan();
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditMaterialScreen(
                      material: newItem,
                      isEditable: true,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() => _editableBkm.materials.add(result));
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }

  // ============ WORKERS TAB ============
  Widget _buildWorkersTab() {
    return Stack(
      children: [
        _editableBkm.workers.isEmpty
            ? const Center(child: Text("No Pekerja"))
            : ListView.builder(
                itemCount: _editableBkm.workers.length,
                itemBuilder: (context, index) {
                  final w = _editableBkm.workers[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No Urut Pekerjaan: ${w.noUrutPekerjaan}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditWorkerScreen(
                                            worker: w,
                                            isEditable: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (widget.isEditable && widget.userType != UserType.operator)
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditWorkerScreen(
                                              worker: w,
                                              isEditable: true,
                                            ),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            _editableBkm.workers[index] = result;
                                          });
                                        }
                                      },
                                    ),
                                  if (widget.isEditable && widget.userType != UserType.operator)
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        setState(() => _editableBkm.workers.removeAt(index));
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("Running No: ${w.runningNo}"),
                          Text("No Induk: ${w.noIndukPekerja}"),
                          Text("Nama Pekerja: ${w.namaPekerja}"),
                          Text("Pengupahan: ${w.pengupahan}"),
                          Text("Kode Absen: ${w.kodeAbsen}"),
                          Text("HK: ${w.hk}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
        if (widget.isEditable && widget.userType != UserType.operator)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "addWorker",
              onPressed: () async {
                final newItem = DaftarHadir();
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditWorkerScreen(
                      worker: newItem,
                      isEditable: true,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() => _editableBkm.workers.add(result));
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }

  // ============ TRANSPORT TAB ============
  Widget _buildTransportTab() {
    return Stack(
      children: [
        _editableBkm.transports.isEmpty
            ? const Center(child: Text("No Transport"))
            : ListView.builder(
                itemCount: _editableBkm.transports.length,
                itemBuilder: (context, index) {
                  final t = _editableBkm.transports[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No Urut Pekerjaan: ${t.noUrutPekerjaan}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditTransportScreen(
                                            transport: t,
                                            isEditable: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (widget.isEditable && widget.userType != UserType.asistenDivisi)
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditTransportScreen(
                                              transport: t,
                                              isEditable: true,
                                            ),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            _editableBkm.transports[index] = result;
                                          });
                                        }
                                      },
                                    ),
                                  if (widget.isEditable && widget.userType == UserType.mandor)
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        setState(() => _editableBkm.transports.removeAt(index));
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("Running No: ${t.runningNo}"),
                          Text("Jenis Kendaraan: ${t.jenisKendaraan}"),
                          Text("No Kendaraan: ${t.noKendaraan}"),
                          Text("Nama Pemakai: ${t.namaPemakai}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
        if (widget.isEditable && widget.userType == UserType.mandor)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "addTransport",
              onPressed: () async {
                final newItem = Transport();
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditTransportScreen(
                      transport: newItem,
                      isEditable: true,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() => _editableBkm.transports.add(result));
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }

  // ============ MAIN ============
  @override
  Widget build(BuildContext context) {
    if (widget.userType == UserType.operator) {
      return _buildOperatorView();
    }
    if (widget.userType == UserType.asistenDivisi) {
      return _buildAsistenView();
    }
    return (kIsWeb || widget.userType == UserType.mandor) ? 
           (kIsWeb ? _buildWebView() : _buildMobileView()) : 
           _buildAccessDenied();
  }

  Widget _buildOperatorView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BKM - Operator"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: TabBar(
            controller: _tabController,
            tabs: [
              _buildTab(Icons.info, "General"),
              _buildTab(Icons.work, "Hasil\nKerja"),
              _buildTab(Icons.inventory, "Bahan"),
              _buildTab(Icons.people, "Daftar\nHadir"),
              _buildTab(Icons.local_shipping, "Transport"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralInfoTab(),
          _buildWorkResultsTab(),
          _buildMaterialsTab(),
          _buildWorkersTab(),
          _buildTransportTab(),
        ],
      ),
    );
  }

  Widget _buildAsistenView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BKM Review - Asisten Divisi"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Document saved successfully')),
              );
              Navigator.pop(context, _editableBkm);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TabBar(
            controller: _tabController,
            tabs: [
              _buildTab(Icons.info, "General"),
              _buildTab(Icons.work, "Hasil\nKerja"),
              _buildTab(Icons.inventory, "Bahan"),
              _buildTab(Icons.people, "Daftar\nHadir"),
              _buildTab(Icons.local_shipping, "Transport"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralInfoTab(),
          _buildWorkResultsTab(),
          _buildMaterialsTab(),
          _buildWorkersTab(),
          _buildTransportTab(),
        ],
      ),
    );
  }

  Widget _buildAccessDenied() {
    return Scaffold(
      appBar: AppBar(title: const Text("Access Denied")),
      body: const Center(
        child: Text("Mobile access is only available for Mandor users"),
      ),
    );
  }

  Widget _buildMobileView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail BKM"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        actions: [
          if (widget.isEditable)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _save,
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TabBar(
            controller: _tabController,
            tabs: [
              _buildTab(Icons.info, "General"),
              _buildTab(Icons.work, "Hasil\nKerja"),
              _buildTab(Icons.inventory, "Bahan"),
              _buildTab(Icons.people, "Daftar\nHadir"),
              _buildTab(Icons.local_shipping, "Transport"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralInfoTab(),
          _buildWorkResultsTab(),
          _buildMaterialsTab(),
          _buildWorkersTab(),
          _buildTransportTab(),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail BKM - Web View"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        actions: [
          if (widget.isEditable)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _save,
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: TabBar(
            controller: _tabController,
            tabs: [
              _buildTab(Icons.info, "General"),
              _buildTab(Icons.work, "Hasil\nKerja"),
              _buildTab(Icons.inventory, "Bahan"),
              _buildTab(Icons.people, "Daftar\nHadir"),
              _buildTab(Icons.local_shipping, "Transport"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralInfoTab(),
          _buildWorkResultsTab(),
          _buildMaterialsTab(),
          _buildWorkersTab(),
          _buildTransportTab(),
        ],
      ),
    );
  }
}