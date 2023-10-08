package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.BitUtil;
   
   public class MapProcessor_80392 extends MapProcessor
   {
       
      
      private var _npc:Vector.<Mobile>;
      
      private const FOR_COUNT:uint = 205498;
      
      private const DAY_COUNT:uint = 1590;
      
      private const MI_COUNT:uint = 605428;
      
      private const FREE_COUNT:Vector.<uint> = Vector.<uint>([3,5]);
      
      private const FOR_KILL:uint = 205499;
      
      private const NPC_POS:Vector.<Point> = Vector.<Point>([new Point(610,400),new Point(360,480),new Point(840,480)]);
      
      private const NPC_ID:Vector.<uint> = Vector.<uint>([856,745,744]);
      
      private const NPC_LABEL:Vector.<String> = Vector.<String>(["观星圣主","占星者","噬星少主"]);
      
      private const FIGHT_LIST:Vector.<uint> = Vector.<uint>([1462,1463,1464]);
      
      private var _isComplete:Vector.<Boolean>;
      
      private var _isLast:Boolean;
      
      private var _leftCount:int;
      
      public function MapProcessor_80392(param1:MapModel)
      {
         super(param1);
      }
      
      private function get leftCount() : int
      {
         return this._leftCount;
      }
      
      private function set leftCount(param1:int) : void
      {
         this._leftCount = param1;
      }
      
      override public function init() : void
      {
         super.init();
         ActiveCountManager.requestActiveCountList([this.FOR_COUNT,this.FOR_KILL],function(param1:Parser_1142):void
         {
            var i:int;
            var par:Parser_1142 = param1;
            var t:int = 3;
            _isComplete = new Vector.<Boolean>();
            i = 0;
            while(i < 3)
            {
               _isComplete.push(BitUtil.getBit(par.infoVec[1],i));
               if(_isComplete[i])
               {
                  t--;
               }
               i++;
            }
            _isLast = t == 1;
            DayLimitManager.getDoCount(DAY_COUNT,function(param1:uint):void
            {
               leftCount = ActsHelperUtil.getCanNum(param1,par.infoVec[0],FREE_COUNT[VipManager.vipInfo.isVip() ? 1 : 0]);
            });
         });
         this.createNpc();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      private function createNpc() : void
      {
         var _loc2_:Mobile = null;
         this._npc = new Vector.<Mobile>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new Mobile();
            _loc2_.setPostion(this.NPC_POS[_loc1_]);
            _loc2_.resourceUrl = URLUtil.getNpcSwf(this.NPC_ID[_loc1_]);
            _loc2_.labelPosition = MobileLabelPosition.OVER_HEAD;
            _loc2_.label = this.NPC_LABEL[_loc1_];
            _loc2_.labelImage.y = -_loc2_.height - 10;
            _loc2_.buttonMode = true;
            MobileManager.addMobile(_loc2_,MobileType.NPC);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onNpcClick);
            this._npc.push(_loc2_);
            _loc1_++;
         }
      }
      
      protected function onNpcClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var event:MouseEvent = param1;
         index = this._npc.indexOf(event.currentTarget);
         if(this._isComplete[index])
         {
            ServerMessager.addMessage("你已战胜" + this.NPC_LABEL[index] + "，继续挑战其他霸主！");
         }
         else if(this.leftCount > 0)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
            FightManager.startFightWithBoss(this.FIGHT_LIST[index]);
         }
         else
         {
            ShopManager.buyItemForId(this.MI_COUNT,function():void
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
               FightManager.startFightWithBoss(FIGHT_LIST[index]);
            });
         }
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var index:int = 0;
         var result:int = 0;
         var event:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            index = this.FIGHT_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex);
            if(index != -1)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
               result = -1;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  if(this._isLast)
                  {
                     result = 0;
                  }
               }
               else
               {
                  result = 1;
               }
               if(result != -1)
               {
                  SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function on70(param1:SceneEvent):void
                  {
                     SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,on70);
                     ModuleManager.showModule(URLUtil.getAppModule("UKFightResultPanel"),"正在打开战斗结算面板...",{
                        "space":1,
                        "result":result
                     });
                  });
                  SceneManager.changeScene(SceneType.LOBBY,70);
               }
            }
         }
      }
   }
}
