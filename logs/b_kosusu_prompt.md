# B Koşusu promptu

Kullanıcının B Koşusu için verdiği görev talimatı:

> AGENTS.md dosyasını ve mevcut proje yapısını incele. Şimdi bu ödevin Ratchet altyapısını tamamla ve B Koşusunu gerçekleştir.
>
> ÖNEMLİ: a_kosusu/ klasöründeki orijinal A Koşusu dosyasına kesinlikle dokunma. Onu değiştirme veya silme.
>
> YAPILACAKLAR:
> 1. .ruby-version dosyasına 3.4 yaz.
> 2. CLAUDE.md dosyasını AGENTS.md dosyasına gerçek sembolik bağlantı olarak oluştur. Windows ortamında uygun yöntemi kullan. Gerçek symlink oluşturulamıyorsa bunu açıkça raporla; normal dosyayı symlink gibi gösterme.
> 3. lib/ogrenci.rb dosyasında Ogrenci sınıfını oluştur. ad, durum ve devamsizlik alanları olsun. durum yalnızca :aktif, :donduruldu, :mezun olabilir. devamsizlik 0..10 arasında doğrulansın. aktif? ve mezun? metotları define_method ile tanımlansın.
> 4. lib/devamsizlik_kontrol.rb dosyasında DevamsizlikKontrol sınıfını oluştur. riskli? devamsizlik >= 3, kaldi? devamsizlik >= 4, telafi_gerekir? devamsizlik >= 2 olsun. Kurallar öğrenci nesnesi üzerinden çalışsın.
> 5. method_missing, monkey patch ve standart sınıfların değiştirilmesi kesinlikle yasak.
> 6. test/ogrenci_test.rb içinde Minitest kullanarak sınıfları, geçerli/geçersiz durumları, 0 ve 10 sınırlarını, tam 3 devamsızlığı, 2-3-4 sınırlarını, bilinmeyen metot davranışını ve tüm kuralları test et. Bilinmeyen metot çağrısının NoMethodError verdiğini doğrula.
> 7. bin/kontrol oluştur. Ruby sürümünü kontrol etsin ve tüm Minitest testlerini çalıştırsın. Test başarısızsa sıfırdan farklı çıkış kodu versin.
> 8. RATCHET_LOG.md oluştur. A Koşusu'nda gerçekten gözlemlediğimiz hataları ve bunların hangi kalıcı kurala/teste dönüştüğünü tabloya yaz. Gerçek olmayan hata uydurma.
> 9. README.md oluştur. Kurulum, çalıştırma, mimari, kurallar, testler, A/B Koşusu ve Ölçüm Raporu, Yapamadıklarım bölümleri olsun.
> 10. B Koşusunda bu gereksinimlere göre uygulamayı geliştir, bin/kontrol çalıştır ve sonuçları kaydet.
> 11. logs/ klasöründe A ve B koşularının mevcut gerçek çıktılarını ve promptlarını belgeleyen kanıt dosyaları oluştur. Eksik olan token, maliyet veya süre verilerini uydurma; ölçülemiyorsa açıkça belirt.
> 12. B Koşusunun tur sayısını, testlerin ilk çalıştırmadaki sonucunu ve elde edilebilen token bilgilerini gerçek verilere göre raporla. Bilinmeyen ölçümleri tahmin etme.
>
> KISITLAR:
> - Ruby 3.4 ve standart kütüphane + Minitest dışında gem kullanma.
> - Gereksiz dosya veya mimari oluşturma.
> - Kod sade, okunabilir ve küçük sınıflar halinde olsun.
> - Önce testleri ve kuralları hazırla, ardından uygulamayı doğrula.
> - bin/kontrol tüm testlerden başarıyla geçmeden işi tamamlanmış sayma.
> - Son olarak oluşturduğun dosyaları, test sonuçlarını, symlink durumunu ve eksik kalan işleri özetle.

## Ölçüm kapsamı

Bu dosya bu görev turunda görülen promptu kaydeder. Oturumun token ölçümü, bağımsız çalışma süresi ve ayrıca tanımlanmış tur sayacı araçlardan sağlanmıyor; bu değerler sonuç raporuna tahmin olarak eklenmeyecektir.
