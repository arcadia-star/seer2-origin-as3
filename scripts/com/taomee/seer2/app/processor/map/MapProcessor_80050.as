package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80050 extends MapProcessor
   {
       
      
      private const SWAP_ID:uint = 1789;
      
      private var shootTargetList:Vector.<MovieClip>;
      
      private var bloodList:Vector.<MovieClip>;
      
      private var eftList:Vector.<MovieClip>;
      
      private var bloodNums:Array;
      
      public function MapProcessor_80050(param1:MapModel)
      {
         this.bloodNums = [1,1,1];
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.shootComplete);
      }
      
      override public function init() : void
      {
         var currentDate:Date;
         var isA:Boolean;
         var isB:Boolean;
         var i:int = 0;
         StatisticsManager.sendNovice("0x1003406F");
         currentDate = new Date(TimeManager.getPrecisionServerTime() * 1000);
         isA = currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 1 && currentDate.hours == 14 && currentDate.minutes < 21;
         isB = currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 3 && currentDate.hours == 14 && currentDate.minutes < 21;
         if(isA || isB)
         {
            ShootController.addEventListener(ShootEvent.PLAY_END,this.shootComplete);
            this.bloodList = new Vector.<MovieClip>();
            this.shootTargetList = new Vector.<MovieClip>();
            this.eftList = new Vector.<MovieClip>();
            i = 0;
            while(i < 3)
            {
               this.bloodList.push(_map.content["blood" + i]);
               this.bloodList[i].gotoAndStop(1);
               this.shootTargetList.push(_map.content["target" + i]);
               this.eftList.push(_map.content["eft" + i]);
               this.eftList[i].gotoAndStop(1);
               DisplayObjectUtil.removeFromParent(this.eftList[i]);
               i++;
            }
         }
         else
         {
            AlertManager.showAlert("活动时间已经结束了,去传送室看看其他活动吧!",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
      }
      
      private function shootComplete(param1:ShootEvent) : void
      {
         var info:ShootInfo;
         var i:int = 0;
         var event:ShootEvent = param1;
         var currentDate:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
         var isA:Boolean = currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 1 && currentDate.hours == 14 && currentDate.minutes < 21;
         var isB:Boolean = currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 3 && currentDate.hours == 14 && currentDate.minutes < 21;
         if(!isA && !isB)
         {
            AlertManager.showAlert("活动时间已经结束了,去传送室看看其他活动吧!",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
            return;
         }
         info = event.info;
         i = 0;
         while(i < 3)
         {
            if(info.userID == ActorManager.actorInfo.id && this.shootTargetList[i].hitTestPoint(info.endPos.x,info.endPos.y))
            {
               ++this.bloodNums[i];
               if(this.bloodNums[i] == 35)
               {
                  this.eftList[i].x = this.shootTargetList[i].x;
                  this.eftList[i].y = this.shootTargetList[i].y;
                  _map.front.addChild(this.eftList[i]);
                  DisplayObjectUtil.removeFromParent(this.bloodList[i]);
                  DisplayObjectUtil.removeFromParent(this.shootTargetList[i]);
                  MovieClipUtil.playMc(this.eftList[i],1,this.eftList[i].totalFrames);
                  SwapManager.swapItem(this.SWAP_ID,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                  });
               }
               this.updateDisplay();
               break;
            }
            i++;
         }
      }
      
      private function updateDisplay() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.bloodList[_loc1_].gotoAndStop(this.bloodNums[_loc1_]);
            _loc1_++;
         }
      }
   }
}
