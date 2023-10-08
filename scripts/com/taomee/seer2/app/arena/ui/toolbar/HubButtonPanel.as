package com.taomee.seer2.app.arena.ui.toolbar
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.guide.info.GudieDirectionType;
   import com.taomee.seer2.app.guide.manager.GuideManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HubButtonPanel extends Sprite
   {
      
      public static const EVT_FIGHT:String = "fight";
      
      public static const EVT_ITEM:String = "item";
      
      public static const EVT_PET:String = "pet";
      
      public static const EVT_ESCAPE:String = "escape";
      
      public static const EVT_CATCH:String = "catch";
       
      
      private var _catchBtnLightRingEnabled:Boolean = false;
      
      private var _catchBtnLightRing:MovieClip;
      
      private var _fightEnabled:Boolean = true;
      
      private var _itemEnabled:Boolean = true;
      
      private var _petEnabled:Boolean = true;
      
      private var _escapeEnabled:Boolean = true;
      
      private var _catchEnabled:Boolean = true;
      
      private var _fightBtn:SimpleButton;
      
      private var _itemBtn:SimpleButton;
      
      private var _petBtn:SimpleButton;
      
      private var _escapeBtn:SimpleButton;
      
      private var _catchBtn:SimpleButton;
      
      private var _fightHighlight:Sprite;
      
      private var _itemHighlight:Sprite;
      
      private var _petHighlight:Sprite;
      
      private var _escapeHighlight:Sprite;
      
      private var _catchHightlight:Sprite;
      
      public function HubButtonPanel()
      {
         super();
         this.mouseEnabled = false;
         this._fightBtn = FightUIManager.getButton("UI_FightFight");
         this._fightHighlight = FightUIManager.getSprite("UI_FightHighFight");
         this._fightHighlight.x = this._fightBtn.x = 780;
         this._fightHighlight.y = this._fightBtn.y = 74;
         this._fightHighlight.mouseChildren = false;
         this._fightHighlight.mouseEnabled = false;
         addChild(this._fightBtn);
         this._itemBtn = FightUIManager.getButton("UI_FightItem");
         this._itemHighlight = FightUIManager.getSprite("UI_FightHighItem");
         this._itemHighlight.mouseChildren = false;
         this._itemHighlight.mouseEnabled = false;
         this._itemHighlight.x = this._itemBtn.x = 778;
         this._itemHighlight.y = this._itemBtn.y = 114;
         addChild(this._itemBtn);
         this._petBtn = FightUIManager.getButton("UI_FightPet");
         this._petHighlight = FightUIManager.getSprite("UI_FightHighPet");
         this._petHighlight.x = this._petBtn.x = 778;
         this._petHighlight.y = this._petBtn.y = 41;
         this._petHighlight.mouseChildren = false;
         this._petHighlight.mouseEnabled = false;
         addChild(this._petBtn);
         this._escapeBtn = FightUIManager.getButton("UI_FightEscape");
         this._escapeHighlight = FightUIManager.getSprite("UI_FightHighEscape");
         this._escapeHighlight.x = this._escapeBtn.x = 871;
         this._escapeHighlight.y = this._escapeBtn.y = 114;
         this._escapeHighlight.mouseChildren = false;
         this._escapeHighlight.mouseEnabled = false;
         addChild(this._escapeBtn);
         this._catchBtn = FightUIManager.getButton("UI_FightCatch");
         this._catchHightlight = FightUIManager.getSprite("UI_FightHighCatch");
         this._catchBtnLightRing = FightUIManager.getMovieClip("UI_FightCatchBtnLightRing");
         this._catchBtnLightRing.mouseChildren = false;
         this._catchBtnLightRing.mouseEnabled = false;
         this._catchBtnLightRing.x = this._catchHightlight.x = this._catchBtn.x = 871;
         this._catchBtnLightRing.y = this._catchHightlight.y = this._catchBtn.y = 41;
         addChild(this._catchBtn);
         this._fightBtn.addEventListener(MouseEvent.CLICK,this.onFightClick);
         this._itemBtn.addEventListener(MouseEvent.CLICK,this.onItemClick);
         this._petBtn.addEventListener(MouseEvent.CLICK,this.onPetClick);
         this._escapeBtn.addEventListener(MouseEvent.CLICK,this.onEscapeClick);
         this._catchBtn.addEventListener(MouseEvent.CLICK,this.onCatchClick);
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA)
         {
            this.addGudie();
         }
      }
      
      private function addGudie() : void
      {
         GuideManager.instance.addTarget(this._itemBtn,1);
         GuideManager.instance.addGuide2Target(this._itemBtn,0,1,new Point(777,527),true,true,GudieDirectionType.CONTENT);
         GuideManager.instance.addTarget(this._catchBtn,4);
         GuideManager.instance.addGuide2Target(this._catchBtn,0,4,new Point(870,453),true,true,GudieDirectionType.CONTENT);
      }
      
      private function onFightClick(param1:MouseEvent) : void
      {
         this.highlightBtn(this._fightBtn);
         param1.stopImmediatePropagation();
         dispatchEvent(new Event(EVT_FIGHT));
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         this.highlightBtn(this._itemBtn);
         dispatchEvent(new Event(EVT_ITEM));
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         this.highlightBtn(this._petBtn);
         param1.stopImmediatePropagation();
         dispatchEvent(new Event(EVT_PET));
      }
      
      private function onEscapeClick(param1:MouseEvent) : void
      {
         var confirmEscape:Function = null;
         var evt:MouseEvent = param1;
         confirmEscape = function():void
         {
            highlightBtn(_escapeBtn);
            dispatchEvent(new Event(EVT_ESCAPE));
         };
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA2 || SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA1)
         {
            return;
         }
         AlertManager.showConfirm("你确定要逃离这次战斗吗?",confirmEscape);
         evt.stopImmediatePropagation();
      }
      
      private function onCatchClick(param1:MouseEvent) : void
      {
         this.highlightBtn(this._catchBtn);
         this.removeCatchBtnLightRing();
         dispatchEvent(new Event(EVT_CATCH));
      }
      
      public function highlightFightBtn() : void
      {
         this.highlightBtn(this._fightBtn);
      }
      
      public function highlightItemBtn() : void
      {
         this.highlightBtn(this._itemBtn);
      }
      
      public function highlightPetBtn() : void
      {
         this.highlightBtn(this._petBtn);
      }
      
      public function highlightEscapeBtn() : void
      {
         this.highlightBtn(this._escapeBtn);
      }
      
      public function highlightCatchBtn() : void
      {
         this.highlightBtn(this._catchBtn);
      }
      
      public function highlightAll() : void
      {
         this.highlightFightBtn();
         this.highlightItemBtn();
         this.highlightPetBtn();
         this.highlightEscapeBtn();
         this.highlightCatchBtn();
      }
      
      private function highlightBtn(param1:SimpleButton) : void
      {
         this.unhighlightAll();
         param1.scaleX = param1.scaleY = 0;
         if(param1 == this._fightBtn)
         {
            this.addHightLight(this._fightHighlight);
         }
         else if(param1 == this._itemBtn)
         {
            this.addHightLight(this._itemHighlight);
         }
         else if(param1 == this._escapeBtn)
         {
            this.addHightLight(this._escapeHighlight);
         }
         else if(param1 == this._catchBtn)
         {
            this.addHightLight(this._catchHightlight);
         }
         else if(param1 == this._petBtn)
         {
            this.addHightLight(this._petHighlight);
         }
      }
      
      private function addHightLight(param1:Sprite) : void
      {
         addChild(param1);
      }
      
      public function unhighlightFightBtn() : void
      {
         if(this._fightEnabled == true)
         {
            this.unhighlightBtn(this._fightBtn);
         }
      }
      
      public function unhighlightItemBtn() : void
      {
         if(this._itemEnabled == true)
         {
            this.unhighlightBtn(this._itemBtn);
         }
      }
      
      public function unhighlightPetBtn() : void
      {
         if(this._petEnabled == true)
         {
            this.unhighlightBtn(this._petBtn);
         }
      }
      
      public function unhighlightEscapeBtn() : void
      {
         if(this._escapeEnabled == true)
         {
            this.unhighlightBtn(this._escapeBtn);
         }
      }
      
      public function unhighlightCatchBtn() : void
      {
         if(this._catchEnabled == true)
         {
            this.unhighlightBtn(this._catchBtn);
         }
      }
      
      public function unhighlightAll() : void
      {
         this.unhighlightFightBtn();
         this.unhighlightItemBtn();
         this.unhighlightPetBtn();
         this.unhighlightEscapeBtn();
         this.unhighlightCatchBtn();
      }
      
      private function unhighlightBtn(param1:SimpleButton) : void
      {
         if(param1 == this._fightBtn)
         {
            this.removeHighlight(this._fightHighlight);
         }
         else if(param1 == this._itemBtn)
         {
            this.removeHighlight(this._itemHighlight);
         }
         else if(param1 == this._escapeBtn)
         {
            this.removeHighlight(this._escapeHighlight);
         }
         else if(param1 == this._catchBtn)
         {
            this.removeHighlight(this._catchHightlight);
         }
         else if(param1 == this._petBtn)
         {
            this.removeHighlight(this._petHighlight);
         }
         param1.scaleX = param1.scaleY = 1;
      }
      
      private function removeHighlight(param1:Sprite) : void
      {
         if(contains(param1))
         {
            removeChild(param1);
         }
      }
      
      private function removeCatchBtnLightRing() : void
      {
         if(this._catchBtnLightRingEnabled == true)
         {
            this._catchBtnLightRingEnabled = false;
            DisplayObjectUtil.removeFromParent(this._catchBtnLightRing);
         }
      }
      
      private function toggleBtn(param1:SimpleButton, param2:Boolean) : void
      {
         if(param2 == true)
         {
            DisplayObjectUtil.recoverDisplayObject(param1);
            DisplayObjectUtil.enableButton(param1);
         }
         else
         {
            DisplayObjectUtil.darkenDisplayObject(param1);
            DisplayObjectUtil.disableButton(param1);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function set catchBtnLightRingEnabled(param1:Boolean) : void
      {
         this._catchBtnLightRingEnabled = param1;
         if(this._catchBtnLightRingEnabled == true)
         {
            addChild(this._catchBtnLightRing);
         }
      }
      
      public function get catchBtnLightRingEnabled() : Boolean
      {
         return this._catchBtnLightRingEnabled;
      }
      
      public function set fightEnabled(param1:Boolean) : void
      {
         if(this._fightEnabled == param1)
         {
            return;
         }
         this._fightEnabled = param1;
         this.toggleBtn(this._fightBtn,this._fightEnabled);
      }
      
      public function get fightEnabled() : Boolean
      {
         return this._fightEnabled;
      }
      
      public function set itemEnabled(param1:Boolean) : void
      {
         if(this._itemEnabled != param1)
         {
            this._itemEnabled = param1;
            this.toggleBtn(this._itemBtn,this._itemEnabled);
         }
      }
      
      public function get itemEnabled() : Boolean
      {
         return this._itemEnabled;
      }
      
      public function set catchEnabled(param1:Boolean) : void
      {
         if(this._catchEnabled != param1)
         {
            this._catchEnabled = param1;
            this.toggleBtn(this._catchBtn,this._catchEnabled);
         }
      }
      
      public function get catchEnabled() : Boolean
      {
         return this._catchEnabled;
      }
      
      public function set escapeEnabled(param1:Boolean) : void
      {
         if(this._escapeEnabled != param1)
         {
            this._escapeEnabled = param1;
            this.toggleBtn(this._escapeBtn,this._escapeEnabled);
         }
      }
      
      public function get escapeEnabled() : Boolean
      {
         return this._escapeEnabled;
      }
      
      public function set petEnabled(param1:Boolean) : void
      {
         if(this._petEnabled != param1)
         {
            this._petEnabled = param1;
            this.toggleBtn(this._petBtn,this._petEnabled);
         }
      }
      
      public function get petEnabled() : Boolean
      {
         return this._petEnabled;
      }
      
      public function active() : void
      {
         this.mouseEnabled = true;
         this.mouseChildren = true;
      }
      
      public function deactive() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
   }
}
