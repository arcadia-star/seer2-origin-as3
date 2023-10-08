package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.utils.FightHelpUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_80541 extends FeiyuyiteMap
   {
      
      private static const NpcIds:Vector.<int> = Vector.<int>([894]);
      
      private static const FightIds:Vector.<int> = Vector.<int>([1816,1817]);
      
      private static const Positions:Vector.<Point> = Vector.<Point>([new Point(458,279)]);
       
      
      private var _petBagBtn:SimpleButton;
      
      private var _reBloodBtn:SimpleButton;
      
      private var _mobiles:Vector.<Mobile>;
      
      public function MapProcessor_80541(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.hideLobbyMenu();
         this._mobiles = new Vector.<Mobile>();
         this._mobiles.push(new Mobile());
         this._mobiles[0].resourceUrl = URLUtil.getNpcSwf(NpcIds[0]);
         this._mobiles[0].buttonMode = true;
         this._mobiles[0].addEventListener(MouseEvent.CLICK,this.toFight);
         this._mobiles[0].setPostion(Positions[0]);
         this._mobiles[0].height = 100;
         MobileManager.addMobile(this._mobiles[0],MobileType.NPC);
         new FightHelpUtil(this._petBagBtn,this._reBloodBtn);
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
      }
      
      private function onCompleteMap(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapID == 70)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onCompleteMap);
         }
      }
      
      override protected function toFight(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(476,"飞伊特",[[0,"咪=w=……这是什么地方？好高的天空，广阔极了，好想飞飞飞！"]],["……"],[function():void
         {
            NpcDialog.show(894,"翼灵神",[[0,"你来了……诞生于人工的飞行系精灵……"]],["……"],[function():void
            {
               NpcDialog.show(476,"飞伊特",[[0,"哇……这个气息……翼灵神！"]],["……"],[function():void
               {
                  NpcDialog.show(894,"翼灵神",[[0,"你好……虽然初次见面，吾辈有些问题想问你……"]],["……"],[function():void
                  {
                     NpcDialog.show(476,"飞伊特",[[0,"我会如实回答的"]],["……"],[function():void
                     {
                        NpcDialog.show(894,"翼灵神",[[0,"作为一只人工诞生精灵，你们本身是不应该出现在这个世界上的。对于你来说，诞生在这个星球，与各种各样的人和精灵相遇是好事还是坏事呢？"]],["……"],[function():void
                        {
                           NpcDialog.show(476,"飞伊特",[[0,"唔……翼灵大人的话果然很深刻……我只是个小孩子也许说不太清楚……我来到这个世上，见到了博士，哥哥弟弟们，还有温柔的铁皮姐姐等等人，让我觉得这个星球是很美好的，留下的回忆，建立的羁绊，是对我的恩惠，我很感谢博士让我来到这个世界，也让我有自己的任务和存在地位，许多人都说博士是坏人，但我觉得博士的目的一定是好的。"]],["......"],[function():void
                           {
                              NpcDialog.show(894,"翼灵神",[[0,"诚然如此，无论是赛尔们，亦或是斯坦因等等立场的存在，都是有自己的原因的，那，接下来，你有何打算呢"]],["……"],[function():void
                              {
                                 NpcDialog.show(476,"飞伊特",[[0,"我……听说这星球即将面临危机，我不想让我们的故乡就这样消失，我想去成为赛尔们的助力，也给他们留下一个博士的好印象！"]],["……"],[function():void
                                 {
                                    NpcDialog.show(894,"翼灵神",[[3,"你，不……你们的家族必会成为度过这危机的重要力量的。来和我交战吧，让飞翼的精神永远寄托在你心中"]],["我不想挨打……","进入挑战"],[null,function():void
                                    {
                                       FightManager.startFightWithWild(1840);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function overHandler(param1:FightStartEvent) : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
         FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function isCanFight() : Boolean
      {
         var _loc2_:PetInfo = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
         {
            if([19,20,21].indexOf(_loc2_.type) != -1)
            {
               _loc1_ = false;
               break;
            }
         }
         return _loc1_;
      }
      
      private function initFight() : void
      {
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      override public function dispose() : void
      {
      }
   }
}
