import 'package:bkm_prototype/models/material.dart';
import 'package:bkm_prototype/models/transport.dart';
import 'package:bkm_prototype/models/work_result.dart';
import 'package:bkm_prototype/models/worker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/bkm.dart';
import '../../models/user.dart';
import '../../theme/app_theme.dart';
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

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 20),
        onPressed: onPressed,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.accentColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
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
        title: Row(
          children: [
            const Icon(Icons.agriculture, size: 24),
            const SizedBox(width: 8),
            const Text("Daftar BKM"),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primaryColor,
                elevation: 0,
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: ListView.builder(
        itemCount: bkms.length,
          itemBuilder: (context, index) {
            final p = bkms[index];
            final isExpanded = expandedCards.contains(index);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: AppTheme.cardDecoration,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with BKM number and status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.noSeriBkm,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              AppTheme.statusChip(p.status),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _buildActionButton(
                              Icons.visibility,
                              Colors.blue,
                              () async {
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
                              _buildActionButton(
                                Icons.edit,
                                AppTheme.warningColor,
                                () async {
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
                              _buildActionButton(
                                Icons.copy,
                                AppTheme.secondaryColor,
                                () {
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
                              _buildActionButton(
                                Icons.delete,
                                AppTheme.errorColor,
                                () {
                                  setState(() {
                                    bkms.removeAt(index);
                                  });
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Basic info
                    _buildInfoRow(Icons.business, "Unit Kerja", p.unitKerja),
                    _buildInfoRow(Icons.group_work, "Divisi", p.divisi),
                    _buildInfoRow(Icons.calendar_today, "Tanggal", "${p.tanggalKegiatan.day}/${p.tanggalKegiatan.month}/${p.tanggalKegiatan.year}"),
                    _buildInfoRow(Icons.work, "Unit Kegiatan", p.unitKegiatan),

                    // Expanded details
                    if (isExpanded) ...[
                      const Divider(height: 24),
                      _buildInfoRow(Icons.person, "Mandor", p.namaMandor),
                      _buildInfoRow(Icons.location_on, "Kemandoran", p.kemandoran),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildStatCard("Hasil Kerja", p.workResults.length.toString(), Icons.work),
                          const SizedBox(width: 8),
                          _buildStatCard("Bahan", p.materials.length.toString(), Icons.inventory),
                          const SizedBox(width: 8),
                          _buildStatCard("Pekerja", p.workers.length.toString(), Icons.people),
                        ],
                      ),
                    ],

                    const SizedBox(height: 12),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            if (isExpanded) {
                              expandedCards.remove(index);
                            } else {
                              expandedCards.add(index);
                            }
                          });
                        },
                        icon: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: AppTheme.primaryColor,
                        ),
                        label: Text(
                          isExpanded ? "Show Less" : "Show More",
                          style: const TextStyle(color: AppTheme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
        icon: const Icon(Icons.add),
        label: const Text('Add BKM'),
      ),
    );
  }
}