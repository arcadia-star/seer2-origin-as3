package com.taomee.seer2.app.processor.activity.shihunbeast
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class ShiHunBeastManger
   {
       
      
      private var _map:MapModel;
      
      private var _fightID:int;
      
      private var _mc:MovieClip;
      
      private var headMc:Mobile;
      
      private var _whitchIndex:int;
      
      private var rangePos:Array;
      
      private var NPCID:Array;
      
      public function ShiHunBeastManger(param1:MapModel, param2:int, param3:int)
      {
         this.rangePos = [[322,441],[1000,580]];
         this.NPCID = [1034,1035,1036];
         super();
         this._map = param1;
         this._fightID = param2;
         this._whitchIndex = param3;
      }
      
      public function init() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         if(this._whitchIndex < 3)
         {
            this.headMc = new Mobile();
            this.headMc.setPostion(new Point((this.rangePos[1][0] - this.rangePos[0][0]) * Math.random() + this.rangePos[0][0],(this.rangePos[1][1] - this.rangePos[0][1]) * Math.random() + this.rangePos[0][1]));
            this.headMc.resourceUrl = URLUtil.getNpcSwf(this.NPCID[this._whitchIndex]);
            this.headMc.buttonMode = true;
            MobileManager.addMobile(this.headMc,MobileType.NPC);
            this.headMc.addEventListener(MouseEvent.CLICK,this.onHead);
         }
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this._fightID == FightManager.currentFightRecord.initData.positionIndex)
            {
               _loc2_ = FightManager.fightWinnerSide;
               if(_loc2_ != FightSide.RIGHT)
               {
                  if(_loc2_ == FightSide.LEFT)
                  {
                     _loc3_ = ItemManager.getSpecialItem(605393) != null ? int(ItemManager.getSpecialItem(605393).quantity) : 0;
                     if(_loc3_ >= 8)
                     {
                        ModuleManager.showAppModule("ShiHunBeastTips2Panel");
                     }
                  }
               }
            }
         }
         var _loc1_:int = ItemManager.getSpecialItem(605393) != null ? int(ItemManager.getSpecialItem(605393).quantity) : 0;
         if(_loc1_ >= 10)
         {
            ModuleManager.showAppModule("ShiHunBeastTips2Panel");
         }
      }
      
      private function onHead(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var num:int = ItemManager.getSpecialItem(605393) != null ? int(ItemManager.getSpecialItem(605393).quantity) : 0;
         if(num >= 10)
         {
            ModuleManager.showAppModule("ShiHunBeastTips2Panel");
         }
         else
         {
            SwapManager.swapItem(3653,1,function(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               new SwapInfo(data,false);
               ActiveCountManager.requestActiveCountList([205488],function(param1:Parser_1142):void
               {
                  var num:int = 0;
                  var num1:int = 0;
                  var par:Parser_1142 = param1;
                  if(par.infoVec[0] == 1)
                  {
                     FightManager.startFightWithWild(_fightID);
                  }
                  else if(par.infoVec[0] == 2)
                  {
                     ServerMessager.addMessage("从石像中掉下2个蚀之碎片。");
                     num = ItemManager.getSpecialItem(605393) != null ? int(ItemManager.getSpecialItem(605393).quantity) : 0;
                     if(num >= 10)
                     {
                        ModuleManager.showAppModule("ShiHunBeastTips2Panel");
                     }
                     dispose();
                     init();
                  }
                  else if(par.infoVec[0] == 3)
                  {
                     ServerMessager.addMessage("哈哈！蚀之珠掉了出来。");
                     num1 = ItemManager.getSpecialItem(605392) != null ? int(ItemManager.getSpecialItem(605392).quantity) : 0;
                     if(num1 >= 8)
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunSecond_2"),function():void
                        {
                           SwapManager.swapItem(3655,1,function(param1:IDataInput):void
                           {
                              new SwapInfo(param1);
                              QuestManager.completeStep(10250,6);
                              ModuleManager.toggleModule(URLUtil.getAppModule("ShiHunBeastPanel"),"","2");
                           });
                        });
                     }
                     dispose();
                     init();
                  }
               });
            });
         }
      }
      
      public function dispose() : void
      {
         if(this.headMc != null)
         {
            MobileManager.removeMobile(this.headMc,MobileType.NPC);
         }
      }
   }
}
