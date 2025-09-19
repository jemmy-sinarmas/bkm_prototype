import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/bkm.dart';
import '../../models/user.dart';
import '../../theme/app_theme.dart';
import '../../services/bkm_data_service.dart';
import 'edit_bkm_screen.dart';
import 'bkm_preview_screen.dart';

class BKMScreen extends StatefulWidget {
  final UserType userType;
  
  const BKMScreen({super.key, required this.userType});
  
  @override
  _BKMListScreenState createState() => _BKMListScreenState();
}

class _BKMListScreenState extends State<BKMScreen> {
  final BKMDataService _bkmService = BKMDataService();
  List<BKM> bkms = [];


  Set<int> expandedCards = {};

  @override
  void initState() {
    super.initState();
    bkms = _bkmService.getAllBKMs();
  }

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
                                      bkms = _bkmService.getAllBKMs();
                                    });
                                  }
                                },
                              ),
                            if (_canEditDelete(p))
                              _buildActionButton(
                                Icons.copy,
                                AppTheme.secondaryColor,
                                () {
                                  final copiedBkm = BKM(
                                    noSeriBkm: "${p.noSeriBkm}_COPY",
                                    unitKerja: p.unitKerja,
                                    divisi: p.divisi,
                                    kemandoran: p.kemandoran,
                                    namaMandor: p.namaMandor,
                                    unitKegiatan: p.unitKegiatan,
                                    tanggalKegiatan: p.tanggalKegiatan,
                                    status: "Draft",
                                  );
                                  _bkmService.addBKM(copiedBkm);
                                  setState(() {
                                    bkms = _bkmService.getAllBKMs();
                                  });
                                },
                              ),
                            if (_canEditDelete(p))
                              _buildActionButton(
                                Icons.delete,
                                AppTheme.errorColor,
                                () {
                                  _bkmService.deleteBKM(p.noSeriBkm);
                                  setState(() {
                                    bkms = _bkmService.getAllBKMs();
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
            _bkmService.addBKM(newProduct);
            setState(() {
              bkms = _bkmService.getAllBKMs();
            });
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add BKM'),
      ),
    );
  }
}