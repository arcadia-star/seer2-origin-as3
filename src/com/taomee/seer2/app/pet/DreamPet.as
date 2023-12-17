package com.taomee.seer2.app.pet
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.dream.DreamMapInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   
   public class DreamPet extends SpawnedPet
   {
       
      
      public var time:int;
      
      public var type:int;
      
      public var resourceId:int;
      
      public var positionIndex:int;
      
      private var _info:DreamMapInfo;
      
      private var _bossShadow:Sprite;
      
      private var _isBoss:Boolean;
      
      public function DreamPet(param1:int, param2:int, param3:int, param4:Boolean, param5:DreamMapInfo = null)
      {
         this.resourceId = param1;
         this.positionIndex = param2;
         this._isBoss = param4;
         if(param5)
         {
            this._info = param5;
         }
         super(param1,param2,param3);
      }
      
      override protected function setResource() : void
      {
         this.buttonMode = true;
         this.mouseChildren = false;
         this.resourceUrl = URLUtil.getPetSwf(_petInfo.resourceId);
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      override public function stopAction() : void
      {
         this.stand();
      }
      
      override protected function addShadow() : void
      {
         if(this._isBoss)
         {
            _shadow = UIManager.getSprite("UI_RarePetShadow");
            addChildAt(_shadow,0);
            this._bossShadow = UIManager.getSprite("UI_DreamBossShadow");
            addChildAt(this._bossShadow,0);
         }
      }
      
      override protected function showAnimation() : void
      {
         super.showAnimation();
      }
      
      override protected function startFight() : void
      {
         var _loc1_:int = 0;
         if(this._info)
         {
            _loc1_ = 0;
            while(_loc1_ < this._info.list.length)
            {
               if(this._info.list[_loc1_].isBoss == 0)
               {
                  if(this._info.list[_loc1_].totalPetCount != this._info.list[_loc1_].killPetCount)
                  {
                     AlertManager.showAlert("还没战胜那些小弟之前，我才不屑跟你打呢。");
                     return;
                  }
               }
               _loc1_++;
            }
         }
         Connection.addCommandListener(CommandSet.DREAM_FIGHT_PET_1560,this.on1560);
         Connection.send(CommandSet.DREAM_FIGHT_PET_1560,this.resourceId);
      }
      
      private function on1560(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DREAM_FIGHT_PET_1560,this.on1560);
         Connection.blockCommand(CommandSet.DREAM_CURR_MAP_INFO_1558);
         FightManager.startFightWithMiniBoss(this.positionIndex);
      }
      
      override protected function showLabel() : void
      {
         if(this._isBoss)
         {
            setLabelStyle(16711782,16777215);
            this.label = "【★】 " + "Lv" + _petInfo.level + " " + PetConfig.getPetDefinition(this.resourceId).name;
         }
         else
         {
            this.label = PetConfig.getPetDefinition(this.resourceId).name;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
