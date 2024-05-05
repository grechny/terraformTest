locals {
  characters = "abcdefghijklmnopqrstuvwxyz0123456789"
  shuffled_chars = random_shuffle(split("", local.characters))
  random_chars = join("", slice(local.shuffled_chars, 0, 4))
}