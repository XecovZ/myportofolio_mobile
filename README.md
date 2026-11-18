Nama : M. Fatih Danika

NPM : 2506532100

Kelas : PBP B

## Local Setup Guide

**Prerequisites:** [Flutter SDK](https://docs.flutter.dev/get-started/install) and Google Chrome.

1. Clone the repository
```bash
   git clone https://github.com/XecovZ/myportofolio_mobile.git
```
2. Go to the project's directory
```bash
   cd myportofolio_mobile
```
3. Install dependencies
```bash
   flutter pub get
```
4. Run the project. The app will open automatically in Chrome.
```bash
   flutter run -d chrome
```


### Tugas 7

1. Seluruh interface di Flutter tersusun dari widget bersarang yang membentuk sebuah struktur pohon (widget tree). Akarnya adalah widget yang diberikan ke runApp(), yaitu myApp. Parent memasukkan anak lewat properti child/children dan meneurskan data melalui constructor, sedangkan anak dapat membaca data dari ancestorsnya lewat BuildContext. Dalam layout, parent memberi batasan ukuran, anak memlilih ukurannya dalam batas itu, lalu parent menentukan posisinya.


2. MaterialApp (root dan tema aplikasi), Scaffold (kerangka page), AppBar (bar title), Text, Padding, Column/Row (susunan vertikal/horizontal), Center, SizedBox (jarak tetap), Card (kotak panel), Container (pengatur ukuran dan padding), GridView.count (grid 3 kolom), Material (warna dan sudut ca), InkWell (area tekan pakai efek ripple), Icon (ikon), SnackBar (notifikasi di bawah page), ScaffoldMessenger (pengelola SnackBar), dan MediaQuery (info ukuran layar). Sementara itu untuk widget buatan sendiri adalah MyApp, MyHomePage (main page), InfoCard (identity card), dan ItemCard (tombol aksi)


3. MaterialApp menyiapkan kebutuhan aplikasi Material Design seperti tema global, navigasi, ScaffoldMessenger, MediaQuery, dan arah text. Widget ini dijadikan root karena banyak widget Material membutuhkan ancestor tersebut (misalnya AppBar butuh Theme dan SnackBar butuh ScaffoldMessenger), sehingga semuanya perlu tersedia dari puncak tree.


4. StatelessWidget tidak punya state internal sehingga tampilannya hanya bergantung pada input. StatefulWidget memiliki object State yang bisa berubah dan memicu rebuild lewat setState(). StatelessWidget digunakan untuk tampilan statis seperti MyHomePage, InfoCard, dan ItemCard. Sedangkan StatefulWidget untuk data yang berubah seperti counter, animasi, form, atau data dari API.


5. BuildContext adalah referensi posisi sebuah widget di dalam tree yang diterima sebagai parameter dari build(). Context digunakan untuk mengakses data dari ancestor (contohnya Theme.of(context) untuk warna tema, MediaQuery.of(context) untuk lebar layar, dan ScaffoldMessenger.of(conntext) untuk SnackBar).


6. Hot reload mengupdate perubahan kode ke aplikasi yang sedang berjalan dan membuat ulang tampilan tanpa menghapus state. Hot restart menjalankan ulang applikasi dari main() sehingga state hilang. Hot restart diperlukan ketika mengubah main(), initState(), variable global, atau class structure (misal Stateful menjadi Stateless). Sedangkan full restart diperlukan untuk perubahan kode native atau penambahan package dengan kode native.


Link chat history Claude: https://claude.ai/share/ac70d9d0-56a9-442d-bcc7-44d0bbdcd2be


### Tugas 8

1. push() menambah halaman baru di atas stack sehingga user bisa kembali (back), pushReplacement() mengganti halaman yang sedang tampil sehingga tidak bisa kembali ke halaman sebelumnya, pop() membuang halaman teratas pada stack untuk kembali ke halaman sebelumnya. Formulir dibuka dari card action "Tambah Achievement" dengan Navigator.push(), sedangkan opsi Home di drawer memakai Navigator.pushReplacement() ke MyHomePage() yang menggantikan halaman sekarang dengan halaman utama (menu) sehingga stack tidak menumpuk.


2. Scaffold menyediakan fixed slot (appBar, drawer, body) yang dipakai oleh semua halaman, dan LeftDrawer diwrite sekali lalu dipasang di tiap halaman sehingga struktur dan navigasinya seragam. Contoh warna tema: indigo di seedColor tema, AppBar dan tombol Save di AchievementFormPage dan ProjectFormPage, serta DrawHeader sehingga halaman achievement tetap terasa satu aplikasi dengan halaman-halaman lainnya.


3. Column menyusun empat field (nama, organizer, category, dan dateAwarded) secara vertikal, Padding memberi jarak antar field, dan ShingleChildScrollView membuat form bisa discroll saat space layar terbatas (misalnya ketika keyboard di mobbile terbuka atau showDatePicker memakan space) sehingga tombol save tidak terpotong dan tidak terjadi overflow.


4. GlobaKey<FormState> (_formKey) menghubungkan tombol Save ke form, validator di tiap field mereturn pesan error atau null, dan validate() menjalankan semuanya sebelum dialog ditampilkan. Contoh yang ditolak: Nama Achievement yang lebih dari 100 karakter (pesan "Maksimal 100 karakter!") atau field tanggal yang belum dipilih (pesan "Tanggal harus dipilih!"). Hanya memilih jenis input belum cukup. Field tanggal sudah readOnly dan memakai showDatePicker, tapi pengguna tetap bisa menekan Save tanpa memilih tanggal. Jad, validator tetap diperlukan agar data null atau invalid (luar batas) tidak lolos.


Link chat history Claude: https://claude.ai/share/ffd056bb-7dae-41d2-a699-af3eb8d4b0e8


### AI Disclosure


Saya menggunakan Claude Sonnet 5.5 medium untuk membantu pengerjaan tugas PBP. Strategi yang saya gunakan adalah: meminta untuk menjelaskan bagaimana cara melakukan hal yang dispesifikasikan oleh soal, kemudian saya implementasikan itu sendiri dan meminta feedback apakah sudah sesuai atau belum. Ketika terdapat erorr/bug, saya meminta AI untuk menjelaskan apa bug yang terjadi dan bagaimana caranya untuk memperbaiki hal tersebut. Selain itu, saya juga menggunakan AI untuk bertanya pertanyaan-pertanyaan yang lebih spesifik tentang kegunaan suatu kode.