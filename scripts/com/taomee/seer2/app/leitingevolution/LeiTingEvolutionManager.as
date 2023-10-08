package com.taomee.seer2.app.leitingevolution
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class LeiTingEvolutionManager
   {
      
      private static const DAY_LIST:Array = [1684,1685,1686,1687];
      
      private static const Fight_ID:Array = [1563,1564,1565,1566];
      
      private static var fightCountArr:Array = new Array();
      
      private static var _npc2:Mobile;
      
      private static var _npc195:Mobile;
      
      private static var _npc6:Mobile;
      
      private static var _npc153:Mobile;
       
      
      public function LeiTingEvolutionManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         var result:uint = 0;
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            fightCountArr = [];
            var _loc2_:int = 0;
            while(_loc2_ < 4)
            {
               fightCountArr.push(param1.getCount(DAY_LIST[_loc2_]));
               _loc2_++;
            }
            var _loc3_:int = getMinFromArr(fightCountArr);
            if(fightCountArr[0] - _loc3_ <= 0)
            {
               _npc2 = new Mobile();
               _npc2.setPostion(new Point(503,465));
               _npc2.resourceUrl = URLUtil.getNpcSwf(2);
               _npc2.buttonMode = true;
               _npc2.addEventListener(MouseEvent.CLICK,dialogShow0);
               MobileManager.addMobile(_npc2,MobileType.NPC);
            }
            if(fightCountArr[1] - _loc3_ <= 0)
            {
               _npc195 = new Mobile();
               _npc195.setPostion(new Point(652,425));
               _npc195.resourceUrl = URLUtil.getNpcSwf(195);
               _npc195.buttonMode = true;
               _npc195.addEventListener(MouseEvent.CLICK,dialogShow1);
               MobileManager.addMobile(_npc195,MobileType.NPC);
            }
            if(fightCountArr[2] - _loc3_ <= 0)
            {
               _npc6 = new Mobile();
               _npc6.setPostion(new Point(860,450));
               _npc6.resourceUrl = URLUtil.getNpcSwf(6);
               _npc6.buttonMode = true;
               _npc6.addEventListener(MouseEvent.CLICK,dialogShow2);
               MobileManager.addMobile(_npc6,MobileType.NPC);
            }
            if(fightCountArr[3] - _loc3_ <= 0)
            {
               _npc153 = new Mobile();
               _npc153.setPostion(new Point(976,467));
               _npc153.resourceUrl = URLUtil.getNpcSwf(1502);
               _npc153.buttonMode = true;
               _npc153.addEventListener(MouseEvent.CLICK,dialogShow3);
               MobileManager.addMobile(_npc153,MobileType.NPC);
            }
         });
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(Fight_ID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
            {
               result = FightManager.fightWinnerSide;
               if(result == FightSide.RIGHT)
               {
                  if(DateUtil.isInTime(new Date(2015,9,2),new Date(2015,9,2,23,59,59)))
                  {
                     ServerMessager.addMessage("成功获得3点赛尔的信赖.");
                  }
                  else
                  {
                     ServerMessager.addMessage("成功获得1点赛尔的信赖.");
                  }
               }
               else if(result == FightSide.LEFT)
               {
                  if(DateUtil.isInTime(new Date(2015,9,2),new Date(2015,9,2,23,59,59)))
                  {
                     ServerMessager.addMessage("成功获得9点赛尔的信赖.");
                  }
                  else
                  {
                     ServerMessager.addMessage("成功获得3点赛尔的信赖.");
                  }
               }
               DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
               {
                  fightCountArr = [];
                  var _loc2_:int = 0;
                  while(_loc2_ < 4)
                  {
                     fightCountArr.push(param1.getCount(DAY_LIST[_loc2_]));
                     _loc2_++;
                  }
                  var _loc3_:int = getMinFromArr(fightCountArr);
                  var _loc4_:int = 0;
                  _loc2_ = 0;
                  while(_loc2_ < 4)
                  {
                     if(_loc3_ == fightCountArr[_loc2_])
                     {
                        _loc4_++;
                     }
                     _loc2_++;
                  }
                  if(_loc4_ == 4)
                  {
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     ModuleManager.showAppModule("LeiTingEvolutionTrailPanel");
                  }
               });
            }
         }
      }
      
      private static function dialogShow0(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(2,"伊娃",[[0,"来吧，" + ActorManager.actorInfo.nick + " 让我见识一下你究竟有多大的进步。"]],["我准备好了！","我还需要准备一下"],[function():void
         {
            FightManager.startFightWithWild(Fight_ID[0]);
         }]);
      }
      
      private static function dialogShow1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(195,"雷文",[[0,"不断的战斗，才能变强。雷利斯将会向你证明这一点。"]],["放马过来吧！","我需要准备一下"],[function():void
         {
            FightManager.startFightWithWild(Fight_ID[1]);
         }]);
      }
      
      private static function dialogShow2(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(6,"克拉克",[[0,"伊鲁达会让你明白，什么才是真正的英雄。"]],["我想见识一下!","我还没准备好"],[function():void
         {
            FightManager.startFightWithWild(Fight_ID[2]);
         }]);
      }
      
      private static function dialogShow3(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(153,"贾斯丁",[[0,"战斗的技巧，你还需要不断的磨练，向我挑战吧！"]],["让我变得更强大吧！!","我需要准备一下"],[function():void
         {
            FightManager.startFightWithWild(Fight_ID[3]);
         }]);
      }
      
      private static function getMinFromArr(param1:Array) : int
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:int = 1;
         while(_loc3_ < param1.length)
         {
            if(_loc2_ > param1[_loc3_])
            {
               _loc2_ = int(param1[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function dispose() : void
      {
         if(_npc2)
         {
            MobileManager.removeMobile(_npc2,MobileType.NPC);
            _npc2 = null;
         }
         if(_npc195)
         {
            MobileManager.removeMobile(_npc195,MobileType.NPC);
            _npc195 = null;
         }
         if(_npc6)
         {
            MobileManager.removeMobile(_npc6,MobileType.NPC);
            _npc6 = null;
         }
         if(_npc153)
         {
            MobileManager.removeMobile(_npc153,MobileType.NPC);
            _npc153 = null;
         }
      }
   }
}
