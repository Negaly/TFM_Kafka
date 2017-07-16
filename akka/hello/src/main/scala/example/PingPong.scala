import akka.actor._, akka.actor.Actor._

case object Ping
case object Pong
case object Stop
class PongActor extends Actor {
  def receive = {
    case Ping  ⇒ {
      println(self.path + ": Received Ping!")
      sender ! Pong
    }
    case Stop ⇒  {
    	println("Stop")
	context.stop(self)
    }
    case _  ⇒ ()
  }
}

class PingActor extends Actor {
  var count = 0
  var t0 = System.nanoTime()
  context.actorSelection("../Pong*") ! Ping // starts things off

  def receive = {
    case Pong  ⇒ {
	if(count>999){
	      println(self.path + ": Received Pong! Last one")
	      sender ! Stop
	      var t1 = System.nanoTime()
	      println("Elapsed time: " + (t1-t0)/1000000 + "ms")
	      context.stop(self)	
	}else{
	      count+=1
	      println(self.path + ": Received Pong!"+count)
	      sender ! Ping
	}
    }
    case _  ⇒ ()
  }
}

object PingPong extends App {
  val system = ActorSystem()
  system.actorOf(Props[PongActor], name="Pong")
  system.actorOf(Props[PingActor], name="Ping")
}

object PingPongPong extends App {
  val system = ActorSystem()
  system.actorOf(Props[PongActor], name="Pong1")
  system.actorOf(Props[PongActor], name="Pong2")
  system.actorOf(Props[PingActor], name="Ping")
}
object PingPongFast extends App {
  val system = ActorSystem()
  system.actorOf(Props[PongActor], name="Pong4")
  system.actorOf(Props[PongActor], name="Pong3")
  system.actorOf(Props[PongActor], name="Pong2")
  system.actorOf(Props[PongActor], name="Pong1")
  system.actorOf(Props[PingActor], name="Ping1")
}
