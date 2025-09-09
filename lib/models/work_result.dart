class HasilKerja {
  int noUrutPekerjaan;
  String complex;
  String noBlok;
  double luasBlok;
  String jenisPekerjaan;
  double jumlahHk;
  double hasil;
  String uomHasil;
  String keterangan;
  String workOrder;
  String costCenter;
  String operation;
  String activityType;

  HasilKerja({
    this.noUrutPekerjaan = 0,
    this.complex = '',
    this.noBlok = '',
    this.luasBlok = 0.0,
    this.jenisPekerjaan = '',
    this.jumlahHk = 0.0,
    this.hasil = 0.0,
    this.uomHasil = '',
    this.keterangan = '',
    this.workOrder = '',
    this.costCenter = '',
    this.operation = '',
    this.activityType = '',
  });

  @override
  String toString() =>
      "$jenisPekerjaan ($hasil $uomHasil) - $keterangan";
}