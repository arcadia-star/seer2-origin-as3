package com.taomee.seer2.app.dragonPanel
{
   import com.greensock.TweenMax;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class DragonDownItem extends Sprite
   {
       
      
      private var _type:uint;
      
      private var _mainMC:MovieClip;
      
      private var _libs:ResourceLibrary;
      
      private var _setTimeout:uint;
      
      private var _fun:Function;
      
      private var _tweenMax:TweenMax;
      
      public function DragonDownItem(param1:uint, param2:ResourceLibrary)
      {
         super();
         this._type = param1;
         this._libs = param2;
         this.initMC();
      }
      
      private function initMC() : void
      {
         this._mainMC = this.getMcFromLib("dragon" + this._type);
         addChild(this._mainMC);
         this._tweenMax = TweenMax.to(this,1.5,{"y":526});
      }
      
      public function hitTestO(param1:MovieClip, param2:int, param3:Function) : void
      {
         param1.addChild(this._mainMC);
         this._mainMC.x = 25;
         switch(param2)
         {
            case 0:
               this._mainMC.y = 0;
               break;
            case 1:
               this._mainMC.y = -23;
               break;
            case 2:
               this._mainMC.x = 29;
               this._mainMC.y = -7;
               break;
            case 3:
               this._mainMC.x = 28;
               this._mainMC.y = -13;
               break;
            case 4:
               this._mainMC.x = 30;
               this._mainMC.y = 9;
               break;
            case 5:
               this._mainMC.y = 10;
         }
         this._tweenMax.paused(true);
         this._setTimeout = setTimeout(this.timeOut,1100);
      }
      
      private function timeOut() : void
      {
         this.dispose();
         if(this._fun != null)
         {
            this._fun();
         }
      }
      
      public function dispose() : void
      {
         this._tweenMax.paused(true);
         DisplayUtil.removeForParent(this._mainMC);
         clearTimeout(this._setTimeout);
      }
      
      private function getMcFromLib(param1:String) : MovieClip
      {
         return this._libs.getMovieClip(param1) as MovieClip;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
   }
}
