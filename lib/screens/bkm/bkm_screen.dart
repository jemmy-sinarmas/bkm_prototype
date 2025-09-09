import 'package:bkm_prototype/models/material.dart';
import 'package:bkm_prototype/models/transport.dart';
import 'package:bkm_prototype/models/work_result.dart';
import 'package:bkm_prototype/models/worker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/bkm.dart';
import '../../models/user.dart';
import 'edit_bkm_screen.dart';
import 'bkm_preview_screen.dart';

class BKMScreen extends StatefulWidget {
  final UserType userType;
  
  const BKMScreen({super.key, required this.userType});
  
  @override
  _BKMListScreenState createState() => _BKMListScreenState();
}

class _BKMListScreenState extends State<BKMScreen> {
  List<BKM> bkms = [
  BKM(
    noSeriBkm: "P123",
    unitKerja: "SSME",
    divisi: "1",
    kemandoran: "Kemandoran 1",
    namaMandor: "Eko Nugroho Purnomo",
    unitKegiatan: "Panen",
    tanggalKegiatan: DateTime(2025, 8, 27),
    status: "Draft",
    workResults: [
      HasilKerja(
        noUrutPekerjaan: 1,
        complex: "Kompleks A",
        noBlok: "A1",
        luasBlok: 2.5,
        jenisPekerjaan: "Panen",
        jumlahHk: 10,
        hasil: 1500,
        uomHasil: "kg",
        keterangan: "Panen pagi",
      ),
      HasilKerja(
        noUrutPekerjaan: 2,
        complex: "Kompleks A",
        noBlok: "A2",
        luasBlok: 3.0,
        jenisPekerjaan: "Angkut",
        jumlahHk: 8,
        hasil: 1200,
        uomHasil: "kg",
        keterangan: "Angkut sore",
      ),
    ],
    materials: [
      PemakaianBahan(
        noUrutPekerjaan: 1,
        runningNo: 1,
        namaBahan: "Karung",
        jumlahBahan: 50,
        uomBahan: "pcs",
        keterangan: "Untuk panen",
        noMaterial: "MAT001",
        noBatch: "BATCH001",
      ),
      PemakaianBahan(
        noUrutPekerjaan: 2,
        runningNo: 1,
        namaBahan: "Solar",
        jumlahBahan: 20,
        uomBahan: "liter",
        keterangan: "Untuk truk angkut",
        noMaterial: "MAT002",
        noBatch: "BATCH002",
      ),
    ],
    workers: [
      DaftarHadir(
        noUrutPekerjaan: 1,
        runningNo: 1,
        noIndukPekerja: "W001",
        namaPekerja: "Budi",
        pengupahan: "Harian",
        kodeAbsen: "H",
        hk: 1,
      ),
      DaftarHadir(
        noUrutPekerjaan: 2,
        runningNo: 1,
        noIndukPekerja: "W002",
        namaPekerja: "Andi",
        pengupahan: "Harian",
        kodeAbsen: "H",
        hk: 1,
      ),
    ],
    transports: [
      Transport(
        noUrutPekerjaan: 1,
        runningNo: 1,
        jenisKendaraan: "Truk",
        noKendaraan: "B 1234 ABC",
        merkKendaraan: "Mitsubishi",
        namaPemakai: "Budi Santoso",
        keperluan: "Angkut hasil panen",
        hm: 120.5,
        km: 45.2,
      ),
    ],
  ),
  BKM(
    noSeriBkm: "P234",
    unitKerja: "SSME",
    divisi: "1",
    kemandoran: "Kemandoran 2",
    namaMandor: "Surya Purnama",
    unitKegiatan: "Panen",
    tanggalKegiatan: DateTime(2025, 8, 27),
    status: "Draft",
    workResults: [
      HasilKerja(
        noUrutPekerjaan: 1,
        complex: "Kompleks B",
        noBlok: "B3",
        luasBlok: 4.0,
        jenisPekerjaan: "Panen",
        jumlahHk: 12,
        hasil: 1800,
        uomHasil: "kg",
      ),
    ],
    materials: [
      PemakaianBahan(
        noUrutPekerjaan: 1,
        runningNo: 1,
        namaBahan: "Karung",
        jumlahBahan: 40,
        uomBahan: "pcs",
      ),
    ],
    workers: [
      DaftarHadir(
        noUrutPekerjaan: 1,
        runningNo: 1,
        noIndukPekerja: "W003",
        namaPekerja: "Citra",
        pengupahan: "Harian",
        kodeAbsen: "H",
        hk: 1,
      ),
    ],
    transports: [
      Transport(
        noUrutPekerjaan: 1,
        runningNo: 1,
        jenisKendaraan: "Motor",
        noKendaraan: "B 5678 DEF",
        merkKendaraan: "Honda",
        namaPemakai: "Andi Wijaya",
        keperluan: "Patroli kebun",
        hm: 85.3,
        km: 25.7,
      ),
    ],
  ),
  BKM(
    noSeriBkm: "P345",
    unitKerja: "SSME",
    divisi: "2",
    kemandoran: "Kemandoran 1",
    namaMandor: "Nafa Urbach",
    unitKegiatan: "Panen Transport",
    tanggalKegiatan: DateTime(2025, 8, 27),
    status: "Posted",
    workResults: [
      HasilKerja(
        noUrutPekerjaan: 1,
        complex: "Kompleks C",
        noBlok: "C5",
        luasBlok: 5.0,
        jenisPekerjaan: "Transport",
        jumlahHk: 6,
        hasil: 2000,
        uomHasil: "kg",
      ),
    ],
    materials: [
      PemakaianBahan(
        noUrutPekerjaan: 1,
        runningNo: 1,
        namaBahan: "Solar",
        jumlahBahan: 30,
        uomBahan: "liter",
      ),
    ],
    workers: [
      DaftarHadir(
        noUrutPekerjaan: 1,
        runningNo: 1,
        noIndukPekerja: "W004",
        namaPekerja: "Dewi",
        pengupahan: "Harian",
        kodeAbsen: "H",
        hk: 1,
      ),
    ],
    transports: [
      Transport(
        noUrutPekerjaan: 1,
        runningNo: 1,
        jenisKendaraan: "Truk Gandeng",
        noKendaraan: "B 9012 GHI",
        merkKendaraan: "Hino",
        namaPemakai: "Dewi Sartika",
        keperluan: "Transport hasil ke pabrik",
        hm: 200.8,
        km: 75.4,
      ),
    ],
  ),
];


