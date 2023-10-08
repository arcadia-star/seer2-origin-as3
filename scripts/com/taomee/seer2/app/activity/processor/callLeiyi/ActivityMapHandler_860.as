package com.taomee.seer2.app.activity.processor.callLeiyi
{
   import com.taomee.seer2.app.activity.data.ActivityPet;
   import com.taomee.seer2.app.activity.data.ActivityWildPet;
   import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.NumberUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class ActivityMapHandler_860 extends ActivityMapHandler
   {
      
      private static const BOSS_ID:uint = 151;
       
      
      private var _activityMonsterVec:Vector.<ActivityPet>;
      
      private var _isActivityInitialized:Boolean;
      
      private var _isActivityInitialized_1:Boolean;
      
      private var _hasActivityInitialized:Boolean;
      
      private var _hasActivityInitialized_1:Boolean;
      
      private var _machine:MovieClip;
      
      public function ActivityMapHandler_860(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override public function process() : void
      {
         super.process();
         if(_isTimeOut)
         {
            return;
         }
         if(DateUtil.inInDateScope(5,13,0,13,54))
         {
            this.isPlayFullMC();
         }
         if(DateUtil.inInDateScope(5,13,55,14,0))
         {
            this.PlayLastFullMC();
         }
      }
      
      private function isPlayFullMC() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.Leiyi_Fit_Kaisa,function(param1:ServerBuffer):void
         {
            var _loc2_:int = param1.readDataAtPostion(1);
            if(_loc2_ == 0)
            {
               if(!_isActivityInitialized)
               {
                  _isActivityInitialized = true;
                  playFullMC();
               }
            }
            else if(_loc2_ == 1)
            {
               if(!_isActivityInitialized)
               {
                  _isActivityInitialized = true;
                  setTimeout(addSoldiers,2000);
                  addMachine();
               }
            }
         });
      }
      
      private function PlayLastFullMC() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.Leiyi_Fit_Kaisa,function(param1:ServerBuffer):void
         {
            var _loc2_:int = param1.readDataAtPostion(2);
            if(_loc2_ == 0)
            {
               if(!_hasActivityInitialized)
               {
                  _hasActivityInitialized = true;
                  removeMonster();
                  playFullMCLast();
               }
            }
            else if(_loc2_ == 1)
            {
               if(!_hasActivityInitialized)
               {
                  _hasActivityInitialized = true;
                  removeMonster();
                  addMachine();
               }
            }
         });
      }
      
      private function playFullMC() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("callLeiyi/salunSoldiers"),function():void
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.Leiyi_Fit_Kaisa,1,1);
            addSoldiers();
            addMachine();
         },true,false,2);
      }
      
      private function playFullMCLast() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("callLeiyi/leiyiLeave"),function():void
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.Leiyi_Fit_Kaisa,2,1);
            addMachine();
         },true,false,2);
      }
      
      private function addSoldiers() : void
      {
         var _loc2_:ActivityWildPet = null;
         this._activityMonsterVec = new Vector.<ActivityPet>();
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new ActivityWildPet(9);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onPet);
            this._activityMonsterVec.push(_loc2_);
            MobileManager.addMobile(_loc2_,MobileType.ACTIVITY_MONSTER);
            _loc1_++;
         }
      }
      
      private function onPet(param1:MouseEvent) : void
      {
         var _loc2_:int = int(NumberUtil.random(1,3));
         this.FightSoldiers(_loc2_);
      }
      
      private function FightSoldiers(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               this.NpcOneSpeak();
               break;
            case 2:
               this.NpcTwoSpeak();
               break;
            case 3:
               this.NpcThreeSpeak();
         }
      }
      
      private function NpcOneSpeak() : void
      {
         NpcDialog.show(32,"萨伦士兵",[[0,"你这个臭铁皮还敢找救兵！"]],["我看你是在找PK吧！","大哥，我马上离开。"],[function():void
         {
            FightManager.startFightWithWild(BOSS_ID);
         }]);
      }
      
      private function NpcTwoSpeak() : void
      {
         NpcDialog.show(32,"萨伦士兵",[[0,"不自量力的家伙，赶紧给我滚！要不然有你好看的！"]],["我要打得你屁滚尿流！","哇！好凶哦，我害怕！"],[function():void
         {
            FightManager.startFightWithWild(BOSS_ID);
         }]);
      }
      
      private function NpcThreeSpeak() : void
      {
         NpcDialog.show(32,"萨伦士兵",[[0,"你这个家伙，竟然把我的队友全都打跑了。哼！我得好好教训你！"]],["看看到底是谁教训谁吧！","我马上离开！"],[function():void
         {
            FightManager.startFightWithWild(BOSS_ID);
         }]);
      }
      
      private function addMachine() : void
      {
         var _loc1_:String = String(URLUtil.getActivityAnimation("callLeiyi/machine"));
         QueueLoader.load(_loc1_,LoadType.SWF,this.onTakePicLoaded);
      }
      
      private function onTakePicLoaded(param1:ContentInfo) : void
      {
         var _loc2_:MovieClip = param1.content as MovieClip;
         this._machine = _loc2_["mc_0"] as MovieClip;
         LayerManager.dialogLayer.addChild(this._machine);
         this._machine.buttonMode = true;
         this._machine.addEventListener(MouseEvent.CLICK,this.openPanelHandler);
      }
      
      private function openPanelHandler(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("CallLeiyiPanel"),"正在打开抽奖面板 ...");
      }
      
      private function removeMonster() : void
      {
         var _loc1_:uint = 0;
         if(this._activityMonsterVec)
         {
            _loc1_ = 0;
            while(_loc1_ < this._activityMonsterVec.length)
            {
               this._activityMonsterVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.onPet);
               _loc1_++;
            }
            MobileManager.clearMobileVec(MobileType.ACTIVITY_MONSTER);
         }
      }
      
      override public function dispose() : void
      {
         if(this._machine)
         {
            DisplayUtil.removeForParent(this._machine);
         }
         this.removeMonster();
      }
   }
}
