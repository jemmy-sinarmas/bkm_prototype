import 'package:bkm_prototype/models/material.dart';
import 'package:bkm_prototype/models/transport.dart';
import 'package:bkm_prototype/models/work_result.dart';
import 'package:bkm_prototype/models/worker.dart';
import 'package:bkm_prototype/screens/bkm/edit_material_screen.dart';
import 'package:bkm_prototype/screens/bkm/edit_work_result_screen.dart';
import 'package:bkm_prototype/screens/bkm/edit_worker_screen.dart';
import 'package:bkm_prototype/screens/bkm/edit_transport_screen.dart';
import 'package:bkm_prototype/constants/unit_kegiatan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/bkm.dart';
import '../../models/user.dart';
import 'bkm_preview_screen.dart';

class EditBKMScreen extends StatefulWidget {
  final BKM bkm;
  final bool isEditable;
  final UserType userType;

  const EditBKMScreen({
    Key? key,
    required this.bkm,
    this.isEditable = true,
    required this.userType,
  }) : super(key: key);

  @override
  _EditBKMScreenState createState() => _EditBKMScreenState();
}

class _EditBKMScreenState extends State<EditBKMScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BKM _editableBkm;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _editableBkm = widget.bkm;
    // Ensure transports is never null
    _editableBkm.transports;
  }

  void _save() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document saved successfully')),
    );
    Navigator.pop(context, _editableBkm);
  }

  // ============ GENERAL TAB ============
  Widget _buildGeneralInfoTab() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildField("No Seri BKM", _editableBkm.noSeriBkm, (val) => _editableBkm.noSeriBkm = val),
          _buildField("Unit Kerja", _editableBkm.unitKerja, (val) => _editableBkm.unitKerja = val),
          _buildField("Divisi", _editableBkm.divisi, (val) => _editableBkm.divisi = val),
          _buildField("Kemandoran", _editableBkm.kemandoran, (val) => _editableBkm.kemandoran = val),
          _buildField("Nama Mandor", _editableBkm.namaMandor, (val) => _editableBkm.namaMandor = val),
          _buildUnitKegiatanDropdown(),
          ListTile(
            title: const Text("Tanggal Kegiatan"),
            subtitle: Text("${_editableBkm.tanggalKegiatan.toLocal()}".split(' ')[0]),
            trailing: widget.isEditable && widget.userType != UserType.operator
                ? IconButton(
                    icon: const Icon(Icons.calendar_today),
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
          Text("Status: ${_editableBkm.status}"),
        ],
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
    return Stack(
      children: [
        _editableBkm.workResults.isEmpty
            ? const Center(child: Text("No Hasil Kerja"))
            : ListView.builder(
                itemCount: _editableBkm.workResults.length,
                itemBuilder: (context, index) {
                  final h = _editableBkm.workResults[index];
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
                                "No Urut Pekerjaan: ${h.noUrutPekerjaan}",
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
                                          builder: (_) => EditWorkResultScreen(
                                            workResult: h,
                                            isEditable: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (widget.isEditable)
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditWorkResultScreen(
                                              workResult: h,
                                              isEditable: true,
                                              isOperator: widget.userType == UserType.operator,
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
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        setState(() => _editableBkm.workResults.removeAt(index));
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("Complex: ${h.complex}"),
                          Text("No Blok: ${h.noBlok}"),
                          Text("Luas Blok: ${h.luasBlok}"),
                          Text("Jenis Pekerjaan: ${h.jenisPekerjaan}"),
                          Text("Jumlah HK: ${h.jumlahHk}"),
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
              heroTag: "addWorkResult",
              onPressed: () async {
                final newItem = HasilKerja();
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditWorkResultScreen(
                      workResult: newItem,
                      isEditable: true,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() => _editableBkm.workResults.add(result));
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
      ],
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
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 10),
          tabs: const [
            Tab(icon: Icon(Icons.info), text: "General"),
            Tab(icon: Icon(Icons.work), text: "Hasil\nKerja"),
            Tab(icon: Icon(Icons.inventory), text: "Pemakaian\nBahan"),
            Tab(icon: Icon(Icons.people), text: "Daftar\nHadir"),
            Tab(icon: Icon(Icons.local_shipping), text: "Transport"),
          ],
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
          if (_editableBkm.status == 'Draft')
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BKMPreviewScreen(
                      bkm: _editableBkm,
                      onSubmit: () {
                        setState(() => _editableBkm.status = 'Submitted');
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('BKM submitted successfully')),
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Text('Preview & Submit'),
            ),
          if (_editableBkm.status == 'Submitted')
            ElevatedButton(
              onPressed: () {
                setState(() => _editableBkm.status = 'Posted');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('BKM approved and posted')),
                );
              },
              child: const Text('Approve'),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 10),
          tabs: const [
            Tab(icon: Icon(Icons.info), text: "General"),
            Tab(icon: Icon(Icons.work), text: "Hasil\nKerja"),
            Tab(icon: Icon(Icons.inventory), text: "Pemakaian\nBahan"),
            Tab(icon: Icon(Icons.people), text: "Daftar\nHadir"),
            Tab(icon: Icon(Icons.local_shipping), text: "Transport"),
          ],
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
        actions: [
          if (widget.isEditable)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _save,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 10),
          tabs: const [
            Tab(icon: Icon(Icons.info), text: "General"),
            Tab(icon: Icon(Icons.work), text: "Hasil\nKerja"),
            Tab(icon: Icon(Icons.inventory), text: "Pemakaian\nBahan"),
            Tab(icon: Icon(Icons.people), text: "Daftar\nHadir"),
            Tab(icon: Icon(Icons.local_shipping), text: "Transport"),
          ],
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
        actions: [
          if (widget.isEditable)
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              onPressed: _save,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "General"),
            Tab(text: "Hasil Kerja"),
            Tab(text: "Bahan"),
            Tab(text: "Daftar Hadir"),
            Tab(text: "Transport"),
          ],
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