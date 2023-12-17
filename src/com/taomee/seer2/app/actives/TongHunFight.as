package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.BitUtil;
   
   public class TongHunFight
   {
      
      private static var _instance:TongHunFight;
       
      
      private const FIGHT_STATE:uint = 204316;
      
      private const BUY_COUNT:uint = 204315;
      
      private const FIGHT_COUNT:uint = 1190;
      
      private const FIGHT_BOSS:uint = 1033;
      
      private const FIGHT_ID:Array = [1029,1030,1031,1032];
      
      private const FREE_COUNT:uint = 3;
      
      private const BUY_COUNT_ID:uint = 603942;
      
      private const SEAT_TIPS:Array = [new Point(724,488),new Point(648,398),new Point(836,308),new Point(365,355)];
      
      private var fightState:uint = 0;
      
      private var buyCount:uint = 0;
      
      private var leftCount:uint;
      
      private var monsterList:Vector.<MovieClip>;
      
      private var seatIndex:int;
      
      private var needPlay:Boolean;
      
      private var mapContent:Sprite;
      
      private var figheBoss:Boolean;
      
      public function TongHunFight()
      {
         super();
      }
      
      public static function getInstance() : TongHunFight
      {
         if(!_instance)
         {
            _instance = new TongHunFight();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this.mapContent = SceneManager.active.mapModel.content;
         this.monsterList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this.monsterList.push(this.mapContent["monster" + _loc1_]);
            this.monsterList[_loc1_].mouseChildren = false;
            this.monsterList[_loc1_].buttonMode = true;
            this.monsterList[_loc1_].addEventListener(MouseEvent.CLICK,this.toFight);
            _loc1_++;
         }
         this.mapContent["hunMc"].stop();
         this.mapContent["hunMc"].buttonMode = true;
         this.mapContent["hunMc"].addEventListener(MouseEvent.CLICK,this.toFightHun);
         ActiveCountManager.requestActiveCountList([this.FIGHT_STATE,this.BUY_COUNT,204314],this.getState);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this.monsterList[_loc1_].removeEventListener(MouseEvent.CLICK,this.toFight);
            SeatTipsManager.removeSeat(this.SEAT_TIPS[_loc1_],951);
            _loc1_++;
         }
         this.mapContent["hunMc"].removeEventListener(MouseEvent.CLICK,this.toFightHun);
      }
      
      protected function toFightHun(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.figheBoss)
         {
            NpcDialog.show(113,"超级NONO",[[0,"你已经获得了瞳魂兽了，不能再挑战它了!"]],["好的"]);
            return;
         }
         if(this.leftCount != 0)
         {
            NpcDialog.show(113,"超级NONO",[[0,"每天有3次挑战机会，您已经挑战" + (3 - this.leftCount) + "次！是否立即开始挑战？"]],["开始挑战","准备一下"],[function():void
            {
               FightManager.startFightWithBoss(FIGHT_BOSS);
            }]);
         }
         else
         {
            NpcDialog.show(113,"超级NONO",[[0,"每天有3次挑战机会，您已经用完所有次数，是否花费星钻继续进行挑战？"]],["继续挑战","准备一下"],[function():void
            {
               ShopManager.buyItemForId(BUY_COUNT_ID,buComplete);
            }]);
         }
      }
      
      private function buComplete(param1:*) : void
      {
         FightManager.startFightWithBoss(this.FIGHT_BOSS);
      }
      
      protected function toFight(param1:MouseEvent) : void
      {
         var _loc2_:int = this.monsterList.indexOf(param1.target as MovieClip);
         if(_loc2_ != this.seatIndex)
         {
            AlertManager.showAlert("你前面的都没搞定就想和我打架，这可不行！");
            return;
         }
         SeatTipsManager.removeSeat(this.SEAT_TIPS[this.seatIndex],951);
         FightManager.startFightWithWild(this.FIGHT_ID[this.seatIndex]);
      }
      
      private function getState(param1:Parser_1142) : void
      {
         this.fightState = param1.infoVec[0];
         if(this.fightState != 15)
         {
            this.needPlay = true;
         }
         this.buyCount = param1.infoVec[1];
         DayLimitManager.getDoCount(this.FIGHT_COUNT,this.getFightCount);
         this.figheBoss = BitUtil.getBit(param1.infoVec[2],1);
      }
      
      private function getFightCount(param1:uint) : void
      {
         this.leftCount = this.getCanNum(param1,this.buyCount,this.FREE_COUNT);
         this.updateDis();
      }
      
      private function updateDis() : void
      {
         var i:int;
         this.seatIndex = -1;
         i = 0;
         while(i < 4)
         {
            if(BitUtil.getBit(this.fightState,i))
            {
               DisplayObjectUtil.removeFromParent(this.monsterList[i]);
               this.monsterList[i].stop();
            }
            else if(this.seatIndex == -1)
            {
               this.seatIndex = i;
               SeatTipsManager.registerSeat(this.SEAT_TIPS[this.seatIndex],951);
            }
            i++;
         }
         if(this.fightState != 15)
         {
            this.mapContent["hunMc"].stop();
            this.mapContent["hunMc"].mouseChildren = false;
            this.mapContent["hunMc"].mouseEnabled = false;
            ColorFilter.setGrayscale(this.mapContent["hunMc"]);
         }
         else if(this.needPlay)
         {
            this.mapContent["hunMc"].visible = false;
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("TongHunShowFull"),function():void
            {
               needPlay = true;
               mapContent["hunMc"].visible = true;
               mapContent["hunMc"].filters = [];
               mapContent["hunMc"].play();
            },false,false,1,false);
         }
         else
         {
            this.mapContent["hunMc"].mouseEnabled = true;
            this.mapContent["hunMc"].filters = [];
            this.mapContent["hunMc"].play();
         }
      }
      
      public function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
   }
}
