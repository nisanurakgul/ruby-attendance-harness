# frozen_string_literal: true

# Öğrencinin devamsızlık oranını hesaplar ve %30 sınırına göre durumunu bildirir.
class DevamsizlikKontrol
  SINIR_YUZDESI = 30.0

  def initialize(ad:, toplam_ders:, devamsizlik:)
    @ad = ad.strip
    @toplam_ders = Integer(toplam_ders)
    @devamsizlik = Integer(devamsizlik)

    raise ArgumentError, "Öğrenci adı boş olamaz." if @ad.empty?
    raise ArgumentError, "Toplam ders sayısı sıfırdan büyük olmalıdır." unless @toplam_ders.positive?
    unless @devamsizlik.between?(0, @toplam_ders)
      raise ArgumentError, "Devamsızlık, 0 ile toplam ders sayısı arasında olmalıdır."
    end
  end

  def oran
    @devamsizlik.to_f / @toplam_ders * 100
  end

  def siniri_asti?
    oran > SINIR_YUZDESI
  end

  def rapor
    durum = siniri_asti? ? "SINIRI AŞTI" : "SINIR İÇİNDE"
    kalan = [(@toplam_ders * SINIR_YUZDESI / 100).floor - @devamsizlik, 0].max

    [
      "Öğrenci: #{@ad}",
      "Devamsızlık: #{@devamsizlik}/#{@toplam_ders} ders (#{format('%.2f', oran)}%)",
      "İzin verilen sınır: %#{format('%g', SINIR_YUZDESI)}",
      "Durum: #{durum}",
      ("Sınırı aşmadan yapılabilecek ek devamsızlık: #{kalan} ders" unless siniri_asti?)
    ].compact.join("\n")
  end
end

def pozitif_tam_sayi_oku(etiket, sifir_olabilir: false)
  loop do
    print "#{etiket}: "
    girdi = $stdin.gets
    return nil if girdi.nil?

    begin
      deger = Integer(girdi, 10)
      return deger if sifir_olabilir ? deger >= 0 : deger.positive?

      puts(sifir_olabilir ? "0 veya daha büyük bir tam sayı girin." : "Sıfırdan büyük bir tam sayı girin.")
    rescue ArgumentError
      puts "Lütfen tam sayı girin."
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts "Öğrenci Devamsızlık Kontrolü (sınır: %#{format('%g', DevamsizlikKontrol::SINIR_YUZDESI)})"
  print "Öğrenci adı: "
  ad = $stdin.gets&.strip

  if ad.nil? || ad.empty?
    warn "Öğrenci adı boş olamaz."
    exit 1
  end

  toplam = pozitif_tam_sayi_oku("Toplam ders sayısı")
  devamsizlik = pozitif_tam_sayi_oku("Devamsız olunan ders sayısı", sifir_olabilir: true)
  exit 1 if toplam.nil? || devamsizlik.nil?

  begin
    puts "\n#{DevamsizlikKontrol.new(ad: ad, toplam_ders: toplam, devamsizlik: devamsizlik).rapor}"
  rescue ArgumentError => e
    warn e.message
    exit 1
  end
end
