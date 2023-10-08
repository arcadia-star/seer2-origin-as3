package com.taomee.seer2.app.processor.quest.handler.story.quest63
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import org.taomee.utils.DisplayUtil;
   
   public class Game63
   {
       
      
      private var _mainMC:MovieClip;
      
      private var _smc:MovieClip;
      
      private var _mouseMC:MovieClip;
      
      private var _closeBtn:SimpleButton;
      
      private var _count:int;
      
      private var _function:Function;
      
      public function Game63(param1:MovieClip, param2:Function)
      {
         super();
         this._function = param2;
         this._mainMC = param1;
         LayerManager.topLayer.addChild(this._mainMC);
         this._closeBtn = this._mainMC["closeBtn"];
         this._smc = this._mainMC["smc"];
         this._mouseMC = this._mainMC["mouse"];
         this._mouseMC.mouseChildren = false;
         this._mouseMC.mouseEnabled = false;
         this._smc.gotoAndStop(1);
         this._smc.buttonMode = true;
         Mouse.hide();
         this._mouseMC.startDrag(true);
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.onClosePanelHandler);
         this._smc.addEventListener(MouseEvent.CLICK,this.onClickSmcHandler);
      }
      
      private function onClosePanelHandler(param1:MouseEvent) : void
      {
         this.dispose();
      }
      
      private function onClickSmcHandler(param1:MouseEvent) : void
      {
         ++this._count;
         this._smc.gotoAndStop(this._count + 1);
         if(this._count == 2)
         {
            this.dispose();
            if(this._function != null)
            {
               this._function();
               this._function = null;
            }
         }
      }
      
      private function dispose() : void
      {
         Mouse.show();
         this._mouseMC.stopDrag();
         DisplayUtil.removeForParent(this._mainMC);
      }
   }
}
