# frozen_string_literal: true

require_relative "ogrenci"

class DevamsizlikKontrol
  def initialize(ogrenci)
    raise ArgumentError, "Bir Ogrenci nesnesi gereklidir." unless ogrenci.is_a?(Ogrenci)

    @ogrenci = ogrenci
  end

  def riskli?
    @ogrenci.devamsizlik >= 3
  end

  def kaldi?
    @ogrenci.devamsizlik >= 4
  end

  def telafi_gerekir?
    @ogrenci.devamsizlik >= 2
  end
end
