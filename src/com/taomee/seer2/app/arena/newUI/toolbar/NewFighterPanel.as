package com.taomee.seer2.app.arena.newUI.toolbar
{
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.data.FighterInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.events.OperateEvent;
   import com.taomee.seer2.app.arena.newUI.toolbar.sub.NewFighterDisplay;
   import com.taomee.seer2.app.arena.ui.toolbar.sub.FighterTip;
   import com.taomee.seer2.app.arena.util.FightPostion;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewFighterPanel extends Sprite
   {
      
      private static const MAX_NUM_FINGHTER:int = 6;
       
      
      private var _fighterTeam:FighterTeam;
      
      private var _fighterDisplayVec:Vector.<NewFighterDisplay>;
      
      private var _tip:FighterTip;
      
      private var _itemId:uint = 0;
      
      public function NewFighterPanel()
      {
         var offsetX:int;
         var offsetY:int;
         var itemWidth:int;
         var i:int;
         var onMouseOver:Function = null;
         var onMouseOut:Function = null;
         var fighterDisplay:NewFighterDisplay = null;
         onMouseOver = function(param1:MouseEvent):void
         {
            var _loc2_:NewFighterDisplay = null;
            var _loc3_:FighterInfo = null;
            _loc2_ = param1.currentTarget as NewFighterDisplay;
            _loc3_ = _loc2_.getFighter().fighterInfo;
            _tip.x = _loc2_.x + 15;
            _tip.y = _loc2_.y;
            _tip.setFighterInfo(_loc3_);
            _loc2_.scaleX = 1.3;
            _loc2_.scaleY = 1.3;
            addChild(_tip);
         };
         onMouseOut = function(param1:MouseEvent):void
         {
            var _loc2_:NewFighterDisplay = param1.target as NewFighterDisplay;
            if(Boolean(_tip) && contains(_tip))
            {
               removeChild(_tip);
            }
            _loc2_.scaleX = 1;
            _loc2_.scaleY = 1;
         };
         super();
         this.mouseEnabled = false;
         offsetX = 102;
         offsetY = 40;
         itemWidth = 116;
         this._fighterDisplayVec = new Vector.<NewFighterDisplay>();
         i = 0;
         while(i < MAX_NUM_FINGHTER)
         {
            fighterDisplay = new NewFighterDisplay();
            fighterDisplay.x = offsetX + itemWidth * i;
            fighterDisplay.y = offsetY;
            fighterDisplay.addEventListener(MouseEvent.CLICK,this.onMouseClick);
            fighterDisplay.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
            fighterDisplay.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
            this._fighterDisplayVec.push(fighterDisplay);
            addChild(fighterDisplay);
            i++;
         }
         this._tip = new FighterTip();
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc5_:OperateEvent = null;
         SoundEffects.playFightSound("Sound_SwitchPet",0.35);
         var _loc2_:NewFighterDisplay = param1.currentTarget as NewFighterDisplay;
         var _loc3_:FighterInfo = _loc2_.getFighter().fighterInfo;
         if(_loc3_.position != FightPostion.INACTIVE)
         {
            return;
         }
         var _loc4_:uint = _loc3_.catchTime;
         if(this._itemId == 0)
         {
            dispatchEvent(new OperateEvent(OperateEvent.OPERATE_FIGHTER,_loc4_,OperateEvent.OPERATE_END));
         }
         else if(_loc3_.hp <= 0)
         {
            (_loc5_ = new OperateEvent(OperateEvent.OPERATE_RESURRECTION,this._itemId,OperateEvent.OPERATE_END)).fighterId = _loc4_;
            dispatchEvent(_loc5_);
            this.updatePet(_loc3_);
            dispatchEvent(new OperateEvent(OperateEvent.OPERATE_RESURRECTION,_loc4_,OperateEvent.FIGHT_SELECT_SKILL));
         }
         else
         {
            ServerMessager.addMessage("这只精灵不需要复活");
         }
      }
      
      private function updatePet(param1:FighterInfo) : void
      {
         if(this._itemId == 200064 || this._itemId == 201021)
         {
            param1.changeHp(param1.maxHp);
         }
         else
         {
            param1.changeHp(uint(param1.maxHp / 2));
         }
         this._itemId = 0;
         ServerMessager.addMessage("成功的复活了" + param1.name);
      }
      
      public function setFighterTeam(param1:FighterTeam, param2:uint = 0) : void
      {
         var _loc7_:Fighter = null;
         this._itemId = param2;
         this._fighterTeam = param1;
         this.disposeFighterDisplay();
         var _loc3_:Vector.<Fighter> = this._fighterTeam.fighterVec;
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            if((_loc7_ = _loc3_[_loc6_]).isFit == false)
            {
               this._fighterDisplayVec[_loc5_].setFighter(_loc7_);
               if(this._itemId != 0)
               {
                  this._fighterDisplayVec[_loc5_].isCloseMouse(false);
               }
               _loc5_++;
            }
            _loc6_++;
         }
      }
      
      public function updatePetPress(param1:uint) : void
      {
         var _loc6_:Fighter = null;
         var _loc2_:Vector.<Fighter> = this._fighterTeam.fighterVec;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            if((_loc6_ = _loc2_[_loc5_]).isFit == false)
            {
               this._fighterDisplayVec[_loc4_].updatePressStatus(param1);
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      public function update() : void
      {
         var _loc1_:NewFighterDisplay = null;
         for each(_loc1_ in this._fighterDisplayVec)
         {
            _loc1_.update();
         }
      }
      
      private function disposeFighterDisplay() : void
      {
         var _loc1_:NewFighterDisplay = null;
         for each(_loc1_ in this._fighterDisplayVec)
         {
            _loc1_.clear();
         }
      }
      
      public function dispose() : void
      {
         this.disposeFighterDisplay();
         this._fighterTeam = null;
         this._fighterDisplayVec = null;
         this._tip = null;
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
