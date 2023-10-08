package com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class GetMoneyRideHorseAct
   {
      
      private static const MAP_ID_LIST:Vector.<int> = Vector.<int>([122,204,302,340,360,550]);
      
      private static const DIR_LIST:Vector.<int> = Vector.<int>([1,0,1,0,0,0]);
      
      private static const NPC_NAME_LIST:Vector.<String> = Vector.<String>(["舒尔","哈瑞","玛里","兰德","蒂萨特","冰滚滚"]);
      
      private static const POS_NPC_LIST:Array = [[224,410],[640,222],[152,347],[650,340],[647,280],[650,370]];
      
      private static const POS_TARTET_LIST:Array = [[410,340],[410,340],[210,430],[380,400],[410,340],[410,425]];
      
      private static const NPC_ID_LIST:Vector.<int> = Vector.<int>([352,29,35,51,52,351]);
      
      private static const NPC_DIALOG_STR:Vector.<String> = Vector.<String>(["咦？地上有个东西你点开看看！我不敢点……","地上是什么？小赛尔你要不要点开看看。","妈玛！妈玛！地上有个怪物！","这个东东好奇怪的，你敢点吗？","兰德让你看的东西我也要让你看！就是地上那个","我觉得地上那个东西想让你看一看"]);
      
      private static const ANSWER_STR:Array = [["好啊，不过我是帮小木马给你送钱的啊！","这……"],["好啊，不过我是帮小木马给你送钱的啊！","又来了……"],["别叫你妈妈啦，我来帮你看好了  ","你们都是串通好的吧"],["敢敢敢，是广告啦！我知道的。","你们这些熊孩子"],["哎，除了看我还能怎么办啊","广告真的很讨厌"],["这样啊……那我就去看看呗","能换样东西吗"]];
      
      private static const NPC_DIALOG_STR_2:Vector.<String> = Vector.<String>(["你真好，下次请你吃饭哦。","你真好，下次给你变个魔术。","嘿嘿，我知道你会帮我点的。","我知道你有点小生气。","真够朋友！","我给你点赞！"]);
      
      private static const NPC_DAILOGE_LIST:Vector.<int> = Vector.<int>([20,29,35,51,52,351]);
      
      private static const NPC_DIALOGE_ID_LIST:Vector.<int> = Vector.<int>([3,4,3,0,0,0]);
      
      private static const GET_SWAP:int = 2340;
      
      private static const EQUIP_ID:uint = 101137;
       
      
      private var _map:MapModel;
      
      private var _resLib:ApplicationDomain;
      
      private var _npc:Mobile;
      
      private var _clickTarget:MovieClip;
      
      private const FOR_LIST:Array = [203682];
      
      private const DAY_LIST:Vector.<int> = Vector.<int>([964]);
      
      private var _index:int;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function GetMoneyRideHorseAct(param1:MapModel)
      {
         var map:MapModel = param1;
         super();
         if(DateUtil.isInTime(new Date(2014,0,24,6,0,0),new Date(2014,1,13,23,59,59)))
         {
            this._map = map;
            DayLimitManager.getDoCount(this.DAY_LIST[0],function(param1:int):void
            {
               var val:int = param1;
               ActiveCountManager.requestActiveCount(FOR_LIST[0],function(param1:uint, param2:uint):void
               {
                  var _loc3_:int = 0;
                  if(FOR_LIST[0] == param1)
                  {
                     if(val < 6)
                     {
                        _loc3_ = 0;
                        while(_loc3_ < 6)
                        {
                           if(_loc3_ == val)
                           {
                              if(TimeManager.getPrecisionServerTime() > param2)
                              {
                                 _index = MAP_ID_LIST.indexOf(_map.id);
                                 if(_index == _loc3_)
                                 {
                                    getURL();
                                 }
                              }
                           }
                           _loc3_++;
                        }
                     }
                  }
               });
            });
         }
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("getMoneyRideHorseAct/GetMoneyRideHorseAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            var sceneMc:MovieClip = null;
            var info:ContentInfo = param1;
            _resLib = info.domain;
            if(_index != -1)
            {
               sceneMc = getMovie("SceneMc" + _index.toString());
               _map.front.addChild(sceneMc);
               MovieClipUtil.playMc(sceneMc,2,sceneMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMc);
                  sceneMc = null;
                  addNpc(DIR_LIST[_index]);
               });
            }
         });
      }
      
      private function addNpc(param1:int = 0) : void
      {
         this._npc = new Mobile();
         this._npc.width = 82;
         this._npc.height = 70;
         this._npc.setPostion(new Point(POS_NPC_LIST[this._index][0],POS_NPC_LIST[this._index][1]));
         this._npc.resourceUrl = URLUtil.getNpcSwf(NPC_ID_LIST[this._index]);
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.buttonMode = true;
         this._npc.direction = param1;
         this.showMouseHintAtMonster(this._npc);
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc1);
      }
      
      private function addClickTarget() : void
      {
         this.removeClickTarget();
         this._clickTarget = this.getMovie("Target");
         this._clickTarget.buttonMode = true;
         this._map.content.addChild(this._clickTarget);
         this._clickTarget.x = POS_TARTET_LIST[this._index][0];
         this._clickTarget.y = POS_TARTET_LIST[this._index][1];
         MovieClipUtil.playMc(this._clickTarget,2,this._clickTarget.totalFrames,function():void
         {
            _clickTarget.gotoAndStop(_clickTarget.totalFrames);
            showMouseHintAtMonster(_clickTarget);
            _clickTarget.addEventListener(MouseEvent.CLICK,onClickTarget);
         });
      }
      
      private function removeClickTarget() : void
      {
         if(this._clickTarget)
         {
            this.removeMouseHint();
            this._clickTarget.removeEventListener(MouseEvent.CLICK,this.onClickTarget);
            DisplayUtil.removeForParent(this._clickTarget);
            this._clickTarget = null;
         }
      }
      
      private function onClickTarget(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.removeClickTarget();
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("getMoneyRideHorse/GetMoney" + this._index.toString()),function():void
         {
            _npc.addEventListener(MouseEvent.CLICK,onNpc2);
            showMouseHintAtMonster(_npc);
            NpcDialog.show(NPC_DAILOGE_LIST[_index],NPC_NAME_LIST[_index],[[NPC_DIALOGE_ID_LIST[_index],NPC_DIALOG_STR_2[_index]]],["嘿嘿，那赶紧收下小马送你的压岁钱吧。"],[function():void
            {
               _npc.mouseEnabled = _npc.mouseChildren = false;
               SwapManager.swapItem(GET_SWAP,1,function(param1:IDataInput):void
               {
                  var sceneMc:* = undefined;
                  var data:IDataInput = param1;
                  new SwapInfo(data);
                  _npc.mouseEnabled = _npc.mouseChildren = true;
                  _npc.removeEventListener(MouseEvent.CLICK,onNpc2);
                  removeNpc();
                  sceneMc = getMovie("SceneMc" + _index.toString() + _index.toString());
                  _map.front.addChild(sceneMc);
                  MovieClipUtil.playMc(sceneMc,2,sceneMc.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(sceneMc);
                     sceneMc = null;
                     ModuleManager.toggleModule(URLUtil.getAppModule("GetMoneyRideHorsePanel"));
                  });
               },function(param1:uint):void
               {
                  _npc.mouseEnabled = _npc.mouseChildren = true;
               });
            }]);
         },true,false,2,true);
      }
      
      private function onNpc2(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(NPC_DAILOGE_LIST[this._index],NPC_NAME_LIST[this._index],[[NPC_DIALOGE_ID_LIST[this._index],NPC_DIALOG_STR_2[this._index]]],["嘿嘿，那赶紧收下小马送你的压岁钱吧。"],[function():void
         {
            _npc.mouseEnabled = _npc.mouseChildren = false;
            SwapManager.swapItem(GET_SWAP,1,function(param1:IDataInput):void
            {
               var sceneMc:* = undefined;
               var data:IDataInput = param1;
               new SwapInfo(data);
               _npc.mouseEnabled = _npc.mouseChildren = true;
               _npc.removeEventListener(MouseEvent.CLICK,onNpc2);
               removeNpc();
               sceneMc = getMovie("SceneMc" + _index.toString() + _index.toString());
               _map.front.addChild(sceneMc);
               MovieClipUtil.playMc(sceneMc,2,sceneMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMc);
                  sceneMc = null;
               });
            },function(param1:uint):void
            {
               _npc.mouseEnabled = _npc.mouseChildren = true;
            });
         }]);
      }
      
      private function showMouseHint(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
         param1.addChild(this._mouseHint);
      }
      
      private function showMouseHintAtMonster(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
         param1.addChild(this._mouseHint);
      }
      
      private function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = null;
      }
      
      private function removeNpc() : void
      {
         if(this._npc)
         {
            this.removeMouseHint();
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc1);
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc2);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function onNpc1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npc.mouseEnabled = this._npc.mouseChildren = false;
         ItemManager.requestEquipList(function():void
         {
            _npc.mouseEnabled = _npc.mouseChildren = true;
            if(!ItemManager.getEquipItem(EQUIP_ID))
            {
               NpcDialog.show(NPC_DAILOGE_LIST[_index],NPC_NAME_LIST[_index],[[NPC_DIALOGE_ID_LIST[_index],"骑上小木马再给我送压岁钱吧！"]],["知道了"],[]);
               return;
            }
            if(!ItemManager.getEquipItem(EQUIP_ID).isEquiped)
            {
               NpcDialog.show(NPC_DAILOGE_LIST[_index],NPC_NAME_LIST[_index],[[NPC_DIALOGE_ID_LIST[_index],"骑上小木马再给我送压岁钱吧！"]],["知道了"],[]);
               return;
            }
            NpcDialog.show(NPC_DAILOGE_LIST[_index],NPC_NAME_LIST[_index],[[NPC_DIALOGE_ID_LIST[_index],NPC_DIALOG_STR[_index]]],[ANSWER_STR[_index][0],ANSWER_STR[_index][1]],[function():void
            {
               NpcDialog.hide();
               removeMouseHint();
               _npc.removeEventListener(MouseEvent.CLICK,onNpc1);
               addClickTarget();
            }]);
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      public function dispose() : void
      {
         this.removeNpc();
         this.removeClickTarget();
         this._map = null;
         this._resLib = null;
      }
   }
}
