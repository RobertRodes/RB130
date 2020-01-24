class InvalidCodonError < StandardError
  def initialize(codon = nil)
    codon = codon.nil? ? 'Invalid codon' : "#{codon} is not a valid codon."
    super
  end
end

class Translation
  CODONS = {
    %w(AUG)             => 'Methionine',
    %w(UUU UUC)         => 'Phenylalanine',
    %w(UUA UUG)         => 'Leucine',
    %w(UCU UCC UCA UCG) => 'Serine',
    %w(UAU UAC)         => 'Tyrosine',
    %w(UGU UGC)         => 'Cysteine',
    %w(UGG)             => 'Tryptophan',
    %w(UAA UAG UGA)     => 'STOP'
  }.freeze

  class << self
    def of_codon(codon)
      CODONS.find(lambda { fail InvalidCodonError.new(codon) }) do |k, _| 
        k.include?(codon)
      end.last
    end

    def of_rna(strand)
      strand.chars.each_slice(3).with_object([]) do |slice, ary|
        codon = Translation.of_codon(slice.join)
        return ary if codon == 'STOP'
        ary << codon
      end
    end
  end
end

# p Translation.of_codon('UAC')

# p Translation.of_rna('AUGUUUUUAUCUUACUGUUAGUGG')
