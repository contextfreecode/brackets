darken() {
  scale=0.5
  gap=""
  for value in "$@"; do
    dark=$(echo "$scale * $value" | bc | sed 's/^\./0./')
    printf "$gap$dark"
    gap=" "
  done
}

declare -A named_colors=(
  [red]="1 0 0"
  [yellow]="1 1 0"
  [blue]="0 0 1"
)

names=(red yellow blue)

# Different logic than other languages because harder.
for name in "${names[@]}"; do
  rgb="${named_colors[$name]}"
  dark="$(darken $rgb)"
  echo $name - $rgb - $dark
done
