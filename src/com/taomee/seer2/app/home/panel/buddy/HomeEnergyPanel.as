package com.taomee.seer2.app.home.panel.buddy
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class HomeEnergyPanel extends Sprite
   {
      
      private static const ENERGY_MAX:int = 80;
      
      private static const ENERGY_PER_COUNT:int = 4;
       
      
      private var _container:MovieClip;
      
      private var _energyTxt:TextField;
      
      private var _energyMc:MovieClip;
      
      private var _energyNum:int;
      
      public function HomeEnergyPanel()
      {
         super();
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this.adjustPosition();
         this.createContainer();
         DisplayObjectUtil.disableSprite(this);
      }
      
      public function adjustPosition() : void
      {
         this.x = 25;
         this.y = LayerManager.stage.stageHeight - 135;
      }
      
      private function createContainer() : void
      {
         this._container = UIManager.getMovieClip("UI_HomeEnergyPanel");
         addChild(this._container);
         this._energyTxt = this._container["energyTxt"];
         this._energyMc = this._container["energyMc"];
         this._energyMc.gotoAndStop(1);
      }
      
      public function setData(param1:int) : void
      {
         this._energyNum = param1 * ENERGY_PER_COUNT;
         this.updateDisplay();
      }
      
      private function updateDisplay() : void
      {
         var _loc1_:int = int((ENERGY_MAX - this._energyNum) / 10);
         this._energyMc.gotoAndStop(_loc1_ + 1);
         this._energyTxt.text = this._energyNum + "/" + ENERGY_MAX;
      }
   }
}
