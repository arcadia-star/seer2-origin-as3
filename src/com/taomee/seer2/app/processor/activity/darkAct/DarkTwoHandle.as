package com.taomee.seer2.app.processor.activity.darkAct
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class DarkTwoHandle
   {
       
      
      private const RES_LIST:Vector.<int> = Vector.<int>([1059,1060,1061]);
      
      private const POS_INDEX:Vector.<int> = Vector.<int>([360,361,362]);
      
      private const GOLE_KILL_NUM:int = 5;
      
      private var _type:int;
      
      private var _curLeaveTime:int;
      
      private var _killNum:int;
      
      private var _resLib:ApplicationDomain;
      
      private var _model:MapModel;
      
      private var _timeMc:MovieClip;
      
      private var _main:DarkTwoLayer;
      
      public function DarkTwoHandle(param1:int)
      {
         super();
         this._type = param1;
      }
      
      public function initSet(param1:Array) : void
      {
         this._resLib = param1[0] as ApplicationDomain;
         this._model = param1[1] as MapModel;
         this._main = param1[2] as DarkTwoLayer;
         var _loc2_:Number = Number(param1[3]);
         if(_loc2_ == 0)
         {
            this._curLeaveTime = 0;
         }
         else
         {
            this._curLeaveTime = 180 - (TimeManager.getServerTime() - param1[3]);
         }
         this._killNum = param1[4];
         if(this._curLeaveTime > 0)
         {
            this.timePanelShow();
         }
         else
         {
            this.timePanelHide();
         }
      }
      
      public function set curLeaveTime(param1:Number) : void
      {
         this._curLeaveTime = param1;
      }
      
      public function getCurLeaveTime() : int
      {
         return this._curLeaveTime;
      }
      
      public function playSceneTalk(param1:String, param2:Function = null, param3:Array = null) : void
      {
         var _scenMc:MovieClip = null;
         var resName:String = param1;
         var afterFunc:Function = param2;
         var params:Array = param3;
         _scenMc = this.getMovie(resName);
         this._model.front.addChild(_scenMc);
         MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_scenMc);
            _scenMc = null;
            if(afterFunc != null)
            {
               afterFunc.call(params);
            }
         },true);
      }
      
      private function timePanelShow() : void
      {
         if(!this._timeMc)
         {
            this._timeMc = this.getMovie("timePanel");
            this._timeMc.x = 370;
            this._timeMc.y = 150;
         }
         this._model.front.addChild(this._timeMc);
      }
      
      private function timePanelHide() : void
      {
         if(Boolean(this._timeMc) && Boolean(this._timeMc.parent))
         {
            DisplayUtil.removeForParent(this._timeMc);
         }
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      public function start() : void
      {
         this._main.hideNpc();
         this.timePanelShow();
         this._curLeaveTime = 180;
         this.stateUpdate();
      }
      
      public function stateUpdate() : void
      {
         if(this._curLeaveTime > 0)
         {
            Tick.instance.addRender(this.timeShow,1000);
         }
         this.updateMonster();
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var _loc2_:int = 0;
         if(FightManager.fightWinnerSide == FightSide.LEFT)
         {
            _loc2_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if(_loc2_ == this.POS_INDEX[this._type])
            {
               ++this._killNum;
               if(this._killNum < this.GOLE_KILL_NUM)
               {
                  this.updateMonster();
               }
               else
               {
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
                  this.completeHandle();
               }
            }
         }
         else
         {
            this.updateMonster();
         }
      }
      
      public function completeHandle() : void
      {
         this.timePanelHide();
         this._main.showNpc();
         Tick.instance.removeRender(this.timeShow);
         if(this._type == 2)
         {
            this.playSceneTalk("sceneTalk_3",function():void
            {
               if(DialogPanel.functionalityBox.getUnit("审判阵挑战开始"))
               {
                  DialogPanel.functionalityBox.removeUnit(DialogPanel.functionalityBox.getUnit("审判阵挑战开始"));
               }
            });
         }
         if(this._type <= 1)
         {
            this.playSceneTalk("sceneTalk_" + (this._type + 1),function():void
            {
            });
         }
         this._main.type = this._type;
         MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
      }
      
      private function timeShow(param1:int) : void
      {
         --this._curLeaveTime;
         if(this._curLeaveTime > 0)
         {
            this._timeMc.visible = true;
            (this._timeMc["time"] as TextField).text = this.styleChange(this._curLeaveTime);
         }
         else
         {
            this._timeMc.visible = false;
         }
         if(this._curLeaveTime <= 0)
         {
            ActorManager.getActor().stand();
            this.failHandle();
         }
      }
      
      public function failHandle() : void
      {
         ServerMessager.addMessage("时间到，关卡挑战失败，重新挑战吧");
         MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
         this._main.showNpc();
         this.dispose();
      }
      
      public function initHandle() : void
      {
         MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
         this._main.showNpc();
      }
      
      public function updateMonster() : void
      {
         var _loc3_:SpawnedPet = null;
         MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
         var _loc1_:int = 5 - this._killNum;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new SpawnedPet(this.RES_LIST[this._type],this.POS_INDEX[this._type],0);
            MobileManager.addMobile(_loc3_,MobileType.SPAWNED_PET);
            _loc2_++;
         }
      }
      
      public function styleChange(param1:int) : String
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc2_:int = param1 / 60;
         var _loc4_:int = param1 % 60;
         if(_loc2_ <= 9)
         {
            _loc3_ = "0" + String(_loc2_);
         }
         else
         {
            _loc3_ = String(_loc2_);
         }
         if(_loc4_ <= 9)
         {
            _loc5_ = "0" + String(_loc4_);
         }
         else
         {
            _loc5_ = String(_loc4_);
         }
         return _loc3_ + ":" + _loc5_;
      }
      
      public function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
         MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
         this.timePanelHide();
         Tick.instance.removeRender(this.timeShow);
         this._main.curHandle = null;
         this._resLib = null;
         this._model = null;
         this._timeMc = null;
         this._main = null;
      }
   }
}
