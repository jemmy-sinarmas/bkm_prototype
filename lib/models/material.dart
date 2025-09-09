class PemakaianBahan {
  int noUrutPekerjaan;
  int runningNo;
  String namaBahan;
  double jumlahBahan;
  String uomBahan;
  String keterangan;
  String noMaterial;
  String noBatch;
  String glAccount;

  PemakaianBahan({
    this.noUrutPekerjaan = 0,
    this.runningNo = 0,
    this.namaBahan = '',
    this.jumlahBahan = 0.0,
    this.uomBahan = '',
    this.keterangan = '',
    this.noMaterial = '',
    this.noBatch = '',
    this.glAccount = '',
  });

  @override
  String toString() =>
      "$namaBahan ($jumlahBahan $uomBahan)";
}