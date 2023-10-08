package com.taomee.seer2.app.processor.quest.handler.branch.quest10131
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class Game10131
   {
       
      
      private var _ui:MovieClip;
      
      private var _function:Function;
      
      private var _info:ContentInfo;
      
      private var _xiangMC:MovieClip;
      
      private var _bibiMC:MovieClip;
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _num:int;
      
      public function Game10131(param1:Function)
      {
         super();
         this._function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("xegg/game3"),LoadType.SWF,this.onResLoaded);
      }
      
      private function onResLoaded(param1:ContentInfo = null) : void
      {
         if(this._info == null)
         {
            this._info = param1;
         }
         LayerManager.focusOnTopLayer();
         this.initUI();
      }
      
      private function initUI() : void
      {
         this._ui = new (this._info.domain.getDefinition("DeleteDrawThing"))();
         LayerManager.topLayer.addChild(this._ui);
         this._xiangMC = this._ui["xiang"];
         this._bibiMC = this._ui["bibi"];
         this._mc1 = this._ui["mc1"];
         this._mc2 = this._ui["mc2"];
         this._mc3 = this._ui["mc3"];
         this._xiangMC.startDrag(true);
         this._xiangMC.addEventListener(Event.ENTER_FRAME,this.onIsHitHandler);
      }
      
      private function onIsHitHandler(param1:Event) : void
      {
         this._mc1.buttonMode = true;
         this._mc2.buttonMode = true;
         this._mc3.buttonMode = true;
         this._mc1.addEventListener(MouseEvent.CLICK,this.onClickMC1Handler);
         this._mc2.addEventListener(MouseEvent.CLICK,this.onClickMC2Handler);
         this._mc3.addEventListener(MouseEvent.CLICK,this.onClickMC3Handler);
      }
      
      private function onClickMC1Handler(param1:MouseEvent) : void
      {
         this._mc1.removeEventListener(MouseEvent.CLICK,this.onClickMC1Handler);
         this._mc1.buttonMode = false;
         this._mc1.mouseChildren = false;
         this._mc1.mouseEnabled = false;
         this._mc1.gotoAndPlay(2);
         this.countNum();
      }
      
      private function onClickMC2Handler(param1:MouseEvent) : void
      {
         this._mc2.removeEventListener(MouseEvent.CLICK,this.onClickMC2Handler);
         this._mc2.buttonMode = false;
         this._mc2.mouseChildren = false;
         this._mc2.mouseEnabled = false;
         this._mc2.gotoAndPlay(2);
         this.countNum();
      }
      
      private function onClickMC3Handler(param1:MouseEvent) : void
      {
         this._mc3.removeEventListener(MouseEvent.CLICK,this.onClickMC3Handler);
         this._mc3.buttonMode = false;
         this._mc3.mouseChildren = false;
         this._mc3.mouseEnabled = false;
         this._mc3.gotoAndPlay(2);
         this.countNum();
      }
      
      private function countNum() : void
      {
         ++this._num;
         if(this._num < 3)
         {
            this._bibiMC.gotoAndStop(this._num + 1);
         }
         else if(this._num >= 3)
         {
            setTimeout(this.dispose,2500);
         }
      }
      
      private function dispose() : void
      {
         DisplayUtil.removeForParent(this._ui);
         this._info = null;
         this._ui = null;
         if(this._function != null)
         {
            this._function();
            this._function = null;
         }
         LayerManager.resetOperation();
         this._xiangMC.removeEventListener(Event.ENTER_FRAME,this.onIsHitHandler);
      }
   }
}
