class DaftarHadir {
  int noUrutPekerjaan;
  int runningNo;
  String noIndukPekerja;
  String namaPekerja;
  String pengupahan;
  String kodeAbsen;
  int hk;

  DaftarHadir({
    this.noUrutPekerjaan = 0,
    this.runningNo = 0,
    this.noIndukPekerja = '',
    this.namaPekerja = '',
    this.pengupahan = '',
    this.kodeAbsen = '',
    this.hk = 0,
  });

  @override
  String toString() =>
      "$namaPekerja - HK: $hk ($kodeAbsen)";
}