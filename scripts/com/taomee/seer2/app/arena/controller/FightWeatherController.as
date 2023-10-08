package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.arena.ui.status.FightWeatherDisplay;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Sprite;
   
   public class FightWeatherController
   {
       
      
      private var _scene:BaseScene;
      
      private var _fightMode:uint;
      
      private var _weather:uint;
      
      private var _weatherDisplay:FightWeatherDisplay;
      
      private var _par:Sprite;
      
      public function FightWeatherController(param1:uint, param2:BaseScene)
      {
         super();
         this._fightMode = param1;
         this._scene = param2;
      }
      
      public function addPar(param1:Sprite) : void
      {
         this._par = param1;
      }
      
      public function updateWeather(param1:uint) : void
      {
         if(param1 == 0)
         {
            return;
         }
         this._weather = param1;
         if(this._weatherDisplay == null)
         {
            this._weatherDisplay = new FightWeatherDisplay();
            this.adjustWeatherDisplayPosition();
            if(this._par)
            {
               this._par.addChild(this._weatherDisplay);
            }
         }
         this._weatherDisplay.update(param1);
      }
      
      public function dispose() : void
      {
         if(this._weatherDisplay != null)
         {
            DisplayObjectUtil.removeFromParent(this._weatherDisplay);
            this._weatherDisplay.dispose();
            this._weatherDisplay = null;
         }
      }
      
      private function adjustWeatherDisplayPosition() : void
      {
         if(this._fightMode == FightMode.FIGHT_BOSS)
         {
            this._weatherDisplay.x = 551;
            this._weatherDisplay.y = 40;
         }
         else
         {
            this._weatherDisplay.x = 551;
            this._weatherDisplay.y = 40;
         }
      }
   }
}
