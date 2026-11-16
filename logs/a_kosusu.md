# A Koşusu kanıtı

## Gözlemlenebilen istekler

1. Kullanıcının ilk isteği: “Öğrenci devamsızlık kontrolü yap, devamsızlık sınırı %30'dur.”
2. Düzeltme isteği: “Bu görev için herhangi bir Excel, CSV veya PDF dosyasına ihtiyacım yok. İstenen şey Ruby ile çalışan bir öğrenci devamsızlık kontrol uygulamasıdır. Çalışma klasöründe gerekli Ruby kodunu oluştur.”

## Gözlemlenen çıktı

Asistan `a_kosusu/devamsizlik_kontrol.rb` dosyasını oluşturduğunu ve `ruby devamsizlik_kontrol.rb` ile çalıştırılacağını bildirdi. Dosya statik incelemesinde CLI girdisi alan, yüzde 30 oranını hesaplayan tek `DevamsizlikKontrol` sınıfı görülüyor. A Koşusu için test komutu çıktısı veya çalışma kaydı mevcut değil.

## Gözlenen eksikler ve kalıcılaştırma

| A Koşusu'nda gözlenen durum | Kalıcı kural veya B testi |
| --- | --- |
| İlk yanıtta veri dosyası arandı; kullanıcı Ruby uygulaması istediğini açıklamak zorunda kaldı. | `AGENTS.md` mimariyi ve sınıfları açıkça tanımlar; B testi gerekli sınıfları doğrular. |
| A kodunda `Ogrenci` modeli ve `Ogrenci` nesnesi üstünden çalışan kural denetimi yok. | `AGENTS.md` Ogrenci ve DevamsizlikKontrol sınıflarını zorunlu kılar; B testleri denetleyicinin öğrenci nesnesini kullandığını doğrular. |
| A kodundaki tek eşik yüzde 30'dur; 2/3/4 devamsızlık kuralları bulunmuyor. | `AGENTS.md` eşikleri sabitler; B testi 2, 3 ve 4 için bütün kuralları doğrular. |
| A uygulamasındaki `siniri_asti?` metodu `oran > 30.0` kullanır. Tam 3 devamsızlık / 10 ders = %30 olduğundan, bu sınır durumu yanlış biçimde “SINIR İÇİNDE” olarak sınıflandırılır. | Kalıcı kural `riskli?` için `devamsizlik >= 3` olmalıdır. B regresyon testi: `test_exactly_three_absences_is_risky`. |
| A Koşusu için doğrulanabilir test/çalıştırma çıktısı kaydedilmemiş. | B'de `bin/kontrol` ve Minitest kullanılır; bu kanıt dosyasında A için eksik çıktı açıkça belirtilir. |

## Ölçüm verisi

- Prompt: Yukarıdaki iki kullanıcı isteği bu konuşmada görülebiliyor.
- Kod kanıtı: `a_kosusu/devamsizlik_kontrol.rb` (değiştirilmedi).
- Ham test stdout/stderr, ilk test sonucu, token, maliyet ve süre: mevcut kayıtta yok; ölçülemiyor.
- Tur sayısı: ayrı A Koşusu çalışma günlüğü bulunmadığından doğrulanamıyor.
