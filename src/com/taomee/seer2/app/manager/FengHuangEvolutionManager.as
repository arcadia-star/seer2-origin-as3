package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.scene.LobbyPanel;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DomainUtil;
   
   public class FengHuangEvolutionManager
   {
      
      private static var _map:MapModel;
      
      private static var _resLib:ApplicationDomain;
      
      private static var stepMcList:Vector.<MovieClip>;
      
      private static var _petMc:MovieClip;
      
      private static var _mc1:MovieClip;
      
      private static var vipMc:MovieClip;
      
      private static var fightID:int = 1590;
      
      private static const DAY_LIST:Array = [5081,5084,5085];
      
      private static var gameCount:int;
      
      private static var buyCount:int;
      
      private static var numCount:int;
       
      
      public function FengHuangEvolutionManager()
      {
         super();
      }
      
      public static function init(param1:MapModel) : void
      {
         var map:MapModel = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("fenghuangevolutionAct/fenghuangevolutionAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            LobbyPanel.instance.hide();
            _map = map;
            stepMcList = new Vector.<MovieClip>();
            var _loc2_:int = 0;
            while(_loc2_ < 3)
            {
               stepMcList.push(_map.front["stepMc" + _loc2_]);
               stepMcList[_loc2_].gotoAndStop(1);
               _loc2_++;
            }
            _petMc = _map.front["petMc"];
            _petMc.buttonMode = true;
            _petMc.addEventListener(MouseEvent.CLICK,onNpcClick);
            vipMc = _map.front["vipMc"];
            if(VipManager.vipInfo.isVip())
            {
               vipMc.gotoAndStop(1);
            }
            else
            {
               vipMc.gotoAndStop(2);
               SimpleButton(vipMc["addVipBtn"]).addEventListener(MouseEvent.CLICK,onAddVip);
            }
            updateDate();
         });
      }
      
      private static function updateDate() : void
      {
         ActiveCountManager.requestActiveCountList([250206,250205],function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            numCount = par.infoVec[0];
            buyCount = par.infoVec[1];
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               if(VipManager.vipInfo.isVip())
               {
                  gameCount = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[0]),buyCount,2);
               }
               else
               {
                  gameCount = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[0]),buyCount,1);
               }
               if(SceneManager.prevSceneType == SceneType.ARENA)
               {
                  if(fightID == FightManager.currentFightRecord.initData.positionIndex)
                  {
                     if(FightManager.isWinWar())
                     {
                        successStep();
                     }
                     else
                     {
                        SceneManager.changeScene(SceneType.LOBBY,70);
                        ModuleManager.showAppModule("FengHuangEvolutionPartTwoFailedPanel");
                     }
                  }
               }
               else
               {
                  successStep();
               }
               var _loc2_:int = 0;
               while(_loc2_ < 3)
               {
                  if(_loc2_ < numCount)
                  {
                     stepMcList[_loc2_].gotoAndStop(2);
                  }
                  _loc2_++;
               }
            });
         });
      }
      
      private static function successStep() : void
      {
         if(numCount >= 3)
         {
            _mc1 = getMovie("Mc2") as MovieClip;
            _mc1.x += 421;
            _mc1.y += 221;
            _map.front.addChild(_mc1);
            _mc1.gotoAndStop(1);
            MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(_mc1);
               _mc1 = null;
               SceneManager.changeScene(SceneType.LOBBY,70);
               ModuleManager.showAppModule("FengHuangEvolutionMainPanel");
            });
         }
      }
      
      private static function onAddVip(param1:MouseEvent) : void
      {
         var _loc2_:String = "http://pay.61.com/seer2/seer2pay";
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
      
      private static function getMovie(param1:String) : DisplayObject
      {
         if(_resLib)
         {
            return DomainUtil.getDisplayObject(param1,_resLib);
         }
         return null;
      }
      
      private static function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ServerBufferManager.getServerBuffer(ServerBufferType.FENGHUANG_ANIMATION_1,function(param1:ServerBuffer):void
         {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
            if(!_isPlay)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.FENGHUANG_ANIMATION_1,1,1);
               _mc1 = getMovie("Mc1") as MovieClip;
               _mc1.x += 485;
               _mc1.y += 244;
               _map.front.addChild(_mc1);
               _mc1.gotoAndStop(1);
               MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_mc1);
                  _mc1 = null;
                  dialogShow();
               });
            }
            else
            {
               dialogShow();
            }
         });
      }
      
      private static function dialogShow() : void
      {
         NpcDialog.show(869,"火翼炎神",[[0,"火神节的众族之力让我充满力量，小赛尔，你可以从我这里获得浴火之源，但这火焰需要依靠你自己的力量来获得！"]],["开始挑战","准备下先"],[function():void
         {
            if(gameCount <= 0)
            {
               ShopManager.buyItemForId(605776,function(param1:*):void
               {
                  updateDate();
               });
            }
            else
            {
               FightManager.startFightWithWild(fightID);
            }
         }]);
      }
      
      public static function dispose() : void
      {
      }
   }
}
