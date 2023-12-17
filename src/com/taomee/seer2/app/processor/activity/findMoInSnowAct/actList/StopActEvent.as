package com.taomee.seer2.app.processor.activity.findMoInSnowAct.actList
{
   import com.taomee.seer2.app.utils.NumDisplayUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import org.taomee.utils.Tick;
   
   public class StopActEvent
   {
       
      
      private var timeMc:MovieClip;
      
      private var _stopTime:int;
      
      private var currentTime:int = 1;
      
      private var countDownSp:Sprite;
      
      private var _func:Function;
      
      public function StopActEvent(param1:int = 15, param2:Function = null)
      {
         super();
         this._stopTime = param1;
         this._func = param2;
         this.play_stopTime();
      }
      
      private function play_stopTime() : void
      {
         QueueLoader.load(URLUtil.getRes("map/dice/card/stopTime.swf"),LoadType.SWF,this.loadeComplete);
      }
      
      private function loadeComplete(param1:ContentInfo) : void
      {
         this.timeMc = param1.content["mc"] as MovieClip;
         SceneManager.active.mapModel.front.addChild(this.timeMc);
         Tick.instance.addRender(this.changTime,1000);
         this.countDownSp = NumDisplayUtil.getNumDisplay(this.currentTime,"UI_NumberCountDown",28);
         this.countDownSp.scaleX = this.countDownSp.scaleY = 1.5;
         this.countDownSp.x = 600 - this.countDownSp.width / 2;
         this.countDownSp.y = 330;
         LayerManager.topLayer.addChild(this.countDownSp);
         SoundManager.play(URLUtil.getRes("map/dice/sound/countDown.mp3"));
      }
      
      private function changTime(param1:int) : void
      {
         ++this.currentTime;
         if(this.currentTime <= this._stopTime)
         {
            SoundManager.play(URLUtil.getRes("map/dice/sound/countDown.mp3"));
         }
         else
         {
            SoundManager.play(URLUtil.getRes("map/dice/sound/zeroSound.mp3"));
         }
         if(this.countDownSp)
         {
            DisplayObjectUtil.removeFromParent(this.countDownSp);
         }
         this.countDownSp = NumDisplayUtil.getNumDisplay(this.currentTime,"UI_NumberCountDown",28);
         this.countDownSp.scaleX = this.countDownSp.scaleY = 1.5;
         this.countDownSp.x = 600 - this.countDownSp.width / 2;
         this.countDownSp.y = 330;
         LayerManager.topLayer.addChild(this.countDownSp);
         if(this.currentTime > this._stopTime)
         {
            DisplayObjectUtil.removeFromParent(this.countDownSp);
            DisplayObjectUtil.removeFromParent(this.timeMc);
            Tick.instance.removeRender(this.changTime);
            this.dispose();
         }
      }
      
      public function dispose() : void
      {
         if(this._func != null)
         {
            this._func();
            this._func = null;
         }
         DisplayObjectUtil.removeFromParent(this.countDownSp);
         DisplayObjectUtil.removeFromParent(this.timeMc);
         Tick.instance.removeRender(this.changTime);
      }
   }
}
