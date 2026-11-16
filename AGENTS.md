# Proje kuralları

- Ruby sürümü 3.4 olmalı; `.ruby-version` dosyasının içeriği `3.4` olmalı.
- Yalnızca Ruby standart kütüphanesi ve Minitest kullanılabilir. Harici gem eklenemez.
- Uygulamada `Ogrenci` ve `DevamsizlikKontrol` sınıfları bulunmalı.
- `Ogrenci` sınıfı `ad`, `durum` ve `devamsizlik` alanlarına sahip olmalı.
- `durum` yalnızca `:aktif`, `:donduruldu` veya `:mezun` olabilir.
- `devamsizlik` değeri `0..10` aralığında olmalı.
- `aktif?` ve `mezun?` sorguları `define_method` kullanılarak açıkça tanımlanmalı.
- `method_missing` kullanımı kesinlikle yasaktır.
- Monkey patch yapmak veya standart sınıfları değiştirmek kesinlikle yasaktır.
- Riskli devamsızlık kuralı `devamsizlik >= 3` olmalı; tam 3 devamsızlık risklidir.
- Kalma kuralı `devamsizlik >= 4` olmalı.
- Özgün sorgu `telafi_gerekir?` olmalı ve `devamsizlik >= 2` olduğunda `true` döndürmeli.
- İş mantığı `Ogrenci` ve `DevamsizlikKontrol` sınıflarında bulunmalı; gereksiz global metot yazılmamalı.
- Kod Ruby 3.4 ile uyumlu, okunabilir ve küçük sınıflar halinde olmalı.
- Testler Minitest ile yazılmalı.
- Her değişiklikten sonra `bin/kontrol` doğrulaması çalıştırılmalı.
