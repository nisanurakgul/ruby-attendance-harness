# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/ogrenci"
require_relative "../lib/devamsizlik_kontrol"

class OgrenciTest < Minitest::Test
  def test_has_required_classes_and_attributes
    ogrenci = Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 0)

    assert_kind_of Ogrenci, ogrenci
    assert_respond_to ogrenci, :ad
    assert_respond_to ogrenci, :durum
    assert_respond_to ogrenci, :devamsizlik
    assert_kind_of DevamsizlikKontrol, DevamsizlikKontrol.new(ogrenci)
  end

  def test_accepts_each_allowed_status_and_rejects_other_statuses
    %i[aktif donduruldu mezun].each do |durum|
      assert_equal durum, Ogrenci.new(ad: "Ada", durum: durum, devamsizlik: 0).durum
    end

    assert_raises(ArgumentError) { Ogrenci.new(ad: "Ada", durum: :beklemede, devamsizlik: 0) }
  end

  def test_validates_absence_boundaries
    assert_equal 0, Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 0).devamsizlik
    assert_equal 10, Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 10).devamsizlik
    assert_raises(ArgumentError) { Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: -1) }
    assert_raises(ArgumentError) { Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 11) }
  end

  def test_status_queries_are_defined_and_return_expected_values
    aktif = Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 0)
    mezun = Ogrenci.new(ad: "Ada", durum: :mezun, devamsizlik: 0)

    assert aktif.aktif?
    refute aktif.mezun?
    refute mezun.aktif?
    assert mezun.mezun?
  end

  def test_unknown_method_raises_no_method_error
    ogrenci = Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 0)

    assert_raises(NoMethodError) { ogrenci.tanimlanmamis_sorgu }
  end

  def test_attendance_rules_at_two_three_and_four_absences
    expected = {
      2 => [false, false, true],
      3 => [true, false, true],
      4 => [true, true, true]
    }

    expected.each do |devamsizlik, (riskli, kaldi, telafi_gerekir)|
      kontrol = DevamsizlikKontrol.new(Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: devamsizlik))

      assert_equal riskli, kontrol.riskli?, "#{devamsizlik} devamsızlık riskli?"
      assert_equal kaldi, kontrol.kaldi?, "#{devamsizlik} devamsızlıkta kaldı?"
      assert_equal telafi_gerekir, kontrol.telafi_gerekir?, "#{devamsizlik} devamsızlıkta telafi?"
    end
  end

  def test_exactly_three_absences_is_risky
    kontrol = DevamsizlikKontrol.new(Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 3))

    assert kontrol.riskli?
    refute kontrol.kaldi?
  end

  def test_rules_read_absence_count_from_student
    ogrenci = Ogrenci.new(ad: "Ada", durum: :aktif, devamsizlik: 4)

    assert DevamsizlikKontrol.new(ogrenci).riskli?
    assert DevamsizlikKontrol.new(ogrenci).kaldi?
    assert DevamsizlikKontrol.new(ogrenci).telafi_gerekir?
  end
end
