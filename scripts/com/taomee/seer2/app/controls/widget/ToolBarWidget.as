package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.utils.Tick;
   
   public class ToolBarWidget extends Sprite
   {
       
      
      private var _btn:SimpleButton;
      
      private var _mc:MovieClip;
      
      public function ToolBarWidget(param1:SimpleButton, param2:MovieClip, param3:String, param4:IToolBarWidgetClick)
      {
         super();
         this.x = param1.x;
         this.y = param1.y;
         param1.x = param1.y = 0;
         this._btn = param1;
         this._btn.addEventListener(MouseEvent.CLICK,param4.onWidgetClick);
         addChild(this._btn);
         SoundEffects.setButton(this._btn);
         this._mc = param2;
         if(this._mc)
         {
            this._mc.x = this._mc.y = 0;
            this._mc.buttonMode = true;
            this._mc.addEventListener(MouseEvent.CLICK,param4.onWidgetClick);
            addChild(this._mc);
            SoundEffects.setButton(this._mc);
         }
         this.createCommonTip(param3);
         this.showNormal();
      }
      
      protected function createCommonTip(param1:String) : void
      {
         TooltipManager.addCommonTip(this,param1);
      }
      
      public function showNormal() : void
      {
         this._btn.visible = true;
         if(this._mc)
         {
            this._mc.visible = false;
         }
      }
      
      public function showNotice() : void
      {
         this._btn.visible = false;
         if(this._mc)
         {
            this._mc.visible = true;
            Tick.instance.addTimeout(10000,this.showNormal);
         }
      }
      
      public function alwaysShowNotice() : void
      {
         this._btn.visible = false;
         if(this._mc)
         {
            this._mc.visible = true;
         }
      }
   }
}
