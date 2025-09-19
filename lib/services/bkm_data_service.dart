import '../models/bkm.dart';
import '../models/material.dart';
import '../models/transport.dart';
import '../models/work_result.dart';
import '../models/worker.dart';

class BKMDataService {
  static final BKMDataService _instance = BKMDataService._internal();
  factory BKMDataService() => _instance;
  BKMDataService._internal();

  static List<BKM> _bkms = [
    BKM(
      noSeriBkm: "P123",
      unitKerja: "LIBE",
      divisi: "01",
      kemandoran: "Kemandoran 1",
      namaMandor: "Eko Nugroho Purnomo",
      unitKegiatan: "Panen",
      tanggalKegiatan: DateTime(2025, 8, 27),
      status: "Draft",
      workResults: [
        HasilKerja(
          noUrutPekerjaan: 1,
          complex: "192016D24",
          noBlok: "A-34",
          luasBlok: 2.5,
          jenisPekerjaan: "Panen",
          jumlahHk: 10,
          hasil: 1500,
          uomHasil: "kg",
          keterangan: "Panen pagi",
        ),
        HasilKerja(
          noUrutPekerjaan: 2,
          complex: "192016D25",
          noBlok: "A-40",
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
      unitKerja: "LIBE",
      divisi: "02",
      kemandoran: "Kemandoran 2",
      namaMandor: "Surya Purnama",
      unitKegiatan: "Panen",
      tanggalKegiatan: DateTime(2025, 8, 27),
      status: "Draft",
      workResults: [
        HasilKerja(
          noUrutPekerjaan: 1,
          complex: "192015G27",
          noBlok: "D-43",
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
      unitKerja: "LIBE",
      divisi: "04",
      kemandoran: "Kemandoran 3",
      namaMandor: "Nafa Urbach",
      unitKegiatan: "Panen Transport",
      tanggalKegiatan: DateTime(2025, 8, 27),
      status: "Posted",
      workResults: [
        HasilKerja(
          noUrutPekerjaan: 1,
          complex: "192016D34",
          noBlok: "D-57",
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

  List<BKM> getAllBKMs() => List.unmodifiable(_bkms);

  List<BKM> getBKMsByStatus(String status) =>
      _bkms.where((bkm) => bkm.status == status).toList();

  List<BKM> getBKMsByMandor(String namaMandor) =>
      _bkms.where((bkm) => bkm.namaMandor == namaMandor).toList();

  BKM? getBKMByNoSeri(String noSeriBkm) =>
      _bkms.firstWhere((bkm) => bkm.noSeriBkm == noSeriBkm);

  void addBKM(BKM bkm) => _bkms.add(bkm);

  void updateBKM(BKM updatedBkm) {
    final index = _bkms.indexWhere((bkm) => bkm.noSeriBkm == updatedBkm.noSeriBkm);
    if (index != -1) _bkms[index] = updatedBkm;
  }

  void deleteBKM(String noSeriBkm) =>
      _bkms.removeWhere((bkm) => bkm.noSeriBkm == noSeriBkm);
}