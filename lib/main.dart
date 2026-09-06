
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// DATA BUKU
List<Map<String, dynamic>> daftarBuku = [
  {
    'judul': 'Laskar Pelangi',
    'pengarang': 'Andrea Hirata',
    'tahun': 2005,
    'rating': 4.8,
    'tersedia': true,
    'genre': 'Novel',
  },
  {
    'judul': 'Bumi',
    'pengarang': 'Tere Liye',
    'tahun': 2014,
    'rating': 4.6,
    'tersedia': false,
    'genre': 'Fantasi',
  },
  {
    'judul': 'Negeri 5 Menara',
    'pengarang': 'Ahmad Fuadi',
    'tahun': 2009,
    'rating': 4.3,
    'tersedia': true,
    'genre': 'Novel',
  },
  {
    'judul': 'Filosofi Kopi',
    'pengarang': 'Dee Lestari',
    'tahun': 2006,
    'rating': 3.9,
    'tersedia': true,
    'genre': 'Cerpen',
  },
  {
    'judul': 'Dilan 1990',
    'pengarang': 'Pidi Baiq',
    'tahun': 2014,
    'rating': 4.1,
    'tersedia': false,
    'genre': 'Romansa',
  },
  {
    'judul': 'the last sunrise',
    'pengarang': 'Fatika Nuraini',
    'tahun': 2026,
    'rating': 4.7,
    'tersedia': true,
    'genre': 'Mystery',
  },
];

// KATEGORI RATING
String kategoriRating(double rating) {
  if (rating >= 4.5) return 'Sangat Baik';
  if (rating >= 3.5) return 'Baik';
  return 'Cukup';
}

// APLIKASI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Buku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const HalamanKatalog(),
    );
  }
}

// HALAMAN KATALOG
class HalamanKatalog extends StatefulWidget {
  const HalamanKatalog({super.key});

  @override
  State<HalamanKatalog> createState() => _HalamanKatalogState();
}

class _HalamanKatalogState extends State<HalamanKatalog> {
  String pencarian = '';

  @override
  Widget build(BuildContext context) {
    final buku = daftarBuku.where((b) {
      return b['judul']
          .toString()
          .toLowerCase()
          .contains(pencarian.toLowerCase());
    }).toList();

    final genre = daftarBuku
        .map((b) => b['genre'].toString())
        .toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Buku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // SEARCH
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari buku',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  pencarian = value;
                });
              },
            ),
          ),

          // GENRE
          Wrap(
            spacing: 8,
            children: genre.map((g) {
              return Chip(
                label: Text(g),
              );
            }).toList(),
          ),

          const SizedBox(height: 5),

          Text(
            'Menampilkan ${buku.length} buku',
            style: const TextStyle(color: Colors.grey),
          ),

          // DAFTAR BUKU
          Expanded(
            child: buku.isEmpty
                ? const Center(
                    child: Text(
                      'Buku tidak ditemukan',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: buku.length,
                    itemBuilder: (context, index) {
                      final b = buku[index];

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // JUDUL
                              Text(
                                b['judul'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                'Pengarang: ${b['pengarang']}',
                              ),

                              Text(
                                'Tahun: ${b['tahun']}',
                              ),

                              // RATING
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    '${b['rating']} - '
                                    '${kategoriRating(b['rating'])}',
                                  ),
                                ],
                              ),

                              Text(
                                'Genre: ${b['genre']}',
                              ),

                              // STATUS
                              Chip(
                                label: Text(
                                  b['tersedia']
                                      ? 'Tersedia'
                                      : 'Dipinjam',
                                ),
                              ),

                              // DETAIL
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            HalamanDetail(
                                          buku: b,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Lihat Detail',
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
        ],
      ),
    );
  }
}

// HALAMAN DETAIL
class HalamanDetail extends StatelessWidget {
  final Map<String, dynamic> buku;

  const HalamanDetail({
    super.key,
    required this.buku,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              buku['judul'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Pengarang'),
              subtitle: Text(buku['pengarang']),
            ),

            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Tahun Terbit'),
              subtitle: Text('${buku['tahun']}'),
            ),

            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Rating'),
              subtitle: Text(
                '${buku['rating']} - '
                '${kategoriRating(buku['rating'])}',
              ),
            ),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Genre'),
              subtitle: Text(buku['genre']),
            ),

            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Status'),
              subtitle: Text(
                buku['tersedia']
                    ? 'Tersedia'
                    : 'Dipinjam',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

