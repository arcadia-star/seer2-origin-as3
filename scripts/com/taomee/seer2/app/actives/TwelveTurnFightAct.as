package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.Tick;
   
   public class TwelveTurnFightAct
   {
      
      private static var _instance:com.taomee.seer2.app.actives.TwelveTurnFightAct;
       
      
      private const FIGHT_LIST:Array = [699,700,700];
      
      private const FIGHT_STATE:int = 877;
      
      private const ACT_YEAR:uint = 2013;
      
      private const ACT_MONTH:uint = 12;
      
      private const ACT_DAY:Array = [1];
      
      private const PET_DIA_ID1:uint = 644;
      
      private const PET_DIA_NAME1:String = "电魂巴图";
      
      private const PET_DIA_ID2:uint = 592;
      
      private const PET_DIA_NAME2:String = "紫电";
      
      private const PET_DIA_ID3:uint = 592;
      
      private const PET_DIA_NAME3:String = "紫电";
      
      private const MAP_ID:uint = 80068;
      
      private var timeDate:Date;
      
      private var minute:uint;
      
      private var currentTurn:uint;
      
      private var resLib:ResourceLibrary;
      
      private var sceneMc:MovieClip;
      
      private var rewardTipsMc:MovieClip;
      
      private var map:MapModel;
      
      private var seatTips:Array;
      
      private var currentNpc:MovieClip;
      
      private var actIndex:int;
      
      private var fightState:uint;
      
      public function TwelveTurnFightAct()
      {
         this.timeDate = new Date();
         this.seatTips = [new Point(295,205),new Point(630,300),new Point(630,300)];
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.actives.TwelveTurnFightAct
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.actives.TwelveTurnFightAct();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         if(this.currentNpc)
         {
            this.currentNpc.removeEventListener(MouseEvent.CLICK,this.toFight);
         }
         Tick.instance.removeRender(this.updateTime);
         SeatTipsManager.removeSeat(this.seatTips[0],this.MAP_ID);
         SeatTipsManager.removeSeat(this.seatTips[1],this.MAP_ID);
         SeatTipsManager.removeSeat(this.seatTips[2],this.MAP_ID);
      }
      
      public function setup(param1:MapModel) : void
      {
         this.map = param1;
         ActorManager.showRemoteActor = false;
         this.timeDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         var _loc2_:Boolean = false;
         if(this.ACT_DAY.indexOf(this.timeDate.date) != -1)
         {
            _loc2_ = true;
         }
         if(this.timeDate.fullYear != this.ACT_YEAR || this.timeDate.month != this.ACT_MONTH - 1 || !_loc2_ || this.timeDate.hours != 13)
         {
            return;
         }
         this.minute = this.timeDate.minutes;
         this.currentTurn = Math.floor(this.minute / 5) + 1;
         if(!this.resLib)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("TwelveTurnFight"),LoadType.DOMAIN,this.onLoadComplete);
         }
         else
         {
            DayLimitManager.getDoCount(this.FIGHT_STATE,this.getState);
         }
         Tick.instance.addRender(this.updateTime,10000);
      }
      
      private function getState(param1:uint) : void
      {
         this.fightState = param1;
         this.playSceneMc();
      }
      
      private function updateTime(param1:int) : void
      {
         this.timeDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         var _loc2_:uint = this.timeDate.minutes;
         var _loc3_:uint = Math.floor(_loc2_ / 5) + 1;
         if(this.currentTurn != _loc3_)
         {
            this.currentTurn = _loc3_;
            this.playSceneMc();
         }
         if(this.timeDate.hours >= 14)
         {
            NpcDialog.hide();
            SceneManager.changeScene(SceneType.LOBBY,70);
         }
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this.resLib = new ResourceLibrary(param1.content);
         this.rewardTipsMc = this.resLib.getMovieClip("RewardTipsMc");
         DayLimitManager.getDoCount(this.FIGHT_STATE,this.getState);
      }
      
      private function playSceneMc() : void
      {
         var mcName:String = null;
         var diaString:String = null;
         var okString:String = null;
         var npcName:String = null;
         var npcID:int = 0;
         this.map.front.addChild(this.rewardTipsMc);
         this.rewardTipsMc.turnTxt.text = "第" + this.currentTurn + "轮对战开始";
         if(this.currentTurn < 12)
         {
            if(this.currentTurn % 2 != 0)
            {
               mcName = "SingleTimeMc";
               diaString = "紫电，你还是老老实实回去吧！";
               okString = "让我来试一下！";
               this.actIndex = 0;
               npcName = this.PET_DIA_NAME1;
               npcID = int(this.PET_DIA_ID1);
            }
            else
            {
               mcName = "DoubleTimeMc";
               diaString = "哈哈哈！电魂巴图，我依然是帝国最强电系精灵！  ";
               okString = "紫电，看我的！";
               this.actIndex = 1;
               npcName = this.PET_DIA_NAME2;
               npcID = int(this.PET_DIA_ID2);
            }
            switch(this.currentTurn)
            {
               case 1:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2 ";
                  break;
               case 2:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 3:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 4:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 5:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n初级资质果实，学习力精片，五万经验券";
                  break;
               case 6:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 7:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 8:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 9:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n1级物攻药剂，1级特攻药剂，经验芯片5k*2";
                  break;
               case 10:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n初级资质果实，学习力精片，五万经验券";
                  break;
               case 11:
                  this.rewardTipsMc.rewardTxt.text = "当前奖励:\n麻痹纹章,初级资质果实，学习力精片，五万经验券";
            }
         }
         else
         {
            npcName = this.PET_DIA_NAME3;
            mcName = "LastTimeMc";
            diaString = "哈哈哈！电魂巴图，我依然是帝国最强电系精灵！ ";
            okString = "紫电，看我的！";
            this.actIndex = 1;
            npcID = int(this.PET_DIA_ID3);
            this.rewardTipsMc.rewardTxt.text = "当前奖励:\n紫煞之芯,初级资质果实，学习力精片，五万经验券";
         }
         if(this.sceneMc)
         {
            DisplayObjectUtil.removeFromParent(this.sceneMc);
            this.sceneMc.stop();
         }
         if(!BitUtil.getBit(this.fightState,this.currentTurn - 1))
         {
            if(!this.sceneMc || this.sceneMc.name != mcName)
            {
               this.sceneMc = this.resLib.getMovieClip(mcName);
               this.sceneMc.name = mcName;
            }
            this.map.front.addChild(this.sceneMc);
            MovieClipUtil.playMc(this.sceneMc,1,this.sceneMc.totalFrames,function():void
            {
               if(currentNpc)
               {
                  currentNpc.buttonMode = false;
                  currentNpc.removeEventListener(MouseEvent.CLICK,toFight);
               }
               sceneMc.stop();
               NpcDialog.show(npcID,npcName,[[0,diaString]],[okString],[function():void
               {
                  currentNpc = sceneMc["Npc" + actIndex];
                  currentNpc.buttonMode = true;
                  currentNpc.addEventListener(MouseEvent.CLICK,toFight);
                  SeatTipsManager.registerSeat(seatTips[actIndex],MAP_ID);
               }]);
            },true);
         }
         else
         {
            this.sceneMc = this.resLib.getMovieClip("NormalStateMc");
            this.sceneMc.name = "NormalStateMc";
            this.sceneMc.gotoAndStop(this.sceneMc.totalFrames);
            this.currentNpc = this.sceneMc["Npc" + this.actIndex];
            this.currentNpc.buttonMode = true;
            this.currentNpc.addEventListener(MouseEvent.CLICK,this.toFight);
            this.map.front.addChild(this.sceneMc);
         }
      }
      
      protected function toFight(param1:MouseEvent) : void
      {
         if(BitUtil.getBit(this.fightState,this.currentTurn - 1))
         {
            if(this.currentTurn % 2 != 0)
            {
               NpcDialog.show(this.PET_DIA_ID1,this.PET_DIA_NAME1,[[0,"每5分钟可以挑战我们其中一个。紫电，如今的我是不会被你战胜的！"]],["那你可得加油咯！"]);
            }
            else
            {
               NpcDialog.show(this.PET_DIA_ID2,this.PET_DIA_NAME2,[[0,"每5分钟可以挑战我们其中一个。为了尊严而战，我才是帝国最强电系精灵！"]],["你的话说的太早了！"]);
            }
            return;
         }
         SeatTipsManager.removeSeat(this.seatTips[this.actIndex],this.MAP_ID);
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.fightOver);
         FightManager.startFightWithWild(this.FIGHT_LIST[this.actIndex]);
      }
      
      protected function fightOver(param1:Event) : void
      {
         FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.fightOver);
         if(this.currentTurn % 2 != 0)
         {
            NpcDialog.show(this.PET_DIA_ID1,this.PET_DIA_NAME1,[[0,"实力不错嘛！看样子你是一个可敬的对手！"]],["太棒啦！"],[this.checkTime]);
         }
         else if(this.currentTurn % 2 == 0 && this.currentTurn != 12)
         {
            NpcDialog.show(this.PET_DIA_ID2,this.PET_DIA_NAME2,[[0,"挺厉害嘛！不能太小看你了。"]],["你也不错！"],[this.checkTime]);
         }
         else
         {
            NpcDialog.show(this.PET_DIA_ID3,this.PET_DIA_NAME3,[[0,"实力不错嘛！看样子你是一个可敬的对手！"]],["太棒啦！"],[this.completeAct]);
         }
      }
      
      private function completeAct() : void
      {
         if(this.sceneMc)
         {
            DisplayObjectUtil.removeFromParent(this.sceneMc);
         }
         this.sceneMc = this.resLib.getMovieClip("LastTimeWinMc");
         this.map.front.addChild(this.sceneMc);
         MovieClipUtil.playMc(this.sceneMc,1,this.sceneMc.totalFrames,function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"赛尔",[[0,"没想到紫电也突破了自己的极限，成为了银脉紫煞！"]],["真是太帅了！"],[function():void
            {
               NpcDialog.show(648,"银脉紫煞",[[0,"我终于感受到超进化后，身体中源源不断的力量！"]],["真希望你们都能成为正义的伙伴！"],[function():void
               {
                  NpcDialog.hide();
                  SceneManager.changeScene(SceneType.LOBBY,70);
               }]);
            }]);
         },true);
      }
      
      private function checkTime() : void
      {
         this.timeDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         if(this.timeDate.hours >= 14)
         {
            NpcDialog.hide();
            SceneManager.changeScene(SceneType.LOBBY,70);
         }
      }
   }
}
