# Öğrenci Devamsızlık Kontrolü

## Kurulum

Ruby 3.4 ve Minitest gerekir. Minitest Ruby standart kütüphanesindedir; harici gem veya PowerShell modülü kullanılmaz. Otomatik izleyici için Windows PowerShell 5.1 gerekir. `.ruby-version` dosyası Ruby sürümünü `3.4` olarak belirtir.

`CLAUDE.md`, `AGENTS.md` dosyasına işaret eden gerçek bir `SymbolicLink`'tir.

## Çalıştırma

Tek seferlik test:

```powershell
ruby bin/kontrol
```

PowerShell 5.1'de otomatik izleyiciyi proje kökünden başlatın:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\watch-ruby.ps1
```

Parametresiz başlatmada `AuthorizationManager check failed` oluştuğundan, bu komut izleyici için ayrı bir PowerShell sürecini `-ExecutionPolicy Bypass` ile açar. Bu seçenek yalnızca o sürece uygulanır; kullanıcı veya makine yürütme politikası kalıcı olarak değiştirilmez. İzleyici `.rb` dosyaları veya `bin/kontrol` değiştiğinde kontrolü başlatır. İzleme konsolunda `Ctrl+C` ile durdurulur.

## Mimari

- `Ogrenci`, ad, durum ve doğrulanmış devamsızlık sayısını tutar.
- `DevamsizlikKontrol`, kuralları bir `Ogrenci` nesnesi üzerinden değerlendirir.
- `scripts/watch-ruby.ps1`, PowerShell 5.1 `FileSystemWatcher` olaylarıyla Ruby dosyalarının değişimini izler.
- `bin/kontrol`, Ruby sürümünü denetler ve `test/` altındaki Minitest dosyalarını çalıştırır.

## Kurallar

- Durum yalnızca `:aktif`, `:donduruldu` veya `:mezun` olabilir.
- Devamsızlık 0..10 arasında bir tam sayıdır.
- `aktif?` ve `mezun?` sorguları `define_method` ile tanımlanır.
- `telafi_gerekir?`, devamsızlık en az 2 olduğunda `true` döndürür.
- `riskli?`, devamsızlık en az 3 olduğunda `true` döndürür; tam 3 de risklidir.
- `kaldi?`, devamsızlık en az 4 olduğunda `true` döndürür.
- `method_missing`, monkey patch ve standart sınıfları değiştirmek yasaktır.

## Testler

`ruby bin/kontrol`, Ruby 3.4 sürümünü kontrol eder ve tüm Minitest testlerini çalıştırır. Test hatalarında sıfırdan farklı çıkış kodu verir. Proje sahibi tarafından bildirilen manuel sonuç: **8 test, 32 assertion, 0 failures, 0 errors**.

Otomatik izleyici doğrulamasında PowerShell 5.1 başlatıldı, `lib/watch_test.rb` değişikliği algılandı ve `ruby bin/kontrol` otomatik çalıştı. Bildirilen sonuç: **8 test, 32 assertion, 0 failures, 0 errors; `Control passed.`**

## A/B Koşusu ve Ölçüm Raporu

Prompt sayıları kayıt dosyalarına göredir: A Koşusu için `logs/a_kosusu.md` içinde **2 prompt**, B Koşusu için `logs/b_kosusu_prompt.md` içinde **1 prompt** belgelenmiştir.

A Koşusu yüzde 30 hesabı yapan tek dosyalı bir CLI ile sonuçlandı; kayıtlarda test çıktısı bulunmuyor. B Koşusu, öğrenci modeli ve 2/3/4 devamsızlık kuralları için Minitest içerir. B'nin ilk doğrulama denemesinde çalışma ortamı Ruby'yi başlatamamıştı; sonraki manuel ve otomatik başarılı sonuçlar yukarıda ve `logs/b_kosusu_sonuc.md` içinde ayrıca kaydedilmiştir.

Token kullanımı, maliyet ve süre kayıt dosyalarında ölçülmemiştir; değerler belirtilmemiştir.

## Yapamadıklarım

A Koşusu için geriye dönük test sonucu veya ham terminal çıktısı yoktur. Token, maliyet ve süre ölçümleri de mevcut kayıtlardan elde edilemiyor. Bu denetimdeki ayrı Codex araç çalıştırması `ruby bin/kontrol` için `-1073741790` döndürdü; bu, proje sahibinin bildirdiği başarılı manuel ve izleyici çalıştırmalarından farklı bir sonuçtur. A kaynak kodundaki global girdi yardımcısının gereksiz olduğu kanıtlanamadığından ihlal sayılmadı; mevcut test takımında gereksiz global metotları doğrudan saptayan test de yoktur.
