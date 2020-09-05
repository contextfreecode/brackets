case class Rgb(r: Double, g: Double, b: Double)

def darken(rgb: Rgb): Rgb = {
  val scale = 0.5
  Rgb(scale * rgb.r, scale * rgb.g, scale * rgb.b)
  // rgb match {
  //   case Rgb(r, g, b) => Rgb(scale * r, scale * g, scale * b)
  // }
}

val NamedColors = Map(
  "red" -> Rgb(1, 0, 0),
  "yellow" -> Rgb(1, 1, 0),
  "blue" -> Rgb(0, 0, 1),
)

@main def color = {
  val names = Vector[String]("red", "yellow", "blue")
  val rgbs = names.map(name => NamedColors(name))
  val darks = rgbs.map(darken)
  for (i <- 0 until names.length) {
    println(s"${names(i)} ${rgbs(i)} ${darks(i)}")
  }
}
