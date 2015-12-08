# encoding: UTF-8

require 'colorize'

class Decoder
  MESSAGE = "000 101 101 001 101 010 110 010 011 001 001 000 000 100 001"
  DICTIONARY = %w{армия мицар мария тарту рация марта марат тиара}
  ALPHABET = %w{м и ц а р я т у}

  def initialize
    encoded_sting = MESSAGE.split(' ').reverse.each_slice(5).to_a.reverse.flatten.join('')
    @words = encoded_sting.scan(/(\d{15})/).flatten
  end

  def run
    encoded_alph_array = alphabet_permutation_with_numeric
    encoded_alph_array.each do |encoded_alph|
      dictionary = encode_dictionary_by encoded_alph
      noises = dictionary.map { |word| compare_word(@words[0], word) }

      noises.each do |noise|
        new_words = Array.new(@words.count) { |i| decode_word_by(encoded_alph, compare_word(@words[i], noise)) }

        # p new_words
        if new_words.all? { |word| DICTIONARY.include?(word) }
          puts ('='*50).to_s.blue
          puts 'Encoded: '.green + "#{@words.inspect}".red
          puts 'Decoded: '.green + "#{new_words.join(' ')}".red
          puts 'Alphabet: '.green + "#{encoded_alph.inspect}".red
          puts 'Noise: '.green + "#{noise.inspect}".red
          puts ('='*50).to_s.blue
        end
      end
    end

  end

  private

  def compare_word(word1, word2)
    "%0#{15}d" % (word1.to_i(2) ^ word2.to_i(2)).to_s(2)
  end

  def encode_word_by alphabet, word
    word.split('').map { |symbol| alphabet[symbol] }.join('')
  end

  def decode_word_by alphabet, word
    alphabet = alphabet.invert
    word.scan(/(\d{3})/).flatten.map { |code| alphabet[code] }.join('')
  end

  # return encoded words
  def encode_dictionary_by alphabet
    DICTIONARY.map { |word| encode_word_by alphabet, word }
  end

  def alphabet_permutation_with_numeric
    ALPHABET.permutation.to_a.map do |alphabet|
      to_hash_with_numeric(alphabet)
    end
  end

  # method for alphabet_permutation_with_numeric
  def to_hash_with_numeric(alphabet)
    alphabet.zip(numeric_sequence).to_h
  end

  # method for alphabet_permutation_with_numeric
  def numeric_sequence
    sym_count = ALPHABET.count
    @numeric_sequence ||= (0...sym_count).to_a.map { |number| "%0#{nearest_power_of_two(sym_count)}d" % number.to_s(2) }
  end

  # method for numeric_sequence
  def nearest_power_of_two(number)
    count, n = 1, 2

    while (n < number)
      n = n**2
      count += 1
    end

    count
  end


end

Decoder.new.run
