package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.ToolbarEvent;
   import com.taomee.seer2.app.controls.ToolbarEventDispatcher;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HomeInputFrameWidget extends Sprite implements IWidgetable
   {
      
      public static const HOME_INPUT:String = "HomeInput";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:SimpleButton;
      
      private var _page:MovieClip;
      
      private var _homeBag:SimpleButton;
      
      private var _plantBag:SimpleButton;
      
      private var _isShow:Boolean;
      
      public function HomeInputFrameWidget(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this.initMC();
         this.initEventListener();
      }
      
      private function initMC() : void
      {
         this._btn = this._mainUI["btn"];
         this._page = this._mainUI["page"];
         this._homeBag = this._page["homeBag"];
         this._plantBag = this._page["plantBag"];
         this._isShow = false;
         this.updateNonoPage();
         this.updateTooltip();
      }
      
      private function updateTooltip() : void
      {
         TooltipManager.addCommonTip(this._btn,"家园");
      }
      
      private function initEventListener() : void
      {
         this._btn.addEventListener(MouseEvent.ROLL_OVER,this.onNono);
         this._homeBag.addEventListener(MouseEvent.CLICK,this.onHome);
         this._plantBag.addEventListener(MouseEvent.CLICK,this.onPlant);
         ToolbarEventDispatcher.addEventListener(ToolbarEvent.PAGE_CHANGE,this.onChange);
         ToolbarEventDispatcher.addEventListener(ToolbarEvent.TOOLBAR_HIDE,this.onHide);
         this._mainUI.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         this.onHide(null);
      }
      
      private function onHide(param1:ToolbarEvent) : void
      {
         this._isShow = false;
         this.updateNonoPage();
      }
      
      private function onChange(param1:ToolbarEvent) : void
      {
         if(param1.typeStr != HOME_INPUT && param1.status)
         {
            this._isShow = false;
            this.updateNonoPage();
         }
      }
      
      private function updateNonoPage() : void
      {
         this._page.visible = this._isShow;
      }
      
      private function onNono(param1:MouseEvent) : void
      {
         this._isShow = !this._isShow;
         ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE,this._isShow,HOME_INPUT));
         this.updateNonoPage();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_309);
      }
      
      private function onHome(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_328);
         ActorManager.getActor().stand();
         SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
         SoundEffects.playSoundMouseClick();
      }
      
      private function onPlant(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.PLANT,ActorManager.actorInfo.id);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_327);
         SoundEffects.playSoundMouseClick();
      }
   }
}
