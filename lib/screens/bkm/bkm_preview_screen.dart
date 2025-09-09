import 'package:flutter/material.dart';
import '../../models/bkm.dart';

class BKMPreviewScreen extends StatefulWidget {
  final BKM bkm;
  final VoidCallback? onSubmit;

  const BKMPreviewScreen({
    super.key,
    required this.bkm,
    required this.onSubmit,
  });

  @override
  _BKMPreviewScreenState createState() => _BKMPreviewScreenState();
}

class _BKMPreviewScreenState extends State<BKMPreviewScreen> {
  bool _generalExpanded = true;
  bool _workResultsExpanded = false;
  bool _materialsExpanded = false;
  bool _workersExpanded = false;
  bool _transportsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BKM Preview'),
        actions: [
          if (widget.onSubmit != null)
            ElevatedButton(
              onPressed: widget.onSubmit,
              child: const Text('Submit'),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGeneralCard(),
          _buildWorkResultsCard(),
          _buildMaterialsCard(),
          _buildWorkersCard(),
          _buildTransportsCard(),
        ],
      ),
    );
  }

  Widget _buildGeneralCard() {
    return Card(
      child: ExpansionTile(
        title: const Text('General Information', style: TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: _generalExpanded,
        onExpansionChanged: (expanded) => setState(() => _generalExpanded = expanded),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('No Seri BKM', widget.bkm.noSeriBkm),
                _buildInfoRow('Unit Kerja', widget.bkm.unitKerja),
                _buildInfoRow('Divisi', widget.bkm.divisi),
                _buildInfoRow('Kemandoran', widget.bkm.kemandoran),
                _buildInfoRow('Nama Mandor', widget.bkm.namaMandor),
                _buildInfoRow('Unit Kegiatan', widget.bkm.unitKegiatan),
                _buildInfoRow('Tanggal Kegiatan', widget.bkm.tanggalKegiatan.toString().split(' ')[0]),
                _buildInfoRow('Status', widget.bkm.status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkResultsCard() {
    return Card(
      child: ExpansionTile(
        title: Text('Hasil Kerja (${widget.bkm.workResults.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: _workResultsExpanded,
        onExpansionChanged: (expanded) => setState(() => _workResultsExpanded = expanded),
        children: widget.bkm.workResults.map((result) => 
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('No Urut Pekerjaan', result.noUrutPekerjaan.toString()),
                  _buildInfoRow('Complex', result.complex),
                  _buildInfoRow('No Blok', result.noBlok),
                  _buildInfoRow('Luas Blok', result.luasBlok.toString()),
                  _buildInfoRow('Jenis Pekerjaan', result.jenisPekerjaan),
                  _buildInfoRow('Jumlah HK', result.jumlahHk.toString()),
                  _buildInfoRow('Hasil', '${result.hasil} ${result.uomHasil}'),
                  _buildInfoRow('Keterangan', result.keterangan),
                  _buildInfoRow('Work Order', result.workOrder),
                  _buildInfoRow('Operation', result.operation),
                  _buildInfoRow('Activity Type', result.activityType),
                  _buildInfoRow('Cost Center', result.costCenter),
                ],
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildMaterialsCard() {
    return Card(
      child: ExpansionTile(
        title: Text('Bahan (${widget.bkm.materials.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: _materialsExpanded,
        onExpansionChanged: (expanded) => setState(() => _materialsExpanded = expanded),
        children: widget.bkm.materials.map((material) => 
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('No Urut Pekerjaan', material.noUrutPekerjaan.toString()),
                  _buildInfoRow('No Urut', material.runningNo.toString()),
                  _buildInfoRow('Nama Bahan', material.namaBahan),
                  _buildInfoRow('Jumlah', '${material.jumlahBahan} ${material.uomBahan}'),
                  _buildInfoRow('Keterangan', material.keterangan),
                  _buildInfoRow('No Material', material.noMaterial),
                  _buildInfoRow('No Batch', material.noBatch),
                  _buildInfoRow('GL Account', material.glAccount),
                ],
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildWorkersCard() {
    return Card(
      child: ExpansionTile(
        title: Text('Daftar Hadir (${widget.bkm.workers.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: _workersExpanded,
        onExpansionChanged: (expanded) => setState(() => _workersExpanded = expanded),
        children: widget.bkm.workers.map((worker) => 
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('No Urut Pekerjaan', worker.noUrutPekerjaan.toString()),
                  _buildInfoRow('No Urut', worker.runningNo.toString()),
                  _buildInfoRow('Nama Pekerja', worker.namaPekerja),
                  _buildInfoRow('No Induk', worker.noIndukPekerja),
                  _buildInfoRow('Pengupahan', worker.pengupahan),
                  _buildInfoRow('Kode Absen', worker.kodeAbsen),
                  _buildInfoRow('HK', worker.hk.toString()),
                ],
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildTransportsCard() {
    final transports = widget.bkm.transports;
    return Card(
      child: ExpansionTile(
        title: Text('Transport (${transports.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: _transportsExpanded,
        onExpansionChanged: (expanded) => setState(() => _transportsExpanded = expanded),
        children: transports.map<Widget>((transport) => 
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('No Urut Pekerjaan', transport.noUrutPekerjaan.toString()),
                  _buildInfoRow('Running No', transport.runningNo.toString()),
                  _buildInfoRow('Jenis Kendaraan', transport.jenisKendaraan),
                  _buildInfoRow('No Kendaraan', transport.noKendaraan),
                  _buildInfoRow('Merk Kendaraan', transport.merkKendaraan),
                  _buildInfoRow('Nama Pemakai', transport.namaPemakai),
                  _buildInfoRow('Keperluan', transport.keperluan),
                  _buildInfoRow('HM', transport.hm.toString()),
                  _buildInfoRow('KM', transport.km.toString()),
                ],
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          const Text(': '),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}