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
   
   public class MapProcessor_80433 extends FeiyuyiteMap
   {
      
      private static const NpcIds:Vector.<int> = Vector.<int>([98,99]);
      
      private static const FightIds:Vector.<int> = Vector.<int>([1816,1817]);
      
      private static const Positions:Vector.<Point> = Vector.<Point>([new Point(553,433),new Point(690,382)]);
       
      
      private var _petBagBtn:SimpleButton;
      
      private var _reBloodBtn:SimpleButton;
      
      private var _mobiles:Vector.<Mobile>;
      
      public function MapProcessor_80433(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._petBagBtn = _map.front["petBagBtn"];
         this._reBloodBtn = _map.front["reBloodBtn"];
         this.hideLobbyMenu();
         this._mobiles = new Vector.<Mobile>();
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            this._mobiles.push(new Mobile());
            this._mobiles[_loc1_].resourceUrl = URLUtil.getNpcSwf(NpcIds[_loc1_]);
            this._mobiles[_loc1_].buttonMode = true;
            this._mobiles[_loc1_].addEventListener(MouseEvent.CLICK,this.toFight);
            this._mobiles[_loc1_].setPostion(Positions[_loc1_]);
            this._mobiles[_loc1_].height = 100;
            MobileManager.addMobile(this._mobiles[_loc1_],MobileType.NPC);
            _loc1_++;
         }
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
         NpcDialog.show(476,"飞伊特",[[0,"哟！哥哥弟弟们~我回来辣"]],[" ......"],[function():void
         {
            NpcDialog.show(98,"沙伊特",[[0,"你是……小飞妹妹？斯坦因那个家伙也对你做了改造？真是惨无人道……"]],["......"],[function():void
            {
               NpcDialog.show(473,"虫伊特",[[0,"看起来好像没什么呀，姐姐好像只是多出来一对大翅膀。话说好久不见，姐姐去哪儿里了呀？"]],["......"],[function():void
               {
                  NpcDialog.show(476,"飞伊特",[[0,"没什么呀……博士派我驻守他的研究院，博士人心地很好的，而且我还等来了温柔的铁皮姐姐陪我玩，出来之后很高兴就立刻来找你们了"]],["......"],[function():void
                  {
                     NpcDialog.show(98,"沙伊特",[[0,"真的不疼吗……【摸摸翅膀】"]],["......"],[function():void
                     {
                        NpcDialog.show(473,"虫伊特",[[0,"姐姐好厉害，变得英姿飒爽了，来和我们战斗吧~姐姐不在我们身边，我们两个好寂寞呜呜，其他兄弟们也不是和我们一胎的有点生疏，哭哭"]],["......"],[function():void
                        {
                           NpcDialog.show(476,"飞伊特",[[3,"小虫虫别哭啦，人家已经完成任务了，以后一直在你身边，来战斗，一起研磨三角阵吧"]],["我不想挨打……","进入挑战"],[null,function():void
                           {
                              FightManager.startFightWithWild(1837);
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
