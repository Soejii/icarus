enum VaBankType { bmi, bni, bca, bsi }

extension VaBankTypeX on VaBankType {
  String get label => switch (this) {
        VaBankType.bmi => 'Bank Muamalat Indonesia',
        VaBankType.bni => 'Bank Negara Indonesia',
        VaBankType.bca => 'Bank Central Asia',
        VaBankType.bsi => 'Bank Syariah Indonesia',
      };

  String get bankCode => switch (this) {
        VaBankType.bmi => '147',
        VaBankType.bni => '009',
        VaBankType.bca => '014',
        VaBankType.bsi => '451',
      };

  String get logoAsset => switch (this) {
        VaBankType.bmi => 'assets/images/ic_bmi.png',
        VaBankType.bni => 'assets/images/ic_bni.png',
        VaBankType.bca => 'assets/images/ic_bca.png',
        VaBankType.bsi => 'assets/images/ic_bsi.png',
      };

  String get adminFee => 'Rp 2.000';

  List<Map<String, String>> get instructions => switch (this) {
        VaBankType.bmi => [
            {
              'title': 'Via Mobile banking bank Muamalat',
              'description':
                  '1. Klik menu "semua fitur"\n2. Klik "Virtual Account"\n3. Login\n4. Pilih rekening pengirim lalu masukkan nomor Virtual Account\n5. Klik "Lanjut"\n6. Setelah muncul nama sesuai nama ananda silahkan masukkan TIN mobile banking lalu klik "Lanjut"',
            },
            {
              'title': 'Via Mobile banking selain bank Muamalat',
              'description':
                  '1. Login ke akun\n2. Pilih menu "transfer"\n3. Klik "tambah penerima baru"\n4. Pilih bank Muamalat sebagai bank Tujuan transfer\n5. Masukkan/paste VA (Virtual Account)\n6. Klik "Lanjutkan"\n7. Ketik nominal transfer\n8. Klik "Lanjutkan"',
            },
            {
              'title': 'Via ATM Muamalat',
              'description':
                  '1. Masukkan kartu ATM, lalu input PIN Anda.\n2. Pilih Menu TRANSAKSI LAIN.\n3. Pilih menu PEMBAYARAN kemudian pilih menu VIRTUAL ACCOUNT.\n4. Masukkan Nomor Virtual Account\n5. Tekan BAYAR jika setuju dengan informasi pembayaran.\n6. Periksa kembali Jumlah Tagihan.\n7. Apabila sudah sesuai, tekan BENAR, lalu tekan BAYAR.\n8. Simpan struk ATM sebagai bukti pembayaran.',
            },
            {
              'title': 'Via SKN/LLG/RTGS',
              'description':
                  '1. Tulis Nama Penerima dengan Nama Virtual Account.\n2. Pilih Bank Tujuan, BANK MUAMALAT.\n3. Masukkan Nomor Virtual Account Tujuan\n4. Isi Informasi Pengirim dengan nama dan alamat pengirim dana.\n5. Masukkan nominal jumlah dana yang akan ditransfer.',
            },
            {
              'title': 'Via ATM Bank Lain',
              'description':
                  '1. Pilih menu TRANSFER ANTAR BANK ONLINE.\n2. Isi kode Bank Muamalat (147) diikuti Nomor Virtual Account Muamalat\n3. Masukkan jumlah transaksi. Jumlah transaksi yang diinput harus sama persis dengan informasi tagihan di layar ATM.\n4. Periksa kembali pembayaran Virtual Account.',
            },
            {
              'title': 'Via Internet Banking Bank Lain (Online/LLG)',
              'description':
                  '1. Perhatikan fitur transfer bank lain yang digunakan oleh Internet Banking bank lain tersebut.\n2. Jika fitur transfer yang digunakan adalah Transfer Online, maka mengacu ke panduan pembayaran melalui ATM Bank Lain.\n3. Jika fitur transfer yang digunakan adalah LLG (ex: Klik BCA), maka mengacu ke panduan pembayaran melalui SKN/LLG/RTGS.',
            },
          ],
        VaBankType.bni => [
            {
              'title': 'Via Mobile Banking BNI',
              'description':
                  '1. Login ke BNI Mobile Banking\n2. Pilih menu "Transfer"\n3. Pilih "Virtual Account Billing"\n4. Masukkan Nomor Virtual Account\n5. Konfirmasi transaksi\n6. Masukkan password transaksi\n7. Pembayaran selesai',
            },
            {
              'title': 'Via ATM BNI',
              'description':
                  '1. Masukkan kartu ATM dan PIN\n2. Pilih menu "Menu Lainnya"\n3. Pilih "Transfer"\n4. Pilih "Rekening BNI"\n5. Masukkan Nomor Virtual Account\n6. Masukkan jumlah pembayaran\n7. Konfirmasi dan selesaikan transaksi',
            },
            {
              'title': 'Via Internet Banking BNI',
              'description':
                  '1. Login ke BNI Internet Banking\n2. Pilih menu "Transfer"\n3. Pilih "Virtual Account Billing"\n4. Masukkan Nomor Virtual Account\n5. Pilih rekening debit\n6. Konfirmasi transaksi dengan token',
            },
            {
              'title': 'Via ATM Bank Lain',
              'description':
                  '1. Pilih menu "Transfer Antar Bank"\n2. Masukkan kode bank BNI (009)\n3. Masukkan Nomor Virtual Account\n4. Masukkan jumlah pembayaran\n5. Konfirmasi dan selesaikan transaksi',
            },
          ],
        VaBankType.bca => [
            {
              'title': 'Via m-BCA (BCA Mobile)',
              'description':
                  '1. Login ke BCA Mobile\n2. Pilih menu "m-Transfer"\n3. Pilih "BCA Virtual Account"\n4. Masukkan Nomor Virtual Account\n5. Periksa informasi tagihan, klik "OK"\n6. Masukkan PIN m-BCA\n7. Simpan bukti pembayaran',
            },
            {
              'title': 'Via KlikBCA (Internet Banking)',
              'description':
                  '1. Login ke KlikBCA Individual\n2. Pilih menu "Transfer Dana"\n3. Pilih "Transfer ke BCA Virtual Account"\n4. Masukkan Nomor Virtual Account\n5. Periksa informasi tagihan, klik "Lanjutkan"\n6. Masukkan respon KeyBCA APPLI 1\n7. Simpan bukti pembayaran',
            },
            {
              'title': 'Via ATM BCA',
              'description':
                  '1. Masukkan kartu ATM, lalu input PIN Anda.\n2. Pilih menu "Transaksi Lainnya".\n3. Pilih menu "Transfer".\n4. Pilih "ke Rek BCA Virtual Account".\n5. Masukkan Nomor Virtual Account.\n6. Periksa informasi tagihan, tekan "Benar" jika setuju.\n7. Simpan struk ATM sebagai bukti pembayaran.',
            },
            {
              'title': 'Via ATM / Mobile Banking Bank Lain',
              'description':
                  '1. Pilih menu "Transfer Antar Bank Online".\n2. Isi kode Bank BCA (014) diikuti Nomor Virtual Account BCA.\n3. Masukkan jumlah transaksi. Jumlah transaksi yang diinput harus sama persis dengan informasi tagihan.\n4. Periksa kembali pembayaran Virtual Account.\n5. Simpan bukti pembayaran.',
            },
          ],
        VaBankType.bsi => [
            {
              'title': 'Via BSI Mobile',
              'description':
                  '1. Login ke BSI Mobile\n2. Pilih menu "Transfer"\n3. Pilih "Virtual Account"\n4. Masukkan Nomor Virtual Account\n5. Periksa informasi tagihan, klik "Lanjutkan"\n6. Masukkan PIN BSI Mobile\n7. Simpan bukti pembayaran',
            },
            {
              'title': 'Via Mobile Banking Bank Lain',
              'description':
                  '1. Login ke akun\n2. Pilih menu "Transfer"\n3. Klik "Tambah penerima baru"\n4. Pilih BSI sebagai bank tujuan transfer\n5. Masukkan/paste Nomor Virtual Account\n6. Klik "Lanjutkan"\n7. Ketik nominal transfer\n8. Klik "Lanjutkan"',
            },
            {
              'title': 'Via ATM BSI',
              'description':
                  '1. Masukkan kartu ATM, lalu input PIN Anda.\n2. Pilih Menu TRANSAKSI LAIN.\n3. Pilih menu PEMBAYARAN kemudian pilih menu VIRTUAL ACCOUNT.\n4. Masukkan Nomor Virtual Account\n5. Periksa informasi tagihan.\n6. Tekan BAYAR jika setuju dengan informasi pembayaran.\n7. Simpan struk ATM sebagai bukti pembayaran.',
            },
            {
              'title': 'Via ATM Bank Lain',
              'description':
                  '1. Pilih menu TRANSFER ANTAR BANK ONLINE.\n2. Isi kode Bank BSI (451) diikuti Nomor Virtual Account BSI\n3. Masukkan jumlah transaksi. Jumlah transaksi yang diinput harus sama persis dengan informasi tagihan di layar ATM.\n4. Periksa kembali pembayaran Virtual Account.',
            },
          ],
      };
}
