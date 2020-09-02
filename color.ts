interface Color3 {
  kind: "hsv" | "rgb";
  value: [number, number, number];
}

type Color =
  | { kind: "hsv"; h: number; s: number; v: number }
  | { kind: "named"; name: string }
  | { kind: "rgb"; r: number; g: number; b: number };

interface Colorable {
  toRgb(): Rgb;
}

class Hsv implements Colorable {
  constructor(h: number, s: number, v: number) {
    this.h = h;
    this.s = s;
    this.v = v;
  }

  h: number;
  s: number;
  v: number;

  toRgb() {
    let { h, s, v } = this;
    let c = s * v;
    let h1 = h * 6;
    let x = c * (1 - Math.abs(h1 % 2 - 1));
    // deno-fmt-ignore
    let [r1, g1, b1] =
      h1 < 1 ? [c, x, 0] :
      h1 < 2 ? [x, c, 0] :
      h1 < 3 ? [0, c, x] :
      h1 < 4 ? [0, x, c] :
      h1 < 5 ? [x, 0, c] :
      [c, 0, x];
    let m = v - c;
    return new Rgb(r1 + m, g1 + m, b1 + m);
  }
}

class NamedColor implements Colorable {
  constructor(name: string) {
    this.name = name;
  }

  name: string;

  toRgb() {
    return namedColors[this.name];
  }
}

class Rgb implements Colorable {
  constructor(r: number, g: number, b: number) {
    this.r = r;
    this.g = g;
    this.b = b;
  }

  r: number;
  g: number;
  b: number;

  toRgb() {
    return this;
  }
}

const namedColors: { [name: string]: Rgb } = {
  red: new Rgb(1, 0, 0),
  yellow: new Rgb(1, 1, 0),
  blue: new Rgb(0, 0, 1),
};

function main() {
  let colors: Colorable[] = [
    new Hsv(1, 1, 1),
    new NamedColor("yellow"),
    new Rgb(0, 0, 1),
  ];
  console.log(colors);
  console.log(colors.map((color) => color.toRgb()));
}

main();
