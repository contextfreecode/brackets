Rgb = Struct.new(:r, :g, :b)

def darken(rgb)
  scale = 0.5
  Rgb.new(*rgb.to_a.map { |x| scale * x })
end

NAMED_COLORS = {
  :red => Rgb.new(1.0, 0.0, 0.0),
  :yellow => Rgb.new(1.0, 1.0, 0.0),
  :blue => Rgb.new(0.0, 0.0, 1.0),
}

def main
  names = [:red, :yellow, :blue]
  rgbs = names.map { |name| NAMED_COLORS[name] }
  darks = rgbs.map(&method(:darken))
  names.length.times do |i|
    puts "#{names[i]} #{rgbs[i]} #{darks[i]}"
  end
end

main
