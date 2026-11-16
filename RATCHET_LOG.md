# Ratchet günlüğü

Tablo yalnızca A Koşusu kayıtlarında görülen eksikleri listeler. A için test hatası uydurulmamıştır; test çıktısı kaydı yoktur.

| A Koşusu'nda gözlenen eksik | Kalıcı kural (`AGENTS.md`) | İlgili B regresyon testi |
| --- | --- | --- |
| İlk yanıtta veri dosyası arandı; kullanıcı Ruby uygulaması istediğini ikinci promptta açıklamak zorunda kaldı. | Uygulamada `Ogrenci` ve `DevamsizlikKontrol` bulunmalı; iş mantığı bu sınıflarda olmalı. | `test_has_required_classes_and_attributes` |
| A kodunda `Ogrenci` modeli yok; CLI doğrudan ad ve ders sayılarıyla yüzde hesabı yapıyor. | `Ogrenci` alanları tanımlı olmalı; devamsızlık kuralları öğrenci nesnesi üzerinden çalışmalı. | `test_has_required_classes_and_attributes`, `test_rules_read_absence_count_from_student` |
| A'da öğrenci durumu, 0..10 devamsızlık doğrulaması ve `aktif?`/`mezun?` sorguları yok. | Durum kümesi ve devamsızlık aralığı sabit; iki sorgu `define_method` ile tanımlı olmalı. | `test_accepts_each_allowed_status_and_rejects_other_statuses`, `test_validates_absence_boundaries`, `test_status_queries_are_defined_and_return_expected_values`, `test_unknown_method_raises_no_method_error` |
| A'daki `siniri_asti?` `oran > 30.0` kullanıyor. 10 dersin 3'ünde devamsızlık tam %30 eder ve `>` nedeniyle “SINIR İÇİNDE” sayılır; bu sınır hatası koddan gözleniyor, A için başarısız test çıktısı kaydı yok. | `AGENTS.md`: risk `devamsizlik >= 3`; tam 3 devamsızlık risklidir. | `test_exactly_three_absences_is_risky` |
| A yalnızca yüzde 30 sınırını hesaplıyor; 2/3/4 devamsızlık kuralları yok. | `telafi_gerekir? >= 2`, `riskli? >= 3`, `kaldi? >= 4`. | `test_attendance_rules_at_two_three_and_four_absences`, `test_exactly_three_absences_is_risky` |
| A Koşusu için Minitest/`bin/kontrol` çıktısı kaydedilmemiş. | Testler Minitest ile yazılmalı ve değişikliklerden sonra `bin/kontrol` çalıştırılmalı. | B'nin Minitest dosyaları ve `bin/kontrol`; A için geriye dönük test sonucu bulunmuyor. |

Kaynak kanıtı `a_kosusu/devamsizlik_kontrol.rb` dosyasıdır; bu dosya değiştirilmemiştir. İlk yanıttaki dosya arama davranışı iki A promptunu belgeleyen `logs/a_kosusu.md` kaydıyla desteklenir.

A kaynak dosyasında `pozitif_tam_sayi_oku` adlı üst düzey girdi yardımcısı da vardır. Kayıtlar bu yardımcının gereksiz olduğunu kanıtlamadığından, `AGENTS.md` kuralı 13'e aykırılık olarak sayılmamıştır. Mevcut test takımında gereksiz global metotları doğrudan saptayan bir regresyon testi yoktur.
