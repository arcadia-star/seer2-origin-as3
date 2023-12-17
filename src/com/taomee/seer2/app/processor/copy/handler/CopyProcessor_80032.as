package com.taomee.seer2.app.processor.copy.handler
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.info.CopyItemInfo;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.copy.CopyProcessor;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class CopyProcessor_80032 extends CopyProcessor
   {
       
      
      private var _npc1:MovieClip;
      
      private var _npc2:MovieClip;
      
      private var _boss1:SimpleButton;
      
      private var _boss2:MovieClip;
      
      private var _boss3:MovieClip;
      
      private var _boss4:MovieClip;
      
      private var _boss5:MovieClip;
      
      private var _boss6:MovieClip;
      
      private var _boss7:MovieClip;
      
      private var _boss8:MovieClip;
      
      private var _mouseHint:Sprite;
      
      private var _buffSp:Sprite;
      
      private const BUFF_FOR:Array = [202347,202348];
      
      private const MI_FOR:Array = [202350,202351];
      
      private const POS_LIST:Array = [[320,135],[781,35],[0,0],[160,385],[140,305],[255,245],[715,380],[740,311],[582,265],[392,212]];
      
      private const FIGHT_INDEX:Vector.<int> = Vector.<int>([492,493,494]);
      
      private var TIP:Vector.<String>;
      
      private const MEE_ID:Vector.<int> = Vector.<int>([603143,603144]);
      
      private const BLOOD_1:String = "blood_1";
      
      private const POWER_1:String = "power_1";
      
      private const BLOOD_2:String = "blood_2";
      
      private const POWER_2:String = "power_2";
      
      private var _boss1Click1:Boolean;
      
      public function CopyProcessor_80032(param1:CopyItemInfo)
      {
         this.TIP = Vector.<String>(["是否花费进入至尊挑战，<font color=\'#ff0000\'>" + "获得本场战斗胜利" + "</font>，可在同样的难度下获得<font color=\'#ff0000\'>" + "150倍" + "</font>体力提升","是否花费进入至尊挑战，可在同样的难度下获得<font color=\'#ff0000\'>" + "150倍" + "</font>战斗力提升"]);
         super(param1);
         this.TIP[0] = "是否花费" + ShopManager.getReallyNum(6) + ShopManager.getReallyName() + "进入至尊挑战，<font color=\'#ff0000\'>" + "获得本场战斗胜利" + "</font>，可在同样的难度下获得<font color=\'#ff0000\'>" + "150倍" + "</font>体力提升";
         this.TIP[1] = "是否花费" + ShopManager.getReallyNum(6) + ShopManager.getReallyName() + "进入至尊挑战，可在同样的难度下获得<font color=\'#ff0000\'>" + "150倍" + "</font>战斗力提升";
      }
      
      override protected function tatisticsHandle() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_509);
      }
      
      override public function returnSceneHandle() : void
      {
         if(this._boss1)
         {
            this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1Click);
            this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1Click1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
         }
         if(!isComplete)
         {
            this._boss1 = _mapModel.content["boss1"];
            if(this._boss1Click1)
            {
               this._boss1.addEventListener(MouseEvent.CLICK,this.onBoss1Click1);
            }
         }
         if(this._npc1)
         {
            this._npc1.play();
            _mapModel.content.addChild(this._npc1);
         }
         if(this._npc2)
         {
            this._npc2.play();
            _mapModel.content.addChild(this._npc2);
         }
         if(this._boss2)
         {
            this._boss2.play();
            _mapModel.content.addChild(this._boss2);
         }
         if(this._boss3)
         {
            this._boss3.play();
            _mapModel.content.addChild(this._boss3);
         }
         if(this._boss4)
         {
            this._boss4.play();
            _mapModel.content.addChild(this._boss4);
         }
         if(this._boss5)
         {
            this._boss5.play();
            _mapModel.content.addChild(this._boss5);
         }
         if(this._boss6)
         {
            this._boss6.play();
            _mapModel.content.addChild(this._boss6);
         }
         if(this._boss7)
         {
            this._boss7.play();
            _mapModel.content.addChild(this._boss7);
         }
         if(this._boss8)
         {
            this._boss8.play();
            _mapModel.content.addChild(this._boss8);
         }
      }
      
      private function payStartFight(param1:int, param2:int, param3:String) : void
      {
         var meeId:int = param1;
         var posIndex:int = param2;
         var tip:String = param3;
         ActiveCountManager.requestActiveCount(this.MI_FOR[this.MEE_ID.indexOf(meeId)],function(param1:int, param2:int):void
         {
            var type:int = param1;
            var num:int = param2;
            if(num > 0)
            {
               FightManager.startFightWithBoss(posIndex);
            }
            else
            {
               AlertManager.showConfirm(tip,function():void
               {
                  ShopManager.checkReally(6,function(param1:Boolean):void
                  {
                     var b:Boolean = param1;
                     if(b)
                     {
                        PayManager.buyItem(meeId,function():void
                        {
                           FightManager.startFightWithBoss(posIndex);
                        });
                     }
                     else
                     {
                        unHaveConfirm();
                     }
                  });
               });
            }
         });
      }
      
      private function unHaveConfirm() : void
      {
         AlertManager.showConfirm("星钻不够：钱包里的星钻不够咯，快去充值吧。",function():void
         {
            VipManager.entryMi();
         });
      }
      
      private function addMark(param1:DisplayObjectContainer, param2:String, param3:Vector.<int> = null) : void
      {
         var _loc4_:MovieClip = getResFromDomain(param2);
         if(null == param3)
         {
            _loc4_.y = -param1.height + 50;
            _loc4_.x = (param1.width - param1.width) / 2 + 27;
         }
         else
         {
            _loc4_.y = param3[1];
            _loc4_.x = param3[0];
         }
         param1.addChild(_loc4_);
      }
      
      override public function onAnimationLoaded() : void
      {
         this._buffSp = new Sprite();
         this._npc1 = getResFromDomain("npc_2");
         this._npc1.x = this.POS_LIST[0][0];
         this._npc1.y = this.POS_LIST[0][1];
         _mapModel.content.addChild(this._npc1);
         this._npc2 = getResFromDomain("npc_3");
         this._npc2.scaleX = -1;
         this._npc2.x = this.POS_LIST[1][0];
         this._npc2.y = this.POS_LIST[1][1];
         _mapModel.content.addChild(this._npc2);
         this._boss1 = _mapModel.content["boss1"];
         this._boss1.addEventListener(MouseEvent.CLICK,this.onBoss1Click);
         this.updateBuffShow();
      }
      
      private function onBoss1Click(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(589,"撒旦",[[0,"让我再次召唤我的仆从吧！它们会接受我的力量！你们必将葬身此地！ "]],["来吧！"],[function():void
         {
            var anima:* = undefined;
            _boss1.removeEventListener(MouseEvent.CLICK,onBoss1Click);
            (_mapModel.content["mark"] as MovieClip).visible = false;
            anima = getResFromDomain("sceneAnima_2");
            _mapModel.front.addChild(anima);
            MovieClipUtil.playMc(anima,2,anima.totalFrames,function():void
            {
               DisplayUtil.removeForParent(anima);
               anima = null;
               (_mapModel.content["mark"] as MovieClip).visible = true;
               _boss2 = getResFromDomain("boss_2");
               _boss2.x = POS_LIST[3][0];
               _boss2.y = POS_LIST[3][1];
               _mapModel.content.addChild(_boss2);
               _boss3 = getResFromDomain("boss_3");
               _boss3.x = POS_LIST[4][0];
               _boss3.y = POS_LIST[4][1];
               _mapModel.content.addChild(_boss3);
               _boss4 = getResFromDomain("boss_4");
               _boss4.x = POS_LIST[5][0];
               _boss4.y = POS_LIST[5][1];
               _mapModel.content.addChild(_boss4);
               _boss5 = getResFromDomain("boss_5");
               _boss5.x = POS_LIST[6][0];
               _boss5.y = POS_LIST[6][1];
               _mapModel.content.addChild(_boss5);
               _boss6 = getResFromDomain("boss_6");
               _boss6.x = POS_LIST[7][0];
               _boss6.y = POS_LIST[7][1];
               _mapModel.content.addChild(_boss6);
               _boss7 = getResFromDomain("boss_7");
               _boss7.x = POS_LIST[8][0];
               _boss7.y = POS_LIST[8][1];
               _mapModel.content.addChild(_boss7);
               _boss8 = getResFromDomain("boss_8");
               _boss8.x = POS_LIST[9][0];
               _boss8.y = POS_LIST[9][1];
               _mapModel.content.addChild(_boss8);
               addMark(_boss2,BLOOD_1);
               addMark(_boss3,BLOOD_1);
               addMark(_boss4,BLOOD_1,Vector.<int>([40,-15]));
               addMark(_boss5,POWER_1);
               addMark(_boss6,POWER_1);
               addMark(_boss7,POWER_1);
               addMark(_boss8,POWER_1,Vector.<int>([70,5]));
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
               showMouseHintAtMonster(_boss4);
               _boss4.buttonMode = true;
               _boss4.addEventListener(MouseEvent.CLICK,onBoss4Click);
               showMouseHintAtMonster(_boss8);
               _boss8.buttonMode = true;
               _boss8.addEventListener(MouseEvent.CLICK,onBoss8Click);
               _boss1Click1 = true;
               _boss1.addEventListener(MouseEvent.CLICK,onBoss1Click1);
            });
         }]);
      }
      
      private function onBoss1Click1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(589,"撒旦",[[0,"你做好挑战我的准备了吗？！（最好携带冥王血气和冥王巨力状态）"]],["开始挑战！","准备一下！"],[function():void
         {
            FightManager.startFightWithBoss(FIGHT_INDEX[2]);
         }]);
      }
      
      private function onBoss4Click(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(589,"撒旦",[[0,"他们获得了我赐予的100倍的体力！如果你获得本场战斗胜利就可以继承这个力量！"]],["开始挑战！","至尊挑战！","准备一下！"],[function():void
         {
            FightManager.startFightWithBoss(FIGHT_INDEX[0]);
         },function():void
         {
            payStartFight(MEE_ID[0],FIGHT_INDEX[0],TIP[0]);
         }]);
      }
      
      private function onBoss8Click(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(589,"撒旦",[[0,"他们带有我赐予的100倍战斗力！如果你获得本场战斗胜利就可以继承这个力量！"]],["开始挑战！","至尊挑战！","准备一下！"],[function():void
         {
            FightManager.startFightWithBoss(FIGHT_INDEX[1]);
         },function():void
         {
            payStartFight(MEE_ID[1],FIGHT_INDEX[1],TIP[1]);
         }]);
      }
      
      private function showMouseHintAtMonster(param1:MovieClip) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -this._mouseHint.height + 50;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 + 27;
         param1.addChild(this._mouseHint);
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var _loc2_:int = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            _loc2_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.winHandle(_loc2_);
            }
            else
            {
               this.failHandle(_loc2_);
            }
            this.updateBuffShow();
         }
      }
      
      private function winHandle(param1:int) : void
      {
         var fightIndex:int = param1;
         if(fightIndex == this.FIGHT_INDEX[0])
         {
            this._boss4.removeEventListener(MouseEvent.CLICK,this.onBoss4Click);
            DisplayUtil.removeForParent(this._boss4);
            this._boss4 = null;
            DisplayUtil.removeForParent(this._boss2);
            this._boss2 = null;
            DisplayUtil.removeForParent(this._boss3);
            this._boss3 = null;
         }
         if(fightIndex == this.FIGHT_INDEX[1])
         {
            this._boss8.removeEventListener(MouseEvent.CLICK,this.onBoss8Click);
            DisplayUtil.removeForParent(this._boss8);
            this._boss8 = null;
            DisplayUtil.removeForParent(this._boss7);
            this._boss7 = null;
            DisplayUtil.removeForParent(this._boss6);
            this._boss6 = null;
            DisplayUtil.removeForParent(this._boss5);
            this._boss5 = null;
         }
         if(fightIndex == this.FIGHT_INDEX[2])
         {
            if(this._boss1)
            {
               this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1Click1);
               this._boss1 = null;
            }
            this._boss1Click1 = false;
            DisplayUtil.removeForParent(_mapModel.content["boss1"]);
            if(this._npc1)
            {
               DisplayUtil.removeForParent(this._npc1);
               this._npc1 = null;
            }
            if(this._npc2)
            {
               DisplayUtil.removeForParent(this._npc2);
               this._npc2 = null;
            }
            if(this._boss2)
            {
               DisplayUtil.removeForParent(this._boss2);
               this._boss2 = null;
            }
            if(this._boss3)
            {
               DisplayUtil.removeForParent(this._boss3);
               this._boss3 = null;
            }
            if(this._boss4)
            {
               this._boss4.removeEventListener(MouseEvent.CLICK,this.onBoss4Click);
               DisplayUtil.removeForParent(this._boss4);
               this._boss4 = null;
            }
            if(this._boss5)
            {
               DisplayUtil.removeForParent(this._boss5);
               this._boss5 = null;
            }
            if(this._boss6)
            {
               DisplayUtil.removeForParent(this._boss6);
               this._boss6 = null;
            }
            if(this._boss7)
            {
               DisplayUtil.removeForParent(this._boss7);
               this._boss7 = null;
            }
            if(this._boss8)
            {
               this._boss8.removeEventListener(MouseEvent.CLICK,this.onBoss8Click);
               DisplayUtil.removeForParent(this._boss8);
               this._boss8 = null;
            }
            (_mapModel.content["mark"] as MovieClip).visible = false;
            sceneAnimationHandle("80031_3","",function():void
            {
               completeTipShow(1,8,"忏悔之心");
            });
         }
      }
      
      private function updateBuffShow(param1:Array = null) : void
      {
         var buffBg:MovieClip = null;
         var testParam:Array = param1;
         if(testParam != null)
         {
            this.removeSelf();
            if(testParam[0] > 0 && testParam[1] > 0)
            {
               buffBg = getResFromDomain("buffBg");
               buffBg.x = -buffBg.width / 2 + 20;
               buffBg.y = -130;
               this._buffSp.addChild(buffBg);
               this.addMark(this._buffSp,"blood_" + testParam[0],Vector.<int>([-40,-105]));
               this.addMark(this._buffSp,"power_" + testParam[1],Vector.<int>([-13,-105]));
               DisplayObjectContainer(ActorManager.getActor().animation).addChild(this._buffSp);
            }
            else
            {
               if(testParam[0] == 0 && testParam[1] == 0)
               {
                  return;
               }
               buffBg = getResFromDomain("buffBg");
               buffBg.x = -buffBg.width / 2 + 20;
               buffBg.y = -130;
               this._buffSp.addChild(buffBg);
               if(testParam[0] > 0)
               {
                  this.addMark(this._buffSp,"blood_" + testParam[0],Vector.<int>([-23,-105]));
               }
               if(testParam[1] > 0)
               {
                  this.addMark(this._buffSp,"power_" + testParam[1],Vector.<int>([-23,-105]));
               }
               DisplayObjectContainer(ActorManager.getActor().animation).addChild(this._buffSp);
            }
            return;
         }
         ActiveCountManager.requestActiveCountList(this.BUFF_FOR,function(param1:Parser_1142):void
         {
            var _loc2_:MovieClip = null;
            removeSelf();
            if(param1.infoVec[0] > 0 && param1.infoVec[1] > 0)
            {
               _loc2_ = getResFromDomain("buffBg");
               _loc2_.x = -_loc2_.width / 2 + 20;
               _loc2_.y = -130;
               _buffSp.addChild(_loc2_);
               addMark(_buffSp,"blood_" + param1.infoVec[0],Vector.<int>([-40,-105]));
               addMark(_buffSp,"power_" + param1.infoVec[1],Vector.<int>([-13,-105]));
               DisplayObjectContainer(ActorManager.getActor().animation).addChild(_buffSp);
            }
            else
            {
               if(param1.infoVec[0] == 0 && param1.infoVec[1] == 0)
               {
                  return;
               }
               _loc2_ = getResFromDomain("buffBg");
               _loc2_.x = -_loc2_.width / 2 + 20;
               _loc2_.y = -130;
               _buffSp.addChild(_loc2_);
               if(param1.infoVec[0] > 0)
               {
                  addMark(_buffSp,"blood_" + param1.infoVec[0],Vector.<int>([-23,-105]));
               }
               if(param1.infoVec[1] > 0)
               {
                  addMark(_buffSp,"power_" + param1.infoVec[1],Vector.<int>([-23,-105]));
               }
               DisplayObjectContainer(ActorManager.getActor().animation).addChild(_buffSp);
            }
         });
      }
      
      private function removeSelf() : void
      {
         while(this._buffSp.numChildren > 0)
         {
            this._buffSp.removeChildAt(0);
         }
         DisplayUtil.removeForParent(this._buffSp);
      }
      
      private function failHandle(param1:int) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.removeSelf();
         this._buffSp = null;
         if(this._npc1)
         {
            DisplayUtil.removeForParent(this._npc1);
            this._npc1 = null;
         }
         if(this._npc2)
         {
            DisplayUtil.removeForParent(this._npc2);
            this._npc2 = null;
         }
         if(this._boss1)
         {
            this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1Click);
            this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1Click1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
         }
         if(this._boss2)
         {
            DisplayUtil.removeForParent(this._boss2);
            this._boss2 = null;
         }
         if(this._boss3)
         {
            DisplayUtil.removeForParent(this._boss3);
            this._boss3 = null;
         }
         if(this._boss4)
         {
            this._boss4.removeEventListener(MouseEvent.CLICK,this.onBoss4Click);
            DisplayUtil.removeForParent(this._boss4);
            this._boss4 = null;
         }
         if(this._boss5)
         {
            DisplayUtil.removeForParent(this._boss5);
            this._boss5 = null;
         }
         if(this._boss6)
         {
            DisplayUtil.removeForParent(this._boss6);
            this._boss6 = null;
         }
         if(this._boss7)
         {
            DisplayUtil.removeForParent(this._boss7);
            this._boss7 = null;
         }
         if(this._boss8)
         {
            this._boss8.removeEventListener(MouseEvent.CLICK,this.onBoss8Click);
            DisplayUtil.removeForParent(this._boss8);
            this._boss8 = null;
         }
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
   }
}
