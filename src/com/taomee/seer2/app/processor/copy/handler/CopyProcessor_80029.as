package com.taomee.seer2.app.processor.copy.handler
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.info.CopyItemInfo;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.copy.CopyProcessor;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class CopyProcessor_80029 extends CopyProcessor
   {
       
      
      private var _npc3:MovieClip;
      
      private var _boss1:MovieClip;
      
      private var _boss2:MovieClip;
      
      private var _boss3:MovieClip;
      
      private var _boss4:MovieClip;
      
      private var _mouseHint:Sprite;
      
      private const POS_LIST:Array = [[214,340],[330,100],[554,289],[450,281],[310,279]];
      
      private const FIGHT_INDEX:Vector.<int> = Vector.<int>([469,471,472,473,470]);
      
      private var _curIndex:int = 0;
      
      public function CopyProcessor_80029(param1:CopyItemInfo)
      {
         super(param1);
      }
      
      override protected function tatisticsHandle() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_489);
      }
      
      override public function returnSceneHandle() : void
      {
         if(this._npc3)
         {
            _mapModel.content.addChild(this._npc3);
            this._npc3["content"].play();
         }
         if(this._boss1)
         {
            _mapModel.content.addChild(this._boss1);
            this._boss1["content"].play();
         }
         if(this._boss2)
         {
            if(this._boss2.currentFrame == 1)
            {
               (this._boss2["content"] as MovieClip).play();
            }
            _mapModel.content.addChild(this._boss2);
         }
         if(this._boss3)
         {
            if(this._boss3.currentFrame == 1)
            {
               (this._boss3["content"] as MovieClip).play();
            }
            _mapModel.content.addChild(this._boss3);
         }
         if(this._boss4)
         {
            if(this._boss4.currentFrame == 1)
            {
               (this._boss4["content"] as MovieClip).play();
            }
            _mapModel.content.addChild(this._boss4);
         }
      }
      
      override public function onAnimationLoaded() : void
      {
         this._npc3 = getResFromDomain("npc_3");
         (this._npc3["mark"] as MovieClip).visible = false;
         this._npc3.x = this.POS_LIST[0][0];
         this._npc3.y = this.POS_LIST[0][1];
         _mapModel.content.addChild(this._npc3);
         this._boss1 = getResFromDomain("boss_1");
         this._boss1.x = this.POS_LIST[1][0];
         this._boss1.y = this.POS_LIST[1][1];
         (this._boss1["mark"] as MovieClip).visible = false;
         _mapModel.content.addChild(this._boss1);
         this._boss2 = getResFromDomain("boss_2");
         this._boss2.x = this.POS_LIST[2][0];
         this._boss2.y = this.POS_LIST[2][1];
         _mapModel.content.addChild(this._boss2);
         this._boss3 = getResFromDomain("boss_3");
         this._boss3.x = this.POS_LIST[3][0];
         this._boss3.y = this.POS_LIST[3][1];
         _mapModel.content.addChild(this._boss3);
         this._boss4 = getResFromDomain("boss_4");
         this._boss4.x = this.POS_LIST[4][0];
         this._boss4.y = this.POS_LIST[4][1];
         _mapModel.content.addChild(this._boss4);
         this.cartoonHandle("","sceneTalk_1",null,function():void
         {
            _boss2.buttonMode = true;
            showMouseHintAtMonster(_boss2);
            _boss2.addEventListener(MouseEvent.CLICK,onBossClick);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         });
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var index:int = 0;
         var posIndex:int = 0;
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            index = int(FightManager.currentFightRecord.initData.positionIndex);
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               if(this.FIGHT_INDEX.indexOf(index) != -1)
               {
                  posIndex = this.FIGHT_INDEX.indexOf(index);
                  if(posIndex != 4)
                  {
                     this._curIndex = posIndex;
                  }
                  this.winHandle(posIndex);
               }
            }
            else
            {
               if(this.FIGHT_INDEX.indexOf(index) <= 2)
               {
                  this.cartoonHandle("","sceneTalk_5",null,function():void
                  {
                     FightManager.startFightWithWild(FIGHT_INDEX[4]);
                  });
               }
               if(this.FIGHT_INDEX.indexOf(index) == 4)
               {
                  this._curIndex = 0;
                  this.hideMouseHint();
                  this._boss2.gotoAndStop(1);
                  this._boss3.gotoAndStop(1);
                  this._boss4.gotoAndStop(1);
                  this._boss2.buttonMode = this._boss3.buttonMode = this._boss4.buttonMode = false;
                  this._boss2.removeEventListener(MouseEvent.CLICK,this.onBossClick);
                  this._boss3.removeEventListener(MouseEvent.CLICK,this.onBossClick);
                  this._boss4.removeEventListener(MouseEvent.CLICK,this.onBossClick);
                  this._boss2.buttonMode = true;
                  this.showMouseHintAtMonster(this._boss2);
                  this._boss2.addEventListener(MouseEvent.CLICK,this.onBossClick);
               }
            }
         }
      }
      
      private function winHandle(param1:int) : void
      {
         var fightIndex:int = param1;
         if(fightIndex == 0)
         {
            this._boss2.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            this._boss2.buttonMode = false;
            this.hideMouseHint();
            this._boss2.gotoAndStop(2);
            this.cartoonHandle("","sceneTalk_2",null,function():void
            {
               _boss3.buttonMode = true;
               showMouseHintAtMonster(_boss3);
               _boss3.addEventListener(MouseEvent.CLICK,onBossClick);
            });
         }
         else if(fightIndex == 1)
         {
            this._boss3.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            this._boss3.buttonMode = false;
            this.hideMouseHint();
            this._boss3.gotoAndStop(2);
            this.cartoonHandle("","sceneTalk_3",null,function():void
            {
               _boss4.buttonMode = true;
               showMouseHintAtMonster(_boss4);
               _boss4.addEventListener(MouseEvent.CLICK,onBossClick);
            });
         }
         else if(fightIndex == 2)
         {
            this._boss4.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            this._boss4.buttonMode = false;
            this.hideMouseHint();
            this._boss4.gotoAndStop(2);
            this.cartoonHandle("","sceneTalk_4",null,function():void
            {
               cartoonHandle("80028_2","",function():void
               {
                  DisplayUtil.removeForParent(_boss2);
                  _boss2 = null;
                  DisplayUtil.removeForParent(_boss3);
                  _boss3 = null;
                  DisplayUtil.removeForParent(_boss4);
                  _boss4 = null;
                  _boss1.buttonMode = true;
                  _boss1.addEventListener(MouseEvent.CLICK,onBoss1DialogClick1);
               });
            });
         }
         else if(fightIndex == 3)
         {
            this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1DialogClick1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
            completeTipShow(1,1,"傲慢之芯");
         }
         else if(fightIndex == 4)
         {
         }
      }
      
      private function showMouseHintAtMonster(param1:MovieClip) : void
      {
         this.hideMouseHint();
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -this._mouseHint.height + 50;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 + 27;
         param1.addChild(this._mouseHint);
      }
      
      private function hideMouseHint() : void
      {
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
            this._mouseHint = null;
         }
      }
      
      private function onBoss1DialogClick1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(587,"伊利丹",[[0,"哈哈哈！到此为止了！做好失败的领悟了吗！"]],["来吧恶魔！！","我要准备一下！"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX[3]);
         }]);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this._boss2:
               FightManager.startFightWithWild(this.FIGHT_INDEX[0]);
               break;
            case this._boss3:
               FightManager.startFightWithWild(this.FIGHT_INDEX[1]);
               break;
            case this._boss4:
               FightManager.startFightWithWild(this.FIGHT_INDEX[2]);
         }
      }
      
      private function cartoonHandle(param1:String, param2:String = "", param3:Function = null, param4:Function = null) : void
      {
         var fullScreenName:String = param1;
         var sceneTalkName:String = param2;
         var fun:Function = param3;
         var fun1:Function = param4;
         MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen(fullScreenName),function():void
         {
            var _scenMc:MovieClip = null;
            if(null != fun)
            {
               fun.call();
            }
            if(sceneTalkName != "")
            {
               _scenMc = getResFromDomain(sceneTalkName);
               _mapModel.front.addChild(_scenMc);
               MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_scenMc);
                  _scenMc = null;
                  if(null != fun1)
                  {
                     fun1.call();
                  }
               },true);
            }
         },true,true,2,false);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.hideMouseHint();
         if(this._npc3)
         {
            DisplayUtil.removeForParent(this._npc3);
            this._npc3 = null;
         }
         if(this._boss1)
         {
            this._boss1.removeEventListener(MouseEvent.CLICK,this.onBoss1DialogClick1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
         }
         if(this._boss2)
         {
            this._boss2.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            DisplayUtil.removeForParent(this._boss2);
            this._boss2 = null;
         }
         if(this._boss3)
         {
            this._boss3.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            DisplayUtil.removeForParent(this._boss3);
            this._boss3 = null;
         }
         if(this._boss4)
         {
            this._boss4.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            DisplayUtil.removeForParent(this._boss4);
            this._boss4 = null;
         }
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
   }
}
