package com.taomee.seer2.app.processor.activity.fightCounter
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class FightBearProcess
   {
       
      
      private var _house:MovieClip;
      
      private var _counterMC:MovieClip;
      
      private var _resLib:ResourceLibrary;
      
      public function FightBearProcess(param1:MovieClip)
      {
         super();
         this._house = param1;
         this.init();
         this.getURL();
      }
      
      private function init() : void
      {
         this._house.buttonMode = true;
         this._house.mouseChildren = true;
         this._house.mouseEnabled = true;
         this._house.addEventListener(MouseEvent.CLICK,this.onClickHouseHandler);
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 243)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.winFirst();
            }
            else
            {
               this.noWinFirst();
            }
            return;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 244)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.winSecond();
            }
            else
            {
               this.noWinSecond();
            }
            return;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 245)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               return;
            }
            this.noWinThird();
            return;
         }
      }
      
      private function onClickHouseHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         DayLimitManager.getDoCount(565,function(param1:int):void
         {
            var _loc2_:int = 0;
            if(param1 == 0)
            {
               SwapManager.swapItem(855);
            }
            else
            {
               _loc2_ = TimeManager.getPrecisionServerTime() - param1;
               if(_loc2_ >= 320)
               {
                  Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,onRandomStatus);
                  Connection.send(CommandSet.RANDOM_EVENT_1140,35,0);
               }
               else
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("CounterTimePanel"),"正在倒计时...");
               }
            }
         });
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         var data:IDataInput;
         var index:uint;
         var id:uint;
         var evt:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         data = evt.message.getRawDataCopy();
         index = uint(data.readUnsignedInt());
         id = uint(data.readUnsignedInt());
         if(id == 0)
         {
            this._counterMC = this.getMovie("couonter1");
            SceneManager.active.mapModel.content.addChild(this._counterMC);
            this._house.buttonMode = false;
            this._house.mouseChildren = false;
            this._house.mouseEnabled = false;
            this._house.removeEventListener(MouseEvent.CLICK,this.onClickHouseHandler);
            MovieClipUtil.playMc(this._counterMC,1,this._counterMC.totalFrames,function():void
            {
               _counterMC.buttonMode = true;
               _counterMC.addEventListener(MouseEvent.CLICK,onFightHandler);
            });
         }
         else if(id == 1)
         {
            if(SceneManager.active.mapID == 10109)
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("AbaoTravel/full0"),function():void
               {
                  NpcDialog.show(178,"康特",[[3,"谁呀！谁也别想阻止我睡觉！谁也别想！"]],["呜呜！运气真不好！"],[function():void
                  {
                     SwapManager.swapItem(855);
                  }]);
               },true,false,2);
            }
            else if(SceneManager.active.mapID == 101090)
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("AbaoTravel/full00"),function():void
               {
                  NpcDialog.show(178,"康特",[[3,"谁呀！谁也别想阻止我睡觉！谁也别想！"]],["呜呜！运气真不好！"],[function():void
                  {
                     SwapManager.swapItem(855);
                  }]);
               },true,false,2);
            }
         }
         else if(id == 2)
         {
            if(SceneManager.active.mapID == 10109)
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("AbaoTravel/full1"),function():void
               {
                  _house.buttonMode = false;
                  _house.mouseChildren = false;
                  _house.mouseEnabled = false;
                  _house.removeEventListener(MouseEvent.CLICK,onClickHouseHandler);
                  _counterMC = getMovie("couonter");
                  SceneManager.active.mapModel.content.addChild(_counterMC);
                  _counterMC.buttonMode = true;
                  _counterMC.addEventListener(MouseEvent.CLICK,onFightCounterHandler);
               },true,false,2);
            }
            else if(SceneManager.active.mapID == 101090)
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("AbaoTravel/full10"),function():void
               {
                  _house.buttonMode = false;
                  _house.mouseChildren = false;
                  _house.mouseEnabled = false;
                  _house.removeEventListener(MouseEvent.CLICK,onClickHouseHandler);
                  _counterMC = getMovie("couonter");
                  SceneManager.active.mapModel.content.addChild(_counterMC);
                  _counterMC.buttonMode = true;
                  _counterMC.addEventListener(MouseEvent.CLICK,onFightCounterHandler);
               },true,false,2);
            }
         }
      }
      
      private function onFightHandler(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(243);
      }
      
      private function onFightCounterHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ItemManager.requestItemList(function():void
         {
            if(ItemManager.getItemByReferenceId(400264))
            {
               FightManager.startFightWithWild(244);
            }
            else
            {
               FightManager.startFightWithWild(245);
            }
         });
      }
      
      private function winFirst() : void
      {
         if(this._counterMC)
         {
            DisplayUtil.removeForParent(this._counterMC);
         }
         SwapManager.swapItem(855);
         NpcDialog.show(178,"康特",[[0,"好啦好啦！你厉害，这些都给你，我要睡觉去了"]],["哈哈"]);
      }
      
      private function noWinFirst() : void
      {
         if(this._counterMC)
         {
            DisplayUtil.removeForParent(this._counterMC);
         }
         SwapManager.swapItem(855);
         NpcDialog.show(178,"康特",[[0,"切。想战胜我？省省吧。"]],["呜呜"]);
      }
      
      private function winSecond() : void
      {
         if(this._counterMC)
         {
            DisplayUtil.removeForParent(this._counterMC);
         }
         SwapManager.swapItem(855);
         NpcDialog.show(178,"康特",[[0,"哈哈。你有繁星水晶球！你以后就跟我混吧！"]],["哦耶！"],[function():void
         {
            SwapManager.swapItem(862);
         }]);
      }
      
      private function noWinSecond() : void
      {
         if(this._counterMC)
         {
            DisplayUtil.removeForParent(this._counterMC);
         }
         SwapManager.swapItem(855);
         NpcDialog.show(178,"康特",[[0,"哈哈。繁星水晶球先借我玩啦！不过做你的伙伴的话，还是看缘分吧！"]],["呜呜"],[function():void
         {
            SwapManager.swapItem(862);
         }]);
      }
      
      private function noWinThird() : void
      {
         if(this._counterMC)
         {
            DisplayUtil.removeForParent(this._counterMC);
         }
         SwapManager.swapItem(855);
         NpcDialog.show(178,"康特",[[0,"想取走我的性命！没门！敌人！你们全都是敌人！！"]],["（下次一定要带着繁星水晶球来！）"]);
      }
      
      private function getURL() : void
      {
         var url:String = String(URLUtil.getActivityAnimation("AbaoTravel/fightCounter"));
         var resourceLoader:ResourceLibraryLoader = new ResourceLibraryLoader(url);
         resourceLoader.getLib(function(param1:ResourceLibrary):void
         {
            _resLib = param1;
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return this._resLib.getMovieClip(param1);
         }
         return null;
      }
      
      public function dispose() : void
      {
         if(this._counterMC)
         {
            DisplayUtil.removeForParent(this._counterMC);
         }
         this._house.removeEventListener(MouseEvent.CLICK,this.onClickHouseHandler);
      }
   }
}
