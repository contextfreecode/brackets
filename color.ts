type Rgb = { r: number; g: number; b: number };

function rgbOf(r: number, g: number, b: number): Rgb {
  return { r, g, b };
}

function darken({ r, g, b }: Rgb): Rgb {
  let scale = 0.5;
  return rgbOf(scale * r, scale * g, scale * b);
  // TS 4.1 should allow for TupleN types.
  // let scaled = [r, g, b].map((x) => scale * x) as [Item, Item, Item];
  // return rgbOf.apply(null, scaled);
}

// Pretend I deep froze this or something.
const namedColors: Record<string, Rgb> = {
  red: rgbOf(1, 0, 0),
  yellow: rgbOf(1, 1, 0),
  blue: rgbOf(0, 0, 1),
};

function main() {
  let names = ["red", "yellow", "blue"];
  let rgbs = names.map((name) => namedColors[name]);
  let darks = rgbs.map(darken);
  for (let i = 0; i < names.length; i += 1) {
    console.log(names[i], rgbs[i], darks[i]);
  }
}

main();
