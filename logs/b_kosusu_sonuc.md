# B Koşusu sonuç kanıtı

## Prompt sayısı

`logs/b_kosusu_prompt.md` içinde B Koşusu için **1 prompt** kayıtlıdır. Bu sayı belgelenmiş B Koşusu prompt dosyasına dayanır.

## İlk doğrulama denemesi

Komut: `ruby bin/kontrol`

İlk denemede kaydedilen kabuk sonucu:

```text
EXIT_CODE=-1073741790
```

Bu çalıştırmada Ruby çalışma zamanı başlatılamadı; Minitest özeti oluşmadı. Bu tarihsel deneme başarısız/ölçümsüzdür ve sonraki başarılı doğrulamayla karıştırılmamalıdır.

## Sonraki manuel ve otomatik doğrulama

2026-11-17 tarihli kullanıcı bildirimi:

- Manuel `ruby bin/kontrol`: 8 test, 32 assertion, 0 failures, 0 errors.
- PowerShell 5.1 izleyicisi başarıyla başlatıldı.
- `lib/watch_test.rb` değişikliği algılandı; izleyici `ruby bin/kontrol` çalıştırdı.
- Otomatik sonuç: 8 test, 32 assertion, 0 failures, 0 errors; `Control passed.`

Bu sonuçlar kullanıcı tarafından sağlanan gerçek çalıştırma bilgisidir; bu mesajda ham konsol dökümü veya ayrı çıktı dosyası eklenmemiştir.

## Symlink durumu

İlk oluşturma denemesi yönetici ayrıcalığı hatası verdi. Sonraki proje incelemesinde `CLAUDE.md` öğesi `SymbolicLink` olarak ve hedefi `AGENTS.md` olarak görüldü. Güncel durum gerçek sembolik bağlantıdır; normal dosya değildir.

## Önceki izleyici ortam denemesi

Bu çalışma alanındaki ayrı Codex araç çalıştırmasında geçici `scripts/watcher_probe.rb` değişikliği algılandı ve `ruby bin/kontrol` çağrıldı; o araç sürecinde Ruby `-1073741790` ile sonlandı. Bu ayrı araç çalıştırması, kullanıcı tarafından bildirilen başarılı PowerShell 5.1 `lib/watch_test.rb` doğrulamasından farklı bir çalıştırma bağlamıdır.

Bu dokümantasyon denetiminin son `ruby bin/kontrol` denemesi de aynı araç ortamında `FINAL_RUBY_CONTROL_EXIT_CODE=-1073741790` verdi. Bu deneme kullanıcı tarafından bildirilen manuel ve otomatik başarılı çalıştırmaları geçersiz kılmaz; bu yürütme bağlamında yeniden üretilemediğini gösterir.

## Ölçümler ve A Koşusu

- Token kullanımı, maliyet ve süre: ölçülmedi; belirtilmedi.
- A Koşusu için ham test/terminal çıktısı: mevcut değil; `logs/a_kosusu.md` kaydına bakın.
