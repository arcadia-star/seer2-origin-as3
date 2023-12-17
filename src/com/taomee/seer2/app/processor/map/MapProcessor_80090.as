package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80090 extends MapProcessor
   {
      
      private static const FIGHT_NUM_DAY:int = 893;
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([734,735]);
      
      private static const FIGHT_NUM_MI_BUY_FOR:int = 203483;
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([5,8]);
       
      
      private var _resLib:ApplicationDomain;
      
      private var _npcList:Vector.<Mobile>;
      
      public function MapProcessor_80090(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.huoKeNuErSuperProcessActInit();
      }
      
      private function huoKeNuErSuperProcessActInit() : void
      {
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
                        createNpcList();
                     }
                     else
                     {
                        TweenNano.delayedCall(3,function():void
                        {
                           ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                           SceneManager.changeScene(SceneType.LOBBY,70);
                        });
                     }
                  }
               });
            });
         }
         else
         {
            this.createNpcList();
         }
      }
      
      private function getURL(param1:Function = null) : void
      {
         var callBack:Function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("huoKeNuErSuperProcess"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            if(callBack != null)
            {
               callBack();
            }
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
      
      private function createNpcList() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.HUO_KE_NU_ER_FIRST_FIGHT,function(param1:ServerBuffer):void
         {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
            if(!_isPlay)
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.HUO_KE_NU_ER_FIRST_FIGHT,1,1);
               getURL(function():void
               {
                  var sceneMC:MovieClip = null;
                  sceneMC = getMovie("SceneMC");
                  _map.front.addChild(sceneMC);
                  MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(sceneMC);
                     sceneMC = null;
                     _npcList = new Vector.<Mobile>();
                     _npcList.push(createNpc([75,80],672,[393,394],"乔尼"));
                     _npcList.push(createNpc([96,95],671,[577,397],"大将岩浮"));
                  },true);
               });
            }
            else
            {
               _npcList = new Vector.<Mobile>();
               _npcList.push(createNpc([75,80],672,[393,394],"乔尼"));
               _npcList.push(createNpc([96,95],671,[577,397],"大将岩浮"));
            }
         });
      }
      
      private function createNpc(param1:Array, param2:int, param3:Array, param4:String) : Mobile
      {
         var _loc5_:Mobile = null;
         (_loc5_ = new Mobile()).width = param1[0];
         _loc5_.height = param1[1];
         _loc5_.setPostion(new Point(param3[0],param3[1]));
         _loc5_.resourceUrl = URLUtil.getNpcSwf(param2);
         _loc5_.labelPosition = MobileLabelPosition.OVER_HEAD;
         _loc5_.label = param4;
         _loc5_.labelImage.y = -_loc5_.height - 10;
         _loc5_.buttonMode = true;
         MobileManager.addMobile(_loc5_,MobileType.NPC);
         _loc5_.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         return _loc5_;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var evt:MouseEvent = param1;
         var params:Array = [[672,"乔尼","干嘛干嘛？你谁啊你？这是给大哥的石头！","我要抢一抢！","过会儿找你玩"],[671,"大将岩浮","连你个机器人也欺负我们！我们老大可不好惹！","我就是想要点石头！","算了算了"]];
         index = this._npcList.indexOf(evt.currentTarget as Mobile);
         NpcDialog.show(params[index][0],params[index][1],[[0,params[index][2]]],[params[index][3],params[index][4]],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[index]);
         }]);
      }
      
      private function clearNpcList() : void
      {
         var _loc1_:int = 0;
         if(this._npcList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._npcList.length)
            {
               this._npcList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onNpcClick);
               _loc1_++;
            }
            this._npcList = null;
         }
      }
      
      private function huoKeNuErSuperProcessActDispose() : void
      {
         this.clearNpcList();
      }
      
      override public function dispose() : void
      {
         this.huoKeNuErSuperProcessActDispose();
         super.dispose();
      }
   }
}