  /// Track which cards are expanded
  Set<int> expandedCards = {};

  bool _canEditDelete(BKM bkm) {
    return widget.userType == UserType.mandor && bkm.status == 'Draft';
  }

  bool _canEdit(BKM bkm) {
    return bkm.status == 'Draft';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Posted":
        return Colors.green;
      case "Failed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Force web view for non-Mandor users
    if (!kIsWeb && widget.userType != UserType.mandor) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Access Denied"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ],
        ),
        body: const Center(
          child: Text("Mobile access is only available for Mandor users"),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar BKM"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: bkms.length,
        itemBuilder: (context, index) {
          final p = bkms[index];
          final isExpanded = expandedCards.contains(index);

          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row with code + icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.noSeriBkm,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BKMPreviewScreen(
                                    bkm: p,
                                    onSubmit: widget.userType == UserType.asistenDivisi && p.status == 'Draft' ? () {
                                      setState(() => p.status = 'Submitted');
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('BKM submitted successfully')),
                                      );
                                    } : null,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (_canEditDelete(p) || _canEdit(p))
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                final updated = await Navigator.push<BKM>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditBKMScreen(bkm: p, userType: widget.userType),
                                  ),
                                );
                                if (updated != null) {
                                  setState(() {
                                    bkms[index] = updated;
                                  });
                                }
                              },
                            ),
                          if (_canEditDelete(p))
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                setState(() {
                                  bkms.add(
                                    BKM(
                                      noSeriBkm: "${p.noSeriBkm}_COPY",
                                      unitKerja: p.unitKerja,
                                      divisi: p.divisi,
                                      kemandoran: p.kemandoran,
                                      namaMandor: p.namaMandor,
                                      unitKegiatan: p.unitKegiatan,
                                      tanggalKegiatan: p.tanggalKegiatan,
                                      status: "Draft",
                                    ),
                                  );
                                });
                              },
                            ),
                          if (_canEditDelete(p))
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  bkms.removeAt(index);
                                });
                              },
                            ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("Unit Kerja: ${p.unitKerja}"),
                  Text("Divisi: ${p.divisi}"),
                  Text("Tanggal Kegiatan: ${p.tanggalKegiatan}"),
                  Text("Unit Kegiatan: ${p.unitKegiatan}"),
                  Row(
                    children: [
                      const Text("Status: "),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(p.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          p.status,
                          style: TextStyle(
                            color: _getStatusColor(p.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 👇 Extra details only if expanded
                  if (isExpanded) ...[
                    const SizedBox(height: 8),
                    Text("Mandor: ${p.namaMandor}"),
                    Text("Kemandoran: ${p.kemandoran}"),
                  ],

                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (isExpanded) {
                          expandedCards.remove(index);
                        } else {
                          expandedCards.add(index);
                        }
                      });
                    },
                    child: Text(isExpanded ? "View Less" : "View More"),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.push<BKM>(
            context,
            MaterialPageRoute(
              builder: (_) => EditBKMScreen(bkm: BKM(), userType: widget.userType),
            ),
          );
          if (newProduct != null) {
            setState(() {
              bkms.add(newProduct);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}