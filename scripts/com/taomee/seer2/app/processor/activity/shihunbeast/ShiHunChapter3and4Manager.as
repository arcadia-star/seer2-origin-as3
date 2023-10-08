package com.taomee.seer2.app.processor.activity.shihunbeast
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.spt.support.PillarInfo;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import org.taomee.utils.BitUtil;
   
   public class ShiHunChapter3and4Manager
   {
      
      private static const foreverLimit:Array = [205517,205519];
      
      private static var statuValue:int;
      
      private static const wildPetArr:Array = [613,721,736,642];
      
      private static const fightIDArr:Array = [1467,1468,1469,1470];
      
      private static const swapID:int = 3662;
      
      private static var _spawnedPet:SpawnedPet;
      
      private static var _equipMc:MovieClip;
      
      private static var _count:int;
      
      private static var _map:MapModel;
      
      private static var _npc199:Mobile;
      
      private static var _npc854:Mobile;
      
      private static const petIDArr:Array = [857,858,859,860];
      
      private static const fight4IDArr:Array = [1471,1472,1473,1474];
      
      private static var tm:Timer;
      
      private static var fourSpawArr:Array = new Array();
      
      private static var petPos:Array = [[380,500],[494,588],[700,588],[805,500]];
      
      private static var petName:Array = ["七星瓢","幻彩蝶","碎晶蜂","彩翼蜓"];
      
      private static var _npc2:Mobile;
      
      private static var _npc:Mobile;
       
      
      public function ShiHunChapter3and4Manager()
      {
         super();
      }
      
      public static function setMapModule(param1:MapModel) : void
      {
         _map = param1;
      }
      
      public static function init() : void
      {
         _npc199 = MobileManager.getMobile(199,MobileType.NPC);
         _npc199.visible = false;
         _npc854 = MobileManager.getMobile(854,MobileType.NPC);
         _npc854.visible = false;
         ActiveCountManager.requestActiveCountList(foreverLimit,function(param1:Parser_1142):void
         {
            var _loc2_:uint = 0;
            if(param1.infoVec[0] < 5)
            {
               if(QuestManager.isComplete(10251))
               {
                  if(SceneManager.prevSceneType == SceneType.ARENA)
                  {
                     if(fightIDArr.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
                     {
                        _loc2_ = FightManager.fightWinnerSide;
                        if(_loc2_ == FightSide.RIGHT)
                        {
                           generateWild();
                        }
                        else if(_loc2_ == FightSide.LEFT)
                        {
                           if(param1.infoVec[0] == 4)
                           {
                              SceneManager.changeScene(SceneType.LOBBY,70);
                           }
                           else
                           {
                              generateWild();
                           }
                           ModuleManager.showAppModule("ShiHunBeastPanel","3");
                        }
                     }
                  }
                  else
                  {
                     generateWild();
                  }
               }
            }
            else if(param1.infoVec[1] == 0)
            {
               chapterFourOperation();
            }
            else
            {
               _npc854.visible = true;
            }
         });
      }
      
      private static function generateWild() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("vipAnimation/chongluan"),LoadType.SWF,onResLoaded);
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         var info:ContentInfo = param1;
         var tmpMc:MovieClip = info.content as MovieClip;
         _equipMc = tmpMc["equipMc"];
         _equipMc.x = 1030;
         _equipMc.y = 440;
         _equipMc.gotoAndStop(1);
         _equipMc.buttonMode = true;
         _equipMc.addEventListener(MouseEvent.CLICK,onEquip);
         _map.content.addChild(_equipMc);
         ActiveCountManager.requestActiveCountList(foreverLimit,function(param1:Parser_1142):void
         {
            statuValue = param1.infoVec[0];
            if(statuValue < 4)
            {
               initSceneOperation();
            }
            else if(statuValue == 4)
            {
               shootOperation();
            }
         });
      }
      
      private static function initSceneOperation() : void
      {
         DayLimitManager.getDoCount(1598,function(param1:int):void
         {
            if(param1 == 0)
            {
               _spawnedPet = new SpawnedPet(wildPetArr[statuValue],fightIDArr[statuValue],100);
               MobileManager.addMobile(_spawnedPet,MobileType.SPAWNED_PET);
            }
         });
      }
      
      private static function shootOperation() : void
      {
         _count = 0;
         ShootController.addEventListener(ShootEvent.PLAY_END,onShoot);
      }
      
      private static function onEquip(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(statuValue < 4)
         {
            NpcDialog.show(324,"白雪公主",[[0,ActorManager.actorInfo.nick + "，唤醒蚀魂兽之前，先要把萨伦帝国的爪牙赶走！ "]],["(战胜萨伦的爪牙)"],[function():void
            {
            }]);
         }
         else if(statuValue == 4)
         {
            NpcDialog.show(324,"白雪公主",[[0,ActorManager.actorInfo.nick + "，眼前这就是蚀魂兽之卵。用头部射击打破它，唤醒蚀魂兽吧！ "]],["(使用头部射击打破蚀魂兽之卵)"],[function():void
            {
            }]);
         }
      }
      
      private static function onShoot(param1:ShootEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:PillarInfo = null;
         var _loc2_:ShootInfo = param1.info;
         var _loc3_:UserInfo = ActorManager.actorInfo;
         if(_loc2_.userID == _loc3_.id)
         {
            _loc4_ = false;
            if(_loc4_ = _equipMc.hitTestPoint(param1.info.endPos.x,param1.info.endPos.y,true))
            {
               ++_count;
               (_equipMc.bar as MovieClip).gotoAndStop(_count + 1);
               if(_count >= 5)
               {
                  _equipMc.gotoAndStop(2);
                  tm = new Timer(1000,1);
                  tm.start();
                  tm.addEventListener(TimerEvent.TIMER,onTimer);
               }
            }
         }
      }
      
      private static function onTimer(param1:Event) : void
      {
         var e:Event = param1;
         tm.removeEventListener(TimerEvent.TIMER,onTimer);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunThird_1"),function():void
         {
            SwapManager.swapItem(swapID,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               ShootController.removeEventListener(ShootEvent.PLAY_END,onShoot);
               SceneManager.changeScene(SceneType.LOBBY,70);
               ModuleManager.toggleModule(URLUtil.getAppModule("ShiHunBeastPanel"),"","3");
            });
         });
         _count = 0;
      }
      
      private static function chapterFourOperation() : void
      {
         DayLimitManager.getDoCount(1600,function(param1:int):void
         {
            var tmpNpc:Mobile = null;
            var count:int = param1;
            fourSpawArr = [];
            var i:int = 0;
            while(i < 4)
            {
               if(BitUtil.getBit(count,i) == 0)
               {
                  tmpNpc = new Mobile();
                  tmpNpc.setPostion(new Point(petPos[i][0],petPos[i][1]));
                  tmpNpc.label = petName[i];
                  tmpNpc.resourceUrl = URLUtil.getNpcSwf(petIDArr[i]);
                  tmpNpc.buttonMode = true;
                  tmpNpc.addEventListener(MouseEvent.CLICK,onFight);
                  MobileManager.addMobile(tmpNpc,MobileType.NPC);
                  fourSpawArr.push({
                     "obj":tmpNpc,
                     "idx":i
                  });
               }
               i++;
            }
            createShiHunNpc2();
            if(fourSpawArr.length == 0)
            {
               ActiveCountManager.requestActiveCountList([205519],function(param1:Parser_1142):void
               {
                  if(param1.infoVec[0] == 0)
                  {
                     removeShiHunNpc2();
                     initShiHunPet();
                  }
               });
            }
         });
      }
      
      private static function createShiHunNpc2() : void
      {
         _npc2 = new Mobile();
         _npc2.setPostion(new Point(602,460));
         _npc2.label = "蚀魂兽";
         _npc2.resourceUrl = URLUtil.getNpcSwf(861);
         _npc2.buttonMode = true;
         MobileManager.addMobile(_npc2,MobileType.NPC);
         _npc2.addEventListener(MouseEvent.CLICK,onDialogShow);
      }
      
      private static function onDialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(400,"小赛尔",[[0,"看来只有打败4只虫系小精灵才能够挑战蚀魂兽。 "]],["（挑战4只精灵）"],[function():void
         {
         }]);
      }
      
      private static function removeShiHunNpc2() : void
      {
         if(_npc2)
         {
            MobileManager.removeMobile(_npc2,MobileType.NPC);
         }
      }
      
      private static function onFight(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < fourSpawArr.length)
         {
            if(fourSpawArr[_loc2_].obj == param1.currentTarget)
            {
               FightManager.startFightWithWild(fight4IDArr[fourSpawArr[_loc2_].idx]);
            }
            _loc2_++;
         }
      }
      
      private static function initShiHunPet() : void
      {
         _npc199.visible = true;
         _npc = new Mobile();
         _npc.setPostion(new Point(602,460));
         _npc.label = "蚀魂兽";
         _npc.resourceUrl = URLUtil.getNpcSwf(854);
         _npc.buttonMode = true;
         MobileManager.addMobile(_npc,MobileType.NPC);
         _npc.addEventListener(MouseEvent.CLICK,onFightBoss);
      }
      
      private static function onFightBoss(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         DayLimitManager.getDoCount(1599,function(param1:int):void
         {
            var count:int = param1;
            var gameCount:int = 3 - count < 0 ? 0 : 3 - count;
            if(gameCount > 0)
            {
               AlertManager.showConfirm("你今天还剩下" + gameCount + "次挑战机会,是否进入挑战？",function():void
               {
                  FightManager.startFightWithWild(1475);
               });
            }
            else
            {
               AlertManager.showAlert("你已经用完今天的三次挑战机会，请明天再来继续挑战吧~");
            }
         });
      }
      
      public static function dispose() : void
      {
         if(_spawnedPet != null)
         {
            MobileManager.removeMobile(_spawnedPet,MobileType.SPAWNED_PET);
         }
         var _loc1_:int = 0;
         while(_loc1_ < fourSpawArr.length)
         {
            MobileManager.removeMobile(fourSpawArr[_loc1_].obj,MobileType.NPC);
            _loc1_++;
         }
         if(_npc != null)
         {
            MobileManager.removeMobile(_npc,MobileType.NPC);
         }
         if(_equipMc != null)
         {
            DisplayObjectUtil.removeFromParent(_equipMc);
            _equipMc = null;
         }
         removeShiHunNpc2();
      }
   }
}
