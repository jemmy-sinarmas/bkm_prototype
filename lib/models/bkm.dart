import 'package:bkm_prototype/models/material.dart';
import 'package:bkm_prototype/models/transport.dart';
import 'package:bkm_prototype/models/work_result.dart';
import 'package:bkm_prototype/models/worker.dart';

class BKM {
  String noSeriBkm;
  String unitKerja;
  String divisi;
  String kemandoran;
  String namaMandor;
  String unitKegiatan;
  DateTime tanggalKegiatan;
  List<HasilKerja> workResults;
  List<PemakaianBahan> materials;
  List<DaftarHadir> workers;
  List<Transport> transports;
  String status; // draft / saved / submitted / posted

  BKM({
    this.noSeriBkm = '',
    this.unitKerja = '',
    this.divisi = '',
    this.kemandoran = '',
    this.namaMandor = '',
    this.unitKegiatan = '',
    DateTime? tanggalKegiatan,
    this.workResults = const <HasilKerja>[],
    this.materials = const <PemakaianBahan>[],
    this.workers = const <DaftarHadir>[],
    this.transports = const <Transport>[],
    this.status = 'Draft',
  }) : tanggalKegiatan = tanggalKegiatan ?? DateTime.now();
}