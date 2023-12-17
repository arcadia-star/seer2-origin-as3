package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.OnlyFlagManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1209;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_57;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class ChallengePhenixAct
   {
      
      private static var _instance:ChallengePhenixAct;
       
      
      private var mobileVec:Vector.<Mobile>;
      
      private var mobilePosition:Array;
      
      private var limitIds:Array;
      
      private var callFight:Array;
      
      private var resArr:Array;
      
      private var datas:Dictionary;
      
      private var currentTarget:Mobile;
      
      private var callAnimation:MovieClip;
      
      private var callFightId:int;
      
      private var fightPhinexNum:int = 0;
      
      private var fightPhinexId:int;
      
      private var maxNum:int;
      
      private var isplayFull:Boolean = false;
      
      public function ChallengePhenixAct()
      {
         this.mobilePosition = [{
            "x":320,
            "y":315
         },{
            "x":485,
            "y":440
         },{
            "x":665,
            "y":336
         },{
            "x":490,
            "y":340
         }];
         this.limitIds = [550,551,552,553,554,535];
         this.callFight = [[216,217,218,219,230],[220,221,222,223,231],[224,225,226,227,232]];
         this.resArr = [[529,524],[530,525],[521,526],["PhinexHalo",527]];
         super();
      }
      
      public static function getInstance() : ChallengePhenixAct
      {
         if(!_instance)
         {
            _instance = new ChallengePhenixAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_CATCH_PET_1031,this.onCaptureComplete);
         ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57,this.getBuffer);
      }
      
      private function getBuffer(param1:ServerBuffer) : void
      {
         var buff:ServerBuffer = param1;
         var isPlay:int = buff.readDataAtPostion(ServerBufferPosition_57.IS_PLAY_CHALLENGEPHENIX);
         if(isPlay == 0 && QuestManager.isComplete(35))
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ChallengePhenixAct"),function():void
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("ChallengePhenixPanel"));
               isPlay = 1;
               ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57,4,1);
               requestLimit();
            });
         }
         else
         {
            this.requestLimit();
         }
      }
      
      private function requestLimit() : void
      {
         Connection.addCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.onGetRange);
         Connection.send(CommandSet.GET_RANGE_DAY_LIMIT_1209,5,[550,551,552,553,554]);
      }
      
      private function onGetRange(param1:MessageEvent) : void
      {
         var parse1209:Parser_1209;
         var event:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.onGetRange);
         parse1209 = new Parser_1209(event.message.getRawData());
         this.datas = parse1209.limitMap;
         OnlyFlagManager.RequestFlag(function():void
         {
            datas[535] = OnlyFlagManager.getFlag(535);
            initMobile();
         });
      }
      
      private function initMobile() : void
      {
         var i:int = 0;
         var mobile:Mobile = null;
         this.maxNum = ActorManager.actorInfo.vipInfo.isVip() ? 10 : 5;
         this.fightPhinexNum = this.datas[this.limitIds[3]];
         if(this.fightPhinexNum >= this.maxNum && SceneManager.prevSceneType == SceneType.ARENA)
         {
            NpcDialog.show(527,"凤凰",[[0,"小赛尔，你的<font color=\'#ff0000\'>" + this.maxNum + "</font>次挑战机会都已用尽了，看来你的精灵还不够强大哦！我们明日再战吧！"]],["  好！明天见！"]);
            return;
         }
         if(this.fightPhinexNum >= this.maxNum)
         {
            return;
         }
         if(!this.mobileVec)
         {
            this.mobileVec = new Vector.<Mobile>();
            i = 0;
            while(i < 4)
            {
               mobile = new Mobile();
               mobile.buttonMode = true;
               mobile.mouseChildren = false;
               this.mobileVec.push(mobile);
               i++;
            }
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == this.fightPhinexId && !FightManager.isWinWar())
         {
            NpcDialog.show(527,"凤凰",[[0,"看来你还不能驾驭我呢，别泄气，再来一次吧！你还有<font color=\'#ff0000\'>" + (this.maxNum - this.fightPhinexNum) + "</font>次机会！"]],[" 这次我一定可以的！来吧！","准备下再来!"],[function():void
            {
               if(fightPhinexId == 229)
               {
                  FightManager.startFightWithWild(fightPhinexId);
                  Connection.removeCommandListener(CommandSet.FIGHT_CATCH_PET_1031,onCaptureComplete);
                  Connection.addCommandListener(CommandSet.FIGHT_CATCH_PET_1031,onCaptureComplete);
               }
               else
               {
                  FightManager.startFightWithWild(fightPhinexId);
               }
            }]);
         }
         this.setDefalutRes(0,this.resArr[0][0],"点击召唤仙鹤");
         this.setDefalutRes(1,this.resArr[1][0],"先召唤到仙鹤再\n来召唤火烈鸟");
         this.setDefalutRes(2,this.resArr[2][0],"先召唤到仙鹤和火\n烈鸟，再来召唤孔雀");
         this.setDefalutRes(3,this.resArr[3][0],"召唤到三鸟后，\n凤凰将现身！");
         this.checkDayLimit();
      }
      
      private function checkDayLimit() : void
      {
         this.checkCall(0);
         this.checkCall(1);
         this.checkCall(2);
         this.checkPhinex();
      }
      
      private function checkPhinex() : void
      {
         var _loc1_:Mobile = this.mobileVec[3];
         if(this.datas[this.limitIds[0]] > 1 && this.datas[this.limitIds[1]] > 1 && this.datas[this.limitIds[2]] > 1)
         {
            if(this.fightPhinexNum == 0 && !this.isplayFull)
            {
               this.isplayFull = true;
               MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("showPhinex"));
            }
            _loc1_.resourceUrl = URLUtil.getNpcSwf(this.resArr[3][1]);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK,this.fightPhinex);
         }
      }
      
      private function checkCall(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.datas[this.limitIds[param1]] > 1)
         {
            _loc2_ = this.mobileVec.indexOf(this.currentTarget);
            if(_loc2_ == param1 && SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == this.callFightId)
            {
               this.showMobile();
            }
            else
            {
               TooltipManager.remove(this.mobileVec[param1]);
               MobileManager.removeMobile(this.mobileVec[param1],MobileType.NPC);
               this.mobileVec[param1].resourceUrl = URLUtil.getNpcSwf(this.resArr[param1][1]);
               MobileManager.addMobile(this.mobileVec[param1],MobileType.NPC);
            }
            this.mobileVec[param1].removeEventListener(MouseEvent.CLICK,this.toCall);
         }
      }
      
      private function setDefalutRes(param1:int, param2:String, param3:String) : void
      {
         if(param1 == 3)
         {
            this.mobileVec[param1].resourceUrl = URLUtil.getActivityMobile(param2);
         }
         else
         {
            this.mobileVec[param1].resourceUrl = URLUtil.getNpcSwf(int(param2));
            this.mobileVec[param1].addEventListener(MouseEvent.CLICK,this.toCall);
         }
         this.mobileVec[param1].x = this.mobilePosition[param1].x;
         this.mobileVec[param1].y = this.mobilePosition[param1].y;
         TooltipManager.addCommonTip(this.mobileVec[param1],param3);
         MobileManager.addMobile(this.mobileVec[param1],MobileType.NPC);
      }
      
      private function fightPhinex(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.datas[this.limitIds[4]] < 1 || this.datas[this.limitIds[5]] > 0)
         {
            this.fightPhinexId = 228;
         }
         else if(this.datas[this.limitIds[5]] < 1)
         {
            this.fightPhinexId = 229;
         }
         if(this.fightPhinexId == 229)
         {
            NpcDialog.show(527,"凤凰",[[0,"小赛尔很棒啊！我很欣赏你！带上你的高级或<font color=\'#ff0000\'>无敌精灵胶囊</font>了吗，因为在接下来的挑战中你就可以带走我！ 你只有5个回合的机会哦！"]],[" 进入捕捉模式挑战","我先去准备胶囊"],[function():void
            {
               FightManager.startFightWithWild(fightPhinexId);
               Connection.removeCommandListener(CommandSet.FIGHT_CATCH_PET_1031,onCaptureComplete);
               Connection.addCommandListener(CommandSet.FIGHT_CATCH_PET_1031,onCaptureComplete);
            }]);
         }
         else
         {
            NpcDialog.show(527,"凤凰",[[0,"小赛尔，谢谢你和族民们将我召唤到美丽的阿卡迪亚星球！想让我留在你的身边吗？来吧！先战胜我！你有<font color=\'#ff0000\'>" + (this.maxNum - this.fightPhinexNum) + "</font>次机会！"]],["   好！开始吧!","我……我怕……"],[function():void
            {
               FightManager.startFightWithWild(fightPhinexId);
            }]);
         }
      }
      
      private function onCaptureComplete(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_CATCH_PET_1031,this.onCaptureComplete);
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         OnlyFlagManager.updataFlag(535,1);
      }
      
      public function dispose() : void
      {
         if(!this.mobileVec)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            if(this.mobileVec[_loc1_])
            {
               this.mobileVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.toCall);
               TooltipManager.remove(this.mobileVec[_loc1_]);
            }
            _loc1_++;
         }
         if(this.mobileVec[3])
         {
            this.mobileVec[3].removeEventListener(MouseEvent.CLICK,this.fightPhinex);
         }
         Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.onGetRange);
      }
      
      private function toCall(param1:MouseEvent) : void
      {
         this.currentTarget = param1.target as Mobile;
         var _loc2_:int = this.mobileVec.indexOf(this.currentTarget);
         if(_loc2_ > 0)
         {
            if(this.datas[this.limitIds[_loc2_ - 1]] < 2)
            {
               AlertManager.showAlert("小赛尔先战胜前方的神鸟护卫，再来挑战我吧!加油！");
               return;
            }
         }
         var _loc3_:Array = this.callFight[_loc2_];
         this.callFightId = _loc3_[int(Math.random() * (_loc3_.length - 1))];
         if(this.datas[this.limitIds[_loc2_]] == 1)
         {
            this.callFightId = _loc3_[_loc3_.length - 1];
         }
         FightManager.startFightWithWild(this.callFightId);
      }
      
      private function showMobile() : void
      {
         var _loc1_:int = this.mobileVec.indexOf(this.currentTarget);
         TooltipManager.remove(this.mobileVec[_loc1_]);
         MobileManager.removeMobile(this.mobileVec[_loc1_],MobileType.NPC);
         this.mobileVec[_loc1_].resourceUrl = URLUtil.getNpcSwf(this.resArr[_loc1_][1]);
         this.currentTarget = this.mobileVec[_loc1_];
         if(!this.callAnimation)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("CallAnimation"),LoadType.SWF,this.onLoadComplete);
         }
         else
         {
            this.toPlay();
         }
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this.callAnimation = param1.content as MovieClip;
         this.toPlay();
      }
      
      private function toPlay() : void
      {
         this.callAnimation.x = this.currentTarget.x - 45;
         this.callAnimation.y = this.currentTarget.y - 200;
         SceneManager.active.mapModel.front.addChild(this.callAnimation);
         MovieClipUtil.playMc(this.callAnimation,1,this.callAnimation.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(callAnimation);
            MobileManager.addMobile(currentTarget,MobileType.NPC);
         });
      }
   }
}
