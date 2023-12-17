package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_2622 extends MapProcessor
   {
       
      
      private const SHOOTED_NUM:Array = [1092,1093];
      
      private const SCORE_TYPE:Array = [[83,84],[85,86]];
      
      private const SWAP_SHOOT:uint = 2720;
      
      private const ACTIVE_INDEX:uint = 10;
      
      private var actorList:Vector.<RemoteActor>;
      
      private var shootedNum:int;
      
      private var leftTime:int;
      
      public function MapProcessor_2622(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         ShootController.addEventListener(ShootEvent.PLAY_END,this.shootComplete);
         var _loc1_:Date = new Date();
         _loc1_.setTime(TimeManager.getPrecisionServerTime() * 1000);
         var _loc2_:Boolean = _loc1_.hours >= 13 && _loc1_.hours < 14;
         var _loc3_:Boolean = _loc1_.hours >= 18 && _loc1_.hours < 19;
         if(!_loc2_ && !_loc3_)
         {
            this.alertTime();
         }
         if(_loc2_)
         {
            DayLimitManager.getDoCount(this.SHOOTED_NUM[0],this.getShooted);
         }
         else
         {
            DayLimitManager.getDoCount(this.SHOOTED_NUM[1],this.getShooted);
         }
         this.leftTime = (60 - _loc1_.minutes) * 60 + (60 - _loc1_.seconds);
         Tick.instance.addRender(this.updateTime,1000);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,this.updateIcon);
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.updateIcon);
      }
      
      private function updateTime(param1:uint) : void
      {
         --this.leftTime;
         if(this.leftTime == 0)
         {
            Tick.instance.removeRender(this.updateTime);
            this.alertTime();
         }
         _map.content["timeTxt"].text = "剩余时间:" + DateUtil.getMS(this.leftTime);
      }
      
      private function alertTime() : void
      {
         AlertManager.showAlert("时间到了哦!",function():void
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,showPanel);
            SceneManager.changeScene(SceneType.PLANT,ActorManager.actorInfo.id);
         });
      }
      
      private function updateIcon(param1:MessageEvent) : void
      {
         var _loc3_:RemoteActor = null;
         var _loc2_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getInfo().activityData[this.ACTIVE_INDEX] == 1)
            {
               _loc3_.addEggIcon("UI_WorldWarA");
            }
            else if(_loc3_.getInfo().activityData[this.ACTIVE_INDEX] == 2)
            {
               _loc3_.addEggIcon("UI_WorldWarB");
            }
         }
         if(ActorManager.actorInfo.activityData[this.ACTIVE_INDEX] == 1)
         {
            ActorManager.getActor().addEggIcon("UI_WorldWarA");
         }
         else if(ActorManager.actorInfo.activityData[this.ACTIVE_INDEX] == 2)
         {
            ActorManager.getActor().addEggIcon("UI_WorldWarB");
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ActorManager.getActor().removeEggIcon();
         Tick.instance.removeRender(this.updateTime);
         Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002,this.updateIcon);
         Connection.removeCommandListener(CommandSet.LIST_USER_1004,this.updateIcon);
      }
      
      private function getShooted(param1:uint) : void
      {
         this.shootedNum = param1;
         this.checkShooted();
      }
      
      private function shootComplete(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         var _loc3_:int = 0;
         this.actorList = ActorManager.getAllRemoteActors();
         if(_loc2_.userID == ActorManager.actorInfo.id)
         {
            _loc3_ = 0;
            while(_loc3_ < this.actorList.length)
            {
               if(this.actorList[_loc3_].hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y) && this.actorList[_loc3_].getInfo().activityData[this.ACTIVE_INDEX] != ActorManager.actorInfo.activityData[this.ACTIVE_INDEX])
               {
                  SwapManager.swapItem(this.SWAP_SHOOT,1,this.swapComplete,null,new SpecialInfo(1,this.actorList[_loc3_].getInfo().id));
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < this.actorList.length)
            {
               if(this.actorList[_loc3_].getInfo().id == _loc2_.userID)
               {
                  break;
               }
               _loc3_++;
            }
            if(ActorManager.getActor().hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y) && this.actorList[_loc3_].getInfo().activityData[this.ACTIVE_INDEX] != ActorManager.actorInfo.activityData[this.ACTIVE_INDEX])
            {
               ++this.shootedNum;
               this.checkShooted();
            }
         }
      }
      
      private function checkShooted() : void
      {
         if(this.shootedNum >= 30)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.showPanel);
            SceneManager.changeScene(SceneType.PLANT,ActorManager.actorInfo.id);
         }
      }
      
      private function showPanel(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.showPanel);
         ModuleManager.showAppModule("FoolDayFightPanel");
         AlertManager.showAlert("你已经被射中30次了,不能继续参与射击了哦！");
      }
      
      private function swapComplete(param1:IDataInput) : void
      {
         new SwapInfo(param1);
      }
   }
}
