package com.taomee.seer2.app.actor.attach
{
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ActorTrainerLevel extends Sprite
   {
       
      
      private var _mainMc:MovieClip;
      
      private var _firstMc:MovieClip;
      
      private var _secondMc:MovieClip;
      
      public function ActorTrainerLevel()
      {
         super();
         this._mainMc = UIManager.getMovieClip("UI_Trainer_Level");
         this._firstMc = this._mainMc["ten"];
         this._secondMc = this._mainMc["num"];
         addChild(this._mainMc);
      }
      
      public function setData(param1:int) : void
      {
         if(param1 >= 10)
         {
            this._firstMc.gotoAndStop(int(param1 / 10) + 1);
            this._secondMc.gotoAndStop(param1 % 10 + 1);
            this._mainMc.addChild(this._secondMc);
         }
         else
         {
            this._firstMc.gotoAndStop(param1 % 10 + 1);
            DisplayObjectUtil.removeFromParent(this._secondMc);
         }
         this.cacheAsBitmap = true;
      }
   }
}
