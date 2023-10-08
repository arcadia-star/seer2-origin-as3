package com.taomee.seer2.app.gameRule.fish
{
   import com.taomee.seer2.app.gameRule.core.ISupportable;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class FishRule_790 implements ISupportable
   {
       
      
      private var _fishingPoint:MovieClip;
      
      public function FishRule_790()
      {
         this._fishingPoint = new MovieClip();
         super();
      }
      
      public function init(param1:MapModel) : void
      {
         this._fishingPoint = param1.content["fishingPP"];
         this._fishingPoint.buttonMode = true;
         this._fishingPoint.useHandCursor = true;
         TooltipManager.addCommonTip(this._fishingPoint,"微光湖畔垂钓点");
         this._fishingPoint.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("FishToolPanel"),"正在打开选择鱼竿鱼饵面板!",{"sceneStyle":4});
      }
      
      public function dispose() : void
      {
         TooltipManager.remove(this._fishingPoint);
         this._fishingPoint.removeEventListener(MouseEvent.CLICK,this.onClick);
         this._fishingPoint = null;
      }
   }
}
