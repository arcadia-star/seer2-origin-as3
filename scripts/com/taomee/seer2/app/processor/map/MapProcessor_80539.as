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
   
   public class MapProcessor_80539 extends FeiyuyiteMap
   {
      
      private static const NpcIds:Vector.<int> = Vector.<int>([3114]);
      
      private static const FightIds:Vector.<int> = Vector.<int>([1816,1817]);
      
      private static const Positions:Vector.<Point> = Vector.<Point>([new Point(553,433)]);
       
      
      private var _petBagBtn:SimpleButton;
      
      private var _reBloodBtn:SimpleButton;
      
      private var _mobiles:Vector.<Mobile>;
      
      public function MapProcessor_80539(param1:MapModel)
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
         NpcDialog.show(476,"飞伊特",[[0,"这地方贼拉恐怖，真不知道大哥怎么一直住下来的"]],[" ......"],[function():void
         {
            NpcDialog.show(78,"战伊特",[[0,"什么人？哈哒，我打"]],["......"],[function():void
            {
               NpcDialog.show(476,"飞伊特",[[0,"嗷！好痛！战大哥，是我啦！小飞！下手也不轻点呜呜哭给你看哦"]],["......"],[function():void
               {
                  NpcDialog.show(78,"战伊特",[[0,"昂？小飞妹，你怎么也变大了？"]],["......"],[function():void
                  {
                     NpcDialog.show(476,"飞伊特",[[0,"什么鬼，人家是超进化了，之前暗哥和风弟弟都来见过你，忘啦？"]],["......"],[function():void
                     {
                        NpcDialog.show(78,"战伊特",[[0,"啧，斯坦因这家伙总这么干也不知是好事还是坏事"]],["......"],[function():void
                        {
                           NpcDialog.show(476,"飞伊特",[[0,"哥哥别担心，我身体没有什么异常，而且好像派上用场了，我很满意>w<要不要来打打看呀~"]],["......"],[function():void
                           {
                              NpcDialog.show(78,"战伊特",[[3,"你这小鬼，看我不好好调教你一下"]],["我不想挨打……","进入挑战"],[null,function():void
                              {
                                 FightManager.startFightWithWild(1838);
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
