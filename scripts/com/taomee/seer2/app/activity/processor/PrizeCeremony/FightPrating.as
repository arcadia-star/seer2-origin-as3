package com.taomee.seer2.app.activity.processor.PrizeCeremony
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   
   public class FightPrating
   {
       
      
      private var _isHas:Boolean;
      
      public function FightPrating()
      {
         super();
         this.initFight();
         this.initResult();
      }
      
      private function initFight() : void
      {
         var petInfo:PetInfo = null;
         for each(petInfo in PetInfoManager.getAllBagPetInfo())
         {
            if(petInfo.bunchId == 123)
            {
               this._isHas = true;
            }
            else
            {
               this._isHas = false;
            }
         }
         if(ItemManager.getSpecialItem(500508) == null && ItemManager.getSpecialItem(500509) == null && ItemManager.getSpecialItem(500510) == null)
         {
            AlertManager.showAlert("你没有参加过争霸赛，不能挑战帕拉丁哦。");
         }
         else
         {
            PetKingNumber.getNumber(function():void
            {
               switch(PetKingNumber.getTeam())
               {
                  case 1:
                     FirstFight();
                     break;
                  case 2:
                     SecondFight();
                     break;
                  case 3:
                     SecondFight();
               }
            });
         }
      }
      
      private function FirstFight() : void
      {
         NpcDialog.show(505,"光系精灵帕拉丁同学",[[0,"圣战赋予我们光芒和荣耀！你不需要和我挑战，因为你——勇敢的小赛尔已经拥有我了！"]],["争霸赛冠军就可以得到帕拉丁！（点击颁奖台去领奖）"],[]);
      }
      
      private function SecondFight() : void
      {
         if(this._isHas)
         {
            NpcDialog.show(505,"光系精灵帕拉丁同学",[[0,"圣战赋予我们光芒和荣耀！你不需要和我挑战，因为你——勇敢的小赛尔已经拥有我了！"]],["太好了！"],[]);
         }
         else
         {
            NpcDialog.show(505,"光系精灵帕拉丁同学",[[0,"圣战赋予我们光芒和荣耀！小赛尔，你已经经历过争霸赛的洗礼，每天的14:30-15:00，我接受你的挑战！ 挑战5次，你就有可能捕捉到我！"]],["好！那就开始吧！","我要准备一下先"],[function():void
            {
               if(Boolean(DateUtil.inInDateScope(5,14,30,15,1)) || Boolean(DateUtil.inInDateScope(6,14,30,15,1)) || Boolean(DateUtil.inInDateScope(0,14,30,15,1)) || Boolean(DateUtil.inInDateScope(1,14,30,15,1)) || Boolean(DateUtil.inInDateScope(2,14,30,15,1)) || Boolean(DateUtil.inInDateScope(3,14,30,15,1)) || Boolean(DateUtil.inInDateScope(4,14,30,15,1)))
               {
                  FightManager.startFightWithWild(142);
                  StatisticsManager.sendNovice(StatisticsManager.ui_interact_89);
               }
               else
               {
                  NpcDialog.show(505,"光系精灵帕拉丁同学",[[0,"圣战赋予我们光芒和荣耀！小赛尔，记住只有午后光芒之冠照耀我之时，也就是每天的14:30-15:00，才能挑战我！"]],["知道了"],[]);
               }
            }]);
         }
      }
      
      private function initResult() : void
      {
         var btnData:ButtonPanelData = null;
         btnData = new ButtonPanelData();
         btnData.catchEnabled = false;
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == 980)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 142 && FightManager.fightWinnerSide != FightSide.LEFT)
            {
               NpcDialog.show(505,"光系精灵帕拉丁同学",[[1,"没有人能够打破圣光的屏障，就连你也一样。"]],["继续挑战！","哎……那我还是走了"],[function():void
               {
                  FightManager.startFightWithWild(142,null,null,btnData);
               }]);
            }
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
