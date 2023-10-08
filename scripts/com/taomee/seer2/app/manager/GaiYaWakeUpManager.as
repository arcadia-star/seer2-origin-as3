package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.extendEvent.EventWithString;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootGridPanel;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.Tick;
   
   public class GaiYaWakeUpManager
   {
      
      private static var _resMc0:MovieClip;
      
      private static var _resMc1:MovieClip;
      
      private static var _resMc2:MovieClip;
      
      private static var _resMc3:MovieClip;
      
      private static var _resMc4:MovieClip;
      
      private static var _resMc5:MovieClip;
      
      private static var _resMc6:MovieClip;
      
      private static var leftTime:int;
      
      private static var counter:int = 0;
      
      private static var cardNum:int;
      
      private static var NPC_id:int = 723;
      
      private static var npcArr:Array = new Array();
      
      private static var Fight_ID:int = 1608;
      
      private static var NPC_BOSS_id:int = 751;
      
      private static var Fight_BOSS_ID:int = 1609;
      
      private static var _par:Parser_1142;
      
      private static var _npcBoss:Mobile;
      
      private static var npcPos:Array = [[592,509],[423,496],[757,496],[331,454],[849,454],[860,375],[288,375],[415,288],[746,288],[659,418],[492,418],[594,364]];
       
      
      public function GaiYaWakeUpManager()
      {
         super();
      }
      
      public static function init() : void
      {
         CommonUseManager.hideLobbyMenu();
         ToolBar.show();
         QueueLoader.load(URLUtil.getActivityAnimation("gaiyawakeup/gaiyawakeupfirst"),LoadType.SWF,onResLoaded);
      }
      
      private static function fightBoss() : void
      {
         ActiveCountManager.requestActiveCountList([250315],function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            _par = par;
            DayLimitManager.getDoCount(5119,function(param1:int):void
            {
               if(param1 > 0)
               {
                  ModuleManager.showAppModule("GaiYaWakeupFirstStartPanel");
               }
               else
               {
                  _npcBoss = new Mobile();
                  _npcBoss.setPostion(new Point(591,371));
                  _npcBoss.label = "魔煞帝王";
                  _npcBoss.resourceUrl = URLUtil.getNpcSwf(NPC_BOSS_id);
                  _npcBoss.buttonMode = true;
                  MobileManager.addMobile(_npcBoss,MobileType.NPC);
                  _npcBoss.addEventListener(MouseEvent.CLICK,onFightBoss);
               }
            });
         });
      }
      
      private static function onFightBoss(param1:Event) : void
      {
         var e:Event = param1;
         NpcDialog.show(751,"魔煞帝王",[[0,"觉醒值就在我手上，赢了就白送给你！"]],["开始挑战","准备一下"],[function():void
         {
            FightManager.startFightWithWild(Fight_BOSS_ID);
         }]);
      }
      
      private static function onSure(param1:EventWithString) : void
      {
         var e:EventWithString = param1;
         DayLimitManager.getDoCount(5120,function(param1:int):void
         {
            var _loc2_:int = 0;
            cardNum = param1;
            disposeNPC();
            if(cardNum <= 0)
            {
               DisplayObjectUtil.removeFromParent(_resMc6);
               fightBoss();
            }
            else
            {
               DisplayObjectUtil.removeFromParent(_resMc5);
               LayerManager.mapLayer.addChild(_resMc6);
               _resMc6["boomBtn"].addEventListener(MouseEvent.CLICK,onBoom);
               _resMc6["itemShop"].addEventListener(MouseEvent.CLICK,onItemShop);
               _loc2_ = 0;
               while(_loc2_ < cardNum)
               {
                  createNPC(new Point(npcPos[_loc2_][0],npcPos[_loc2_][1]));
                  _loc2_++;
               }
            }
         });
      }
      
      private static function createNPC(param1:Point) : void
      {
         var _loc2_:Mobile = new Mobile();
         _loc2_.setPostion(param1);
         _loc2_.label = "武煞";
         _loc2_.resourceUrl = URLUtil.getNpcSwf(NPC_id);
         _loc2_.buttonMode = true;
         MobileManager.addMobile(_loc2_,MobileType.NPC);
         npcArr.push(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,onFightWild);
      }
      
      private static function onFightWild(param1:Event) : void
      {
         ModuleManager.showAppModule("GaiYaWakeupFightWildPanel");
      }
      
      private static function disposeNPC() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < npcArr.length)
         {
            MobileManager.removeMobile(npcArr[_loc1_],MobileType.NPC);
            npcArr[_loc1_] = null;
            _loc1_++;
         }
      }
      
      private static function onBoom(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("GaiYaWakeupCardBuyBoomPanel");
      }
      
      private static function onItemShop(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("MedicineShopPanel");
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         var info:ContentInfo = param1;
         var tmpMc:Sprite = info.content as Sprite;
         _resMc0 = tmpMc["resMc0"];
         _resMc1 = tmpMc["resMc1"];
         _resMc2 = tmpMc["resMc2"];
         _resMc3 = tmpMc["resMc3"];
         _resMc4 = tmpMc["resMc4"];
         _resMc5 = tmpMc["resMc5"];
         _resMc6 = tmpMc["resMc6"];
         EventManager.addEventListener("GAIYA_WAKEUP_SURE_EVENT",onSure);
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(Fight_ID == FightManager.currentFightRecord.initData.positionIndex)
            {
               onSure(null);
               return;
            }
            if(Fight_BOSS_ID == FightManager.currentFightRecord.initData.positionIndex)
            {
               if(FightManager.isWinWar())
               {
                  ActiveCountManager.requestActiveCountList([250315],function(param1:Parser_1142):void
                  {
                     ServerMessager.addMessage("获得" + (param1.infoVec[0] - _par.infoVec[0]) + "个觉醒值");
                     ModuleManager.showAppModule("GaiYaWakeupFirstStartPanel");
                  });
               }
               else
               {
                  fightBoss();
               }
               return;
            }
         }
         DayLimitListManager.getDaylimitList([5123,5120],function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            if(info.getCount(5123) > 0)
            {
               fightBoss();
            }
            else if(info.getCount(5120) > 0)
            {
               onSure(null);
            }
            else
            {
               LayerManager.mapLayer.addChild(_resMc0);
               _resMc0.gotoAndStop(1);
               MovieClipUtil.playMc(_resMc0,1,_resMc0.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_resMc0);
                  LayerManager.mapLayer.addChild(_resMc1);
                  _resMc1["barTxt"].text = "0/100";
                  _resMc1["barMc"].gotoAndStop(1);
                  leftTime = 60;
                  updateTimeTxt();
                  if(Tick.instance.hasRender(updateTime) == false)
                  {
                     Tick.instance.addRender(updateTime,1000);
                  }
                  counter = 0;
                  ShootController.addEventListener(ShootEvent.PLAY_END,onShoot);
               });
            }
         });
      }
      
      private static function onShoot(param1:ShootEvent) : void
      {
         var shoot:Boolean = false;
         var evt:ShootEvent = param1;
         var shootInfo:ShootInfo = evt.info;
         var actorInfo:UserInfo = ActorManager.actorInfo;
         if(shootInfo.userID == actorInfo.id)
         {
            shoot = false;
            shoot = Boolean(_resMc1["bodyMc"].hitTestPoint(evt.info.endPos.x,evt.info.endPos.y,true));
            if(shoot)
            {
               counter += 10;
               _resMc1["barTxt"].text = counter + "/100";
               _resMc1["barMc"].gotoAndStop(counter + 1);
               ShootController.removeEventListener(ShootEvent.PLAY_END,onShoot);
               MovieClip(_resMc1["bodyMc"]).gotoAndStop(1);
               MovieClipUtil.playMc(_resMc1["bodyMc"],2,MovieClip(_resMc1["bodyMc"]).totalFrames,function():void
               {
                  MovieClip(_resMc1["bodyMc"]).gotoAndStop(1);
                  ShootController.addEventListener(ShootEvent.PLAY_END,onShoot);
                  if(counter == 100)
                  {
                     counter = 0;
                     DisplayObjectUtil.removeFromParent(_resMc1);
                     if(ShootGridPanel.isShow)
                     {
                        ShootGridPanel.instance.hide();
                     }
                     LayerManager.mapLayer.addChild(_resMc2);
                     _resMc2.gotoAndStop(1);
                     MovieClipUtil.playMc(_resMc2,2,_resMc2.totalFrames,function():void
                     {
                        DisplayObjectUtil.removeFromParent(_resMc2);
                        LayerManager.mapLayer.addChild(_resMc3);
                        leftTime = 60;
                        updateTimeTxt1();
                        if(Tick.instance.hasRender(updateTime1) == false)
                        {
                           Tick.instance.addRender(updateTime1,1000);
                        }
                     });
                  }
               });
            }
         }
      }
      
      private static function updateTimeTxt() : void
      {
         --leftTime;
         _resMc1["timeMc"]["timeTxt"].text = DateUtil.getMS(leftTime);
      }
      
      private static function updateTime(param1:uint) : void
      {
         if(leftTime <= 0)
         {
            Tick.instance.removeRender(updateTime);
            counter = 0;
            DisplayObjectUtil.removeFromParent(_resMc1);
            ShootController.removeEventListener(ShootEvent.PLAY_END,onShoot);
            if(ShootGridPanel.isShow)
            {
               ShootGridPanel.instance.hide();
            }
         }
         else
         {
            updateTimeTxt();
         }
      }
      
      private static function updateTimeTxt1() : void
      {
         --leftTime;
         _resMc3["timeMc"]["timeTxt"].text = DateUtil.getMS(leftTime);
      }
      
      private static function updateTime1(param1:uint) : void
      {
         var u:uint = param1;
         if(leftTime <= 0)
         {
            Tick.instance.removeRender(updateTime1);
            DisplayObjectUtil.removeFromParent(_resMc3);
            LayerManager.mapLayer.addChild(_resMc4);
            _resMc4.gotoAndStop(1);
            MovieClipUtil.playMc(_resMc4,2,_resMc4.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(_resMc4);
               LayerManager.mapLayer.addChild(_resMc5);
               MovieClip(_resMc5["btn"]).buttonMode = true;
               _resMc5["btn"].addEventListener(MouseEvent.CLICK,onCard);
            });
         }
         else
         {
            updateTimeTxt1();
         }
      }
      
      private static function onCard(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("GaiYaWakeupCardPanel");
      }
      
      public static function dispose() : void
      {
         if(_resMc0)
         {
            DisplayObjectUtil.removeFromParent(_resMc0);
         }
         EventManager.removeEventListener("GAIYA_WAKEUP_SURE_EVENT",onSure);
         disposeNPC();
         if(_npcBoss)
         {
            MobileManager.removeMobile(_npcBoss,MobileType.NPC);
            _npcBoss = null;
         }
         if(_resMc5)
         {
            DisplayObjectUtil.removeFromParent(_resMc5);
         }
         if(_resMc6)
         {
            DisplayObjectUtil.removeFromParent(_resMc6);
         }
      }
   }
}
