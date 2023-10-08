package com.taomee.seer2.app.processor.quest.handler.story.quest21
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_21_5207 extends QuestMapHandler
   {
       
      
      private var _landeAnimation:MovieClip;
      
      private var _diziAnimation:MovieClip;
      
      private var _leaveAnimation:MovieClip;
      
      public function QuestMapHandler_21_5207(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.status == QuestStatus.IN_PROGRESS)
         {
            if(Boolean(_quest.isStepCompete(2)) && !_quest.isStepCompete(3))
            {
               this.processStep3();
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._landeAnimation)
         {
            this._landeAnimation.removeEventListener(MouseEvent.CLICK,this.onLandeClick);
         }
         super.processMapDispose();
      }
      
      private function processStep3() : void
      {
         this._landeAnimation = _processor.resLib.getMovieClip("mc_4");
         this._diziAnimation = _processor.resLib.getMovieClip("mc_5");
         this._leaveAnimation = _processor.resLib.getMovieClip("mc_6");
         _map.front.addChild(this._landeAnimation);
         DisplayObjectUtil.enableButtonMode(this._landeAnimation);
         this._landeAnimation.addEventListener(MouseEvent.CLICK,this.onLandeClick);
      }
      
      private function onLandeClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         DisplayObjectUtil.disableButtonMode(this._landeAnimation);
         this._landeAnimation.removeEventListener(MouseEvent.CLICK,this.onLandeClick);
         NpcDialog.show(51,"兰德",[[0,"大板牙叔叔，你就让我也吹吹那个笛子吧！！"]],["啥笛子呀？"],[function():void
         {
            NpcDialog.show(51,"兰德",[[1,"嗯！大板牙叔叔有一个魔笛！每当笛声响起，就会有一个古怪的精灵出现呢~~"]],["哦？我也想看看！"],[function():void
            {
               NpcDialog.show(42,"大板牙",[[3,"不行不行！兰德，你别总跟沙爪的小鬼走得那么近，小心你的屁股再一次被打肿！"]],["哎？"],[function():void
               {
                  NpcDialog.show(51,"兰德",[[1,"可是，大板牙叔叔，上次大金牙叔叔说你……"],[1,"不给我吹笛子我就不告诉你！！！"]],["……"],[function():void
                  {
                     NpcDialog.show(42,"大板牙",[[3,"………………拿去！就一次！赶紧吹完告诉我，大金牙到底说了我什么！"]],["快吹快吹~~"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_landeAnimation);
                        _map.front.addChild(_diziAnimation);
                        MovieClipUtil.playMc(_diziAnimation,1,_diziAnimation.totalFrames,function():void
                        {
                           DisplayObjectUtil.removeFromParent(_diziAnimation);
                           NpcDialog.show(42,"大板牙",[[0,"好了吧？快告诉我，大金牙说什么了？"]],["急性子大叔！"],[function():void
                           {
                              NpcDialog.show(51,"兰德",[[1,"大金牙叔叔说……就算把板牙换成金牙，大板牙叔叔也成不了大富翁，还是一样要在路边吹笛子！哈哈哈……"]],["哈哈……"],[function():void
                              {
                                 NpcDialog.show(42,"大板牙",[[3,"大金牙那家伙！！他又能好到哪儿去？？除了那颗金牙，他也没什么值钱的东西了！"]],["（也好过你的板牙~）"],[function():void
                                 {
                                    NpcDialog.show(51,"兰德",[[1,"哇~~吹笛子的大板牙生气了！我们快走吧！去终点站，实验禁地！"]],["（去实验禁地！）"],[function():void
                                    {
                                       _map.front.addChild(_leaveAnimation);
                                       MovieClipUtil.playMc(_leaveAnimation,1,_leaveAnimation.totalFrames,function():void
                                       {
                                          DisplayObjectUtil.removeFromParent(_leaveAnimation);
                                          _processor.showMouseHintAt(652,149);
                                          QuestManager.completeStep(_quest.id,3);
                                       },true);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        },true);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
