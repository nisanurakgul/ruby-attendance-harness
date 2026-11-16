# frozen_string_literal: true

class Ogrenci
  DURUMLAR = %i[aktif donduruldu mezun].freeze

  attr_reader :ad, :durum, :devamsizlik

  def initialize(ad:, durum:, devamsizlik:)
    @ad = String(ad)
    self.durum = durum
    self.devamsizlik = devamsizlik
  end

  define_method(:aktif?) { @durum == :aktif }
  define_method(:mezun?) { @durum == :mezun }

  private

  def durum=(deger)
    raise ArgumentError, "Geçersiz öğrenci durumu: #{deger.inspect}" unless DURUMLAR.include?(deger)

    @durum = deger
  end

  def devamsizlik=(deger)
    unless deger.is_a?(Integer) && (0..10).cover?(deger)
      raise ArgumentError, "Devamsızlık 0 ile 10 arasında bir tam sayı olmalıdır."
    end

    @devamsizlik = deger
  end
end
