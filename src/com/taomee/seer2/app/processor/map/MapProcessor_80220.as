package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80220 extends MapProcessor
   {
      
      private static const FIGHT_NUM_DAY:int = 1227;
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1072,1073,1074,1075,1076]);
      
      private static const FIGHT_NUM_MI_BUY_FOR:int = 204389;
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([3,5]);
      
      private static const RANDOM_ID:int = 82;
      
      private static var _isFirst:Boolean;
       
      
      private var _sceneMC:MovieClip;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _water:MovieClip;
      
      public function MapProcessor_80220(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.aKaNaSiSuperProcessActInit();
      }
      
      private function aKaNaSiSuperProcessActInit() : void
      {
         this._sceneMC = _map.content["petsShow"] as MovieClip;
         this._water = _map.content["water"] as MovieClip;
         this._sceneMC.gotoAndStop(1);
         this._sceneMC.visible = false;
         this._water.visible = true;
         if(SceneManager.prevSceneType == SceneType.ARENA && FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
         {
            DayLimitManager.getDoCount(FIGHT_NUM_DAY,function(param1:int):void
            {
               var val:int = param1;
               ActiveCountManager.requestActiveCount(FIGHT_NUM_MI_BUY_FOR,function(param1:uint, param2:uint):void
               {
                  var canFightNum:int = 0;
                  var type:uint = param1;
                  var count:uint = param2;
                  if(type == FIGHT_NUM_MI_BUY_FOR)
                  {
                     if(VipManager.vipInfo.isVip())
                     {
                        if(val > FIGHT_NUM_RULE[1])
                        {
                           canFightNum = int(count);
                        }
                        else
                        {
                           canFightNum = FIGHT_NUM_RULE[1] - val + count;
                        }
                     }
                     else if(val > FIGHT_NUM_RULE[0])
                     {
                        canFightNum = int(count);
                     }
                     else
                     {
                        canFightNum = FIGHT_NUM_RULE[0] - val + count;
                     }
                     if(canFightNum > 0)
                     {
                        fightHandle();
                     }
                     else
                     {
                        AlertManager.showConfirm("今日免费挑战次数已用完，可花费星钻继续战斗！",function():void
                        {
                           AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(603989) + "星钻增加挑战次数吗？",function():void
                           {
                              PayManager.buyItem(603989,function():void
                              {
                                 _water.buttonMode = true;
                                 _water.addEventListener(MouseEvent.CLICK,onWaterClick);
                              });
                           },cancelThis);
                        },cancelThis);
                     }
                  }
               });
            });
         }
         else
         {
            this.fightHandle();
         }
      }
      
      private function cancelThis() : void
      {
         ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function fightHandle() : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         if(!_isFirst)
         {
            _isFirst = true;
            this._sceneMC.visible = true;
            this._water.visible = false;
            MovieClipUtil.playMc(this._sceneMC,2,this._sceneMC.totalFrames,function():void
            {
               _sceneMC.gotoAndStop(1);
               _sceneMC.visible = false;
               showMouseHint();
               _water.visible = true;
               _water.buttonMode = true;
               _water.addEventListener(MouseEvent.CLICK,onWaterClick);
            });
         }
         else
         {
            this.showMouseHint();
            this._water.buttonMode = true;
            this._water.addEventListener(MouseEvent.CLICK,this.onWaterClick);
         }
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
         if(_loc2_.index == RANDOM_ID)
         {
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[_loc2_.id - 1]);
         }
      }
      
      private function onWaterClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = Math.random() * 4 + 1;
         FightManager.startFightWithWild(FIGHT_INDEX_LIST[_loc2_ - 1]);
      }
      
      private function showMouseHint() : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = 200;
         this._mouseHint.x = 510;
         _map.content.addChild(this._mouseHint);
         this._mouseHint.mouseEnabled = this._mouseHint.mouseChildren = false;
      }
      
      private function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = null;
      }
      
      private function aKaNaSiSuperProcessActDispose() : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         this._sceneMC = null;
         this.removeMouseHint();
         if(this._water)
         {
            this._water.removeEventListener(MouseEvent.CLICK,this.onWaterClick);
            this._water = null;
         }
      }
      
      override public function dispose() : void
      {
         this.aKaNaSiSuperProcessActDispose();
         super.dispose();
      }
   }
}
