object ListSort extends App {
  val keywords = List("Apple", "Ananas", "Mango", "Banana", "Beer")
  val result = keywords.sorted.groupBy(_.head)
  println(result)
}
