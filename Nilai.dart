//fungsi menghitung rata-rata

double hitungRatarata(List<int>nilai){
  int total = 0;
  for (int n in nilai){
    total += n;
  }
  return total/nilai.length;
}

//fungsi menetukan grade
String tentukanGrade(double rataRata){
  if(rataRata >= 80){
    return 'A';
  }else if(rataRata >= 70){
    return 'B';
  }else if(rataRata >= 60){
    return 'C';
  }else if(rataRata >= 50){
    return 'D';
  }else{
    return 'E';
  }
}
//fungsi mengecek kelulusan
bool cekKelulusan({
  required double rataRata,
  required int absensi,
}) {
  return rataRata >= 60 && absensi <= 3;
}
void main(){
  Map<String, Map<String, dynamic>> mahasiswa = {
    'M001': {
      'nama': 'Budi Santoso',
      'nilai': [85,90,78,92,88],
      'absensi': 1,
    },
    'M002': {
      'nama': 'Fatika Nuraini',
      'nilai': [55, 60, 58,52,45],
      'absensi': 2,
    },
    'M003': {
      'nama': 'Andi Pratama',
      'nilai': [75,85, 88, 95, 92],
      'absensi': 0,
    },
    'M004': {
      'nama': 'Ryski Maulana',
      'nilai': [65,70, 60, 58, 72],
      'absensi': 4,
    },
  };
  print('=========LAPORAN NILAI MAHASISWA==========');
  print ('');
  List<int> semuaNilai = [];
  List<double> semuaRataRata = [];
  //menapilkan laporan setiap mahasiswa
  mahasiswa.forEach((id, data){
    String nama = data['nama'];
    List<int> nilai = List<int>.from(data['nilai']);
    int absensi = data['absensi'];

    double rataRata = hitungRatarata(nilai);
    String grade = tentukanGrade(rataRata);

    bool lulus = cekKelulusan(
      rataRata: rataRata,
      absensi: absensi,
    );
    semuaNilai.addAll(nilai);
    semuaRataRata.add(rataRata);
    print('Nama: $nama');
    print('nilai: $nilai');
    print('absensi: $absensi kali');
    print('Rata-rata: ${rataRata.toStringAsFixed(1)}');
    print('grade: $grade');
    print('status: ${lulus ? 'LULUS' : 'TIDAK LULUS'}');
    print('');

  });
  //menccari nilai tertingi
  int nilaiTertinggi = semuaNilai[0];
  for (int nilai in semuaNilai){
    if(nilai > nilaiTertinggi){
      nilaiTertinggi = nilai;
    }
  }
  //mencari nilai terendah
   int nilaiTerendah = semuaNilai[0];
  for (int nilai in semuaNilai){
    if(nilai < nilaiTerendah){
      nilaiTerendah = nilai;
    }
  }
  //menghitung rata-rata kelas
  double totalRataRata = 0;
  for(double rataRata in semuaRataRata){
    totalRataRata += rataRata;
  }
  double rataRataKelas = totalRataRata / semuaRataRata.length;
  //menampilkan statistik kelas
  print('===STATISTIK KELAS===');
  print('nilaiTertinggi: $nilaiTertinggi');
  print('nilaiTerendah: $nilaiTerendah');
  print(
    'Rata-rata Kelas: ${rataRataKelas.toStringAsFixed(1)}',
  );


}