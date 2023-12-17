package com.taomee.seer2.app.gameRule.nono.behavior
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.gameRule.nono.core.INonoBehavior;
   import com.taomee.seer2.app.gameRule.nono.core.NonoInfo;
   import com.taomee.seer2.app.gameRule.nono.time.NonoButlerController;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import com.taomee.seer2.core.utils.effect.EffectShake;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TimerPanel implements INonoBehavior
   {
       
      
      private var _nonoInfo:NonoInfo;
      
      private var _iconButton:SimpleButton;
      
      public function TimerPanel(param1:NonoInfo)
      {
         super();
         this._nonoInfo = param1;
      }
      
      public function get tipDescription() : String
      {
         return "时间管家";
      }
      
      public function set iconButton(param1:SimpleButton) : void
      {
         if(this._iconButton)
         {
            this._iconButton.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         this._iconButton = param1;
         this._iconButton.addEventListener(MouseEvent.CLICK,this.onClick);
         TooltipManager.addCommonTip(this._iconButton,this.tipDescription);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.clickHandler();
      }
      
      public function get iconButton() : SimpleButton
      {
         return this._iconButton;
      }
      
      public function clickHandler() : void
      {
         if(this._nonoInfo == ActorManager.actorInfo.getNonoInfo())
         {
            ActorManager.getActor().getNono().hideClock();
            EffectShake.deleteShake(this._iconButton);
            ModuleManager.toggleModule(URLUtil.getAppModule("NonoButlerPanel"),"正在打开nono管家面板...",NonoButlerController.getInstance().getData());
         }
      }
      
      public function dispose() : void
      {
         if(this._iconButton)
         {
            this._iconButton.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         this._iconButton = null;
      }
      
      public function get nonoX() : Number
      {
         return 41;
      }
      
      public function get nonoY() : Number
      {
         return -68;
      }
   }
}
