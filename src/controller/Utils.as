package controller 
{
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.Timer;

public class Utils {
    public function Utils() {
    }

    static public function fadeInOut(obj:TextField, isFadeIn:Boolean):void {
        var timer:Timer;
        timer = new Timer(200);
        timer.addEventListener(TimerEvent.TIMER, TimerTask);
        //timer.addEventListener(TimerEvent.TIMER_COMPLETE, TimerCompleteTask);
        timer.start();

        function TimerTask(e:TimerEvent):void {
            if (obj.alpha < 0.9 && isFadeIn) {
                obj.alpha += 0.15;
            }
            if (obj.alpha > 0 && !isFadeIn) {
                obj.alpha -= 0.1;
				if (obj.alpha == 0) {
					 timer.stop();
				}
            }
        }

        function TimerCompleteTask(e:TimerEvent):void {
           
        }
    }
}
}